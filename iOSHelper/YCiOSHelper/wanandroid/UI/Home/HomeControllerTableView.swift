//
//  HomeControllerTableView.swift
//  YCiOSHelper
//
//  Created by 杨充 on 2024/12/17.
//

import Foundation
import UIKit

//设置一个协议
public protocol HomeTableDelegate: NSObjectProtocol {
    //控制悬浮按钮的状态
    //forHide，是否隐藏
    //withAnimal，是否动画
    func floatStatus(forHide hide: Bool, withAnimal animal: Bool)
}

class HomeControllerTableView: UITableView {
    
    //weak 是一个修饰符（modifier），用于声明一个弱引用（weak reference）。
    //弱引用是一种特殊类型的引用，它不会增加被引用对象的引用计数。
    //当被引用对象的引用计数为零时，弱引用会自动被设置为 nil，避免了循环引用（retain cycle）的问题。
    //通过使用 weak 修饰符，我们可以避免循环引用的问题，确保在不再需要引用时，对象能够被正确地释放。
    weak open var homeTableDelegate: HomeTableDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        //addObserver(_:forKeyPath:options:context:) 方法来观察 UITableView 的属性或键路径的变化。
        //将当前视图控制器（self）作为观察者添加到 UITableView 上，观察其 contentOffset 属性的变化。
        self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    deinit {
        //在视图控制器被释放时
        //使用 removeObserver(_:forKeyPath:) 方法将观察者从 UITableView 上移除，以避免潜在的内存泄漏。
        self.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let offset = change?[NSKeyValueChangeKey.newKey] as! CGPoint
        print("\(offset.y)")
        if offset.y > 400.0 && offset.y < 1000.0 {
            homeTableDelegate?.floatStatus(forHide: false, withAnimal: true)
        } else if offset.y > 1000.0 {
            homeTableDelegate?.floatStatus(forHide: false, withAnimal: false)
        } else {
            homeTableDelegate?.floatStatus(forHide: true, withAnimal: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
