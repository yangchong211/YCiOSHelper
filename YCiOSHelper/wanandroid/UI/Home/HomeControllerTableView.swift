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
    
    weak open var homeTableDelegate: HomeTableDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
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
