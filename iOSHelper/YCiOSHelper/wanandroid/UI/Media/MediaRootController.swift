//
//  HomeRootController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/4.
//

import UIKit
import SnapKit

class MediaRootController: UIViewController , MediaContainerControllerDelegate , HomeTabViewDelegate {
    
    //声明我们的容器
    private var containerVc : MediaContainerController!
    //! 是一个后缀操作符，用于表示一个可选类型（Optional）的强制解包（force unwrapping）。
    private var tabView : MediaTabView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //container vc
        containerVc = MediaContainerController();
        containerVc.delegate = self;
        addChildView(childViewController: containerVc) { subview in
            //makeConstraints 方法来设置子视图的约束条件。
            subview.snp.makeConstraints { make in
                make.leading.trailing.top.equalTo(self.view);
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin);
            }
        }
        
        //TabView，需要添加到当前视图上，并且设置布局
        tabView = MediaTabView(items: [.init(index: 0, title: "推荐"),
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

    //MediaContainerControllerDelegate
    func homeContainerController(controller: MediaContainerController , viewControllerAtindexPath: IndexPath) -> UIViewController {
        //let vc = UIViewController();
        //vc.view.backgroundColor = UIColor.randomYcColor;
        let vc = MediaTableViewController();
        return vc;
    }
    
    func numberOfViewControllers(in containerViewContrller: MediaContainerController) -> Int {
        return 2;
    }
    
    
    func homeContainerController(controller: MediaContainerController, didScroll scrollView: UIScrollView) {
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
    
    //HomeTabViewDelegate
    func didselect(item: MediaTabView.Item,in tabView: MediaTabView) {
        containerVc.setPageIndex(index: item.index, animated: true)
    }

}
