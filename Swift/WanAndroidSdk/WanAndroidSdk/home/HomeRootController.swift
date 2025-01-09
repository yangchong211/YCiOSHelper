//
//  HomeRootController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/4.
//

import Foundation
import UIKit
import SnapKit

class HomeRootController: UIViewController , HomeContainerControllerDelegate , HomeTabViewDelegate {
    
    //声明我们的容器
    private var containerVc : HomeContainerController!
    private var tabView : HomeTabView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //container vc
        containerVc = HomeContainerController();
        containerVc.delegate = self;
        addChildView(childViewController: containerVc) { subview in
            subview.snp.makeConstraints { make in
                make.leading.trailing.top.equalTo(self.view);
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin);
            }
        }
        
        //TabView，需要添加到当前视图上，并且设置布局
        tabView = HomeTabView(items: [.init(index: 0, title: "推荐"),
                                      .init(index: 1, title: "关注")] ,
                              delegate: self)
        view.addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }

    func homeContainerController(controller: HomeContainerController , viewControllerAtindexPath: IndexPath) -> UIViewController {
        //let vc = UIViewController();
        //vc.view.backgroundColor = UIColor.randomYcColor;
        let vc = HomeTableViewController();
        return vc;
    }
    
    func numberOfViewControllers(in containerViewContrller: HomeContainerController) -> Int {
        return 2;
    }
    
    func homeContainerController(controller: HomeContainerController, didScroll scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width;
        let contentOffsetX = scrollView.contentOffset.x;
        print("设置切换控制器1   \(pageWidth)")
        print("设置切换控制器2   \(contentOffsetX)")
        guard pageWidth > 0 else {
            return
        }
        let progress = contentOffsetX / pageWidth
        print("设置切换控制器3   \(progress)")
        tabView.updateSelectedIndex(with: progress)
    }
    
    
    func didselect(item: HomeTabView.Item,in tabView: HomeTabView) {
        containerVc.setPageIndex(index: item.index, animated: true)
    }

}
