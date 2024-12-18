//
//  NavigationDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/2.
//

import UIKit

protocol PalmControllerDelegate : AnyObject{
    func sendPalmBack(code: Int, data: String)
}

class NavigationDemoController: UIViewController,UINavigationControllerDelegate {
    
    weak var delegate: PalmControllerDelegate?
    var userId: String? = "";
    var userName: String? = "";
    var appId: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNavigationContronller();
        addView();
    }
    
    func myNavigationContronller() {
        // 1.设置 UINavigationController 的 Title
        self.navigationItem.title = "UINavigationContronller"
        self.view.backgroundColor = UIColor.white;
        
        
        // 2.设置 UIVavigationController 的按钮 Title, Style, Target, Action 等方法属性
        let backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backAction))
        let nextBarButtonItem = UIBarButtonItem(title: "回调", style: .plain, target: self, action: #selector(nextAction))
        
        // 3.设置 UINavigationItem
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationItem.rightBarButtonItem = nextBarButtonItem
        
        // 4.获取 UINavigationController 的顶部的视图控制器
        //        let topView = self.navigationController?.topViewController;
        //print(topView)
        
        // 5.获取 UINavigationController 可见的视图控制器
        //        let visibleView = self.navigationController?.visibleViewController
        //print(visibleView)
        
        // 6.设置 UINavigationController 的导航栏控制器
        //        self.navigationController?.viewControllers
        
        // 7.设置 UINavigationController 的导航栏控制器是否隐藏(默认是 false)
        //        self.navigationController?.isNavigationBarHidden = false
        
        // 8.获取 UINavigationController 的导航栏控制器
        //        let navigationBar = self.navigationController?.navigationBar
        //print(navigationBar)
        
        // 9.设置 UINavigationController 的内置工具栏是否可见(默认是 ture)
        //        self.navigationController?.isToolbarHidden = false
        
        // 10.获取 UINavigationController 的 toolbar
        //        let toolbar = self.navigationController?.toolbar
        //print(toolbar)
        
        // 11.设置 UINavigationController 的代理对象
        //        self.navigationController?.delegate = self
        
        // 12.获取 UINavigationController 的手势识别顶部视图控制器
        //        let pop = self.navigationController?.interactivePopGestureRecognizer
        //print(pop)
        
        // 13.设置 UINavigationController 当键盘出现时是否隐藏导航栏和工具栏
        //        self.navigationController!.hidesBarsWhenKeyboardAppears = true
        
        // 14.设置 UINavigationController 是否使用向上滑动的手势隐藏导航栏和工具栏
        //        self.navigationController?.hidesBarsOnSwipe = false
        
        // 15.获取 UINavigationController 用手势识别隐藏导航栏和工具栏
        //        let barHide = self.navigationController!.barHideOnSwipeGestureRecognizer
        //print(barHide)
        
        // 16.设置 UINavigationController 是否在垂直显示时隐藏
        //        self.navigationController!.hidesBarsWhenVerticallyCompact = false
        
        // 17.设置 UINavigationController 是否使用点击手势来隐藏
        //        self.navigationController?.hidesBarsOnTap = false
        
        // 18.获取 UINavigationController 隐藏时所使用的手势
        //        let barHideOnTap = self.navigationController!.barHideOnTapGestureRecognizer
        //print(barHideOnTap)
        
        // 19.设置 UINavigationController 的导航栏是否隐藏, 是否使用动画
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 20.设置 UINavigationController 的工具栏是否隐藏, 是否使用动画
        //        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    // 1.该方法使用来设置 UINavigationController 将要显示时所调用的方法
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        print("UINavigationController 将要显示")
    }
    
    // 2.该方法使用来设置 UINavigationController 完全显示时所调用的方法
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        print("UINavigationController 完全显示")
    }
    
    // 3.返回按钮的监听方法
    @objc func backAction() {
        print("点击了返回")
        //返回
        self.navigationController?.popViewController(animated: true)
        
        //返回上一级视图控制器
        //        if let previousViewController = self.navigationController?.viewControllers.firstIndex(of: self) {
        //            self.navigationController?.popToViewController(self.navigationController!.viewControllers[previousViewController - 1], animated: true)
        //        }
    }
    
    // 4.下一页按钮的监听方法
    @objc func nextAction() {
        //print("点击了下一页")
        
        //处理回调
        let backCode = 0;
        let backData = "空中录掌刷掌成功啦"
        delegate?.sendPalmBack(code: backCode, data: backData)
        navigationController?.popViewController(animated: true)
    }
    

    private func addView() {
        print("在sdk页面打印，用户传递过来的参数")
        print(userId)
        print(userName)
        print(appId)
    }
}
