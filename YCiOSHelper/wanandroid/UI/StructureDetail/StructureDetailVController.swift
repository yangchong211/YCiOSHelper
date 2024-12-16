//
//  StructureDetailVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/28.
//

import UIKit
import JXSegmentedView

class StructureDetailVController: UIViewController {
    
    private var model: StructureModel?
    
    private var clickIndex: Int?
    
    private let segmentedView = JXSegmentedView()
    
    private let segmentedDataSource = JXSegmentedTitleDataSource()
    
    private lazy var  divLine = UIView().then({ (attr) in
        attr.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    //配置指示器
    private let indicator = JXSegmentedIndicatorLineView()
    
    private lazy var listContainerView:JXSegmentedListContainerView = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    //指示器内容
    private var tabTitles : [String] = []
    
    private var viewControllers: [WechatArticlesVController] = []
    
    convenience init(parentModel model: StructureModel, childClickIndex clickIndex: Int) {
        self.init()
        self.model = model
        self.clickIndex = clickIndex
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        //设置背景色，防止跳转界面视图重叠
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = model?.name
        self.model?.children.forEach({ (value: StructureModel) in
            self.tabTitles.append(value.name)
            self.viewControllers.append(WechatArticlesVController(cid: value.id))
        })
        self.segmentedDataSource.titles = self.tabTitles
        self.segmentedView.dataSource = self.segmentedDataSource
        self.view.addSubview(self.segmentedView)
        self.view.addSubview(self.divLine)
        self.indicator.indicatorWidth = 20
        self.segmentedView.indicators = [self.indicator]
        self.segmentedView.defaultSelectedIndex = self.clickIndex ?? 0
        self.segmentedView.listContainer = self.listContainerView
        self.view.addSubview(self.listContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let navigationHeight = navigationController?.navigationBar.frame.size.height ?? 40
        
        segmentedView.frame = CGRect(x: 0, y: statusBarHeight + navigationHeight, width: screenWidth, height: 50)
        
        divLine.frame = CGRect(x: 0, y: statusBarHeight + navigationHeight + 50, width: screenWidth, height: 1)
        
        listContainerView.frame = CGRect(x: 0, y: statusBarHeight + navigationHeight + 50 + 1, width: screenWidth, height: screenHeight - statusBarHeight - 50 - 1)
    }
}

extension StructureDetailVController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return viewControllers.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return viewControllers[index]
    }
}
