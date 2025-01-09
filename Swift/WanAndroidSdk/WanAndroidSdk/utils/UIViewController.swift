//
//  UIViewController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/4.
//

import Foundation
import UIKit

//UIViewController拓展类
extension UIViewController {
    
    //为当前控制器添加子控制器
    func addChildView(childViewController : UIViewController? , layout: (_ view : UIView) -> Void) {
        //用guard语句判断是否合法
        guard let childViewController = childViewController else {
            return
        }
        
        //添加子视图
        view.addSubview(childViewController.view)
        addChild(childViewController);
        //通知已经加入到父布局上了
        childViewController.didMove(toParent: self);
        //开始布局
        layout(childViewController.view);
    }
    
    func addChildView(_ viewController: UIViewController) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //自定义吐司
    func showToast(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}





