//
//  ProjectVController.swift
//  FunIOS
//
//  Created by 杨充 on 2021/7/21.
//

import UIKit
import SnapKitExtend
import JXSegmentedView

//项目
class ProjectController: UIViewController {

    private let segmentedView = JXSegmentedView()
    
    private let segmentedDataSource = JXSegmentedTitleDataSource()
    
    private lazy var divLine = UIView().then({ (attr) in
        attr.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    //配置指示器
    private let indicator = JXSegmentedIndicatorLineView()
    //list容器
    private lazy var listContainerView:JXSegmentedListContainerView = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    //指示器内容
    private var tabTitles : [String] = []
    //控制器数组
    private var viewControllers: [ProjectArticlesController] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //获取项目分类
        Api.fetchProjectSegmented(success: { (value:Array<StructureModel>?) in
            //遍历数组后，创建tab指示器和控制器Controller
            value?.forEach({ (item: StructureModel) in
                self.tabTitles.append(item.name)
                self.viewControllers.append(ProjectArticlesController(cid: item.id))
            })
            //加载UI
            self.loadUI()
        }, error: error(error:))
    }
    
    private func loadUI() {
        self.segmentedDataSource.titles = self.tabTitles
        self.segmentedView.dataSource = self.segmentedDataSource
        self.view.addSubview(self.segmentedView)
        self.view.addSubview(self.divLine)
        self.indicator.indicatorWidth = 20
        self.segmentedView.indicators = [self.indicator]
        self.segmentedView.listContainer = self.listContainerView
        self.view.addSubview(self.listContainerView)
        
        listContainerView.snp.makeConstraints { make in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight)
            make.top.equalTo(divLine.snp_top).offset(0)
            make.bottom.equalToSuperview().offset(-(49+40))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //指示器
        segmentedView.frame = CGRect(x: 0, y: statusBarHeight, width: screenWidth, height: 50)
        //分割线
        divLine.frame = CGRect(x: 0, y: statusBarHeight + 50, width: screenWidth, height: 1)
        //下面容器位置
        //listContainerView.frame = CGRect(x: 0, y: statusBarHeight + 50 + 1, width: screenWidth, height: screenHeight - statusBarHeight - 50 - 1)
    }
}

//拓展类
extension ProjectController: JXSegmentedListContainerViewDataSource {
    
    //设置控制器的个数
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return viewControllers.count
    }
    
    //设置目标控制器
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return viewControllers[index]
    }
}
