//
//  StructureVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/21.
//

import UIKit
import JXSegmentedView
import SnapKitExtend

class StructrureVController: UIViewController {
    
    private let titles = ["体系", "导航"]
    
    private let segmentedView = JXSegmentedView()
    
    private let segmentedDataSource = JXSegmentedTitleDataSource()
   
    //配置指示器
    private let indicator = JXSegmentedIndicatorBackgroundView()
    
    private lazy var  divLine = UIView().then({ (attr) in
        attr.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    private lazy var listContainerView:JXSegmentedListContainerView = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    private var viewControllers: [StructureListVController] = []
    
    var totalItemWidth: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        totalItemWidth = UIScreen.main.bounds.size.width - 30 * 2
        segmentedDataSource.itemWidth = totalItemWidth / CGFloat(titles.count) / 2
        segmentedDataSource.titles = titles
        segmentedDataSource.isTitleMaskEnabled = true
        segmentedDataSource.titleNormalColor = UIColor.red
        segmentedDataSource.titleSelectedColor = UIColor.white
        segmentedDataSource.itemSpacing = 0
        segmentedView.dataSource = segmentedDataSource
        segmentedView.layer.masksToBounds = true
        segmentedView.layer.cornerRadius = 15
        segmentedView.layer.borderColor = UIColor.red.cgColor
        segmentedView.layer.borderWidth = 1 / UIScreen.main.scale
        
        indicator.indicatorHeight = 30
        indicator.indicatorWidthIncrement = 0
        indicator.indicatorColor = UIColor.red
        
        segmentedView.indicators = [indicator]
        
        titles.forEach { (title) in
            viewControllers.append(StructureListVController(type: title == self.titles[0] ? 1 : 2))
        }
        
        segmentedView.listContainer = listContainerView
        
        view.addSubview(segmentedView)
        view.addSubview(listContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentedView.frame = CGRect(x:screenWidth / 2 - (totalItemWidth / 4), y: statusBarHeight, width: totalItemWidth / 2, height: 30)

        divLine.frame = CGRect(x: 0, y: statusBarHeight + 50, width: screenWidth, height: 1)
        
        listContainerView.frame = CGRect(x: 0, y: statusBarHeight + 30, width: screenWidth, height: screenHeight - statusBarHeight - 30)
    }
    
}

extension StructrureVController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return viewControllers.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return viewControllers[index]
    }
    
    
}
