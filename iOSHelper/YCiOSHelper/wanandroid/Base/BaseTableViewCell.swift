//
//  BaseTableViewCell.swift
//
//  Created by 杨充 on 2021/7/22.
//

import UIKit
import Reusable


// Reusable 是用回收的

/**
 收藏功能提到basecell 。这个项目每个列表都有收藏功能。可加可不加
 */


class BaseTableViewCell: UITableViewCell, Reusable {
    
    //weak：weak 是一个修饰符，用于声明一个弱引用。
    //在 Swift 中，引用通常是强引用，即对象的引用计数会增加，只有当所有强引用都释放时，对象才会被销毁。
    //使用 weak 修饰符声明的引用是弱引用，不会增加对象的引用计数，当对象的所有强引用都释放时，弱引用会自动被设置为 nil。这有助于避免循环引用（retain cycle）的问题。
    weak open var collectDelegate: CollectDelegate?
    //在 Swift 中，访问控制修饰符有多个级别，包括：open、public、internal、fileprivate 和 private。其中，open 是最高级别的访问控制修饰符，表示该实体对于其他模块是完全可见和可继承的。
    
    //是否收藏
    var isCollect = false
    
    lazy var imgCollect = UIButton().then({attr in
        attr.setImage(UIImage(named: "ic_uncollect"), for: .normal)
    })
    
    //init函数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    //配置UI
    open func configUI() {
        
    }
    
    //刷新收藏
    func refreshCollect(isCollect collect: Bool) {
        if collect {
            imgCollect.setImage(UIImage(named: "ic_collect"), for: .normal)
        } else {
            imgCollect.setImage(UIImage(named: "ic_uncollect"), for: .normal)
        }
        self.isCollect = collect
    }
    
    //收藏，通过协议进行回调通知
    @objc func collect(btn: UIButton) {
        if self.isCollect {
            collectDelegate?.uncollectAirticle(cid: btn.tag, tabCell: self)
        } else {
            collectDelegate?.collectAirticle(cid: btn.tag, tabCell: self)
        }
    }
    
    //required init?(coder: NSCoder) 是一个特殊的初始化器方法，用于从 NSCoder 对象中解码数据并初始化一个对象。
    required init?(coder: NSCoder) {
        //这个初始化器方法通常用于支持从归档数据（如通过 NSKeyedArchiver 归档的对象）中还原对象的过程。
        //当你的自定义类需要从归档数据中还原时，你需要实现这个初始化器方法。
        fatalError("init(coder:) has not been implemented")
    }
}
