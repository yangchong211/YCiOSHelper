//
//  BaseUITableView.swift
//  FunIOS
//
//  Created by redli on 2021/9/7.
//

import Foundation
import UIKit
//import MEVFloatingButton

public protocol FloatButtonDelegate: NSObjectProtocol {
    func floatStatus(forHide hide: Bool, withAnimal animal: Bool)
}

class FloatButtonTableView: UITableView {
    
    weak open var floatButtonDelegate: FloatButtonDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let offset = change?[NSKeyValueChangeKey.newKey] as! CGPoint
        
        print("\(offset.y)")
        
        if offset.y > 400.0 && offset.y < 1000.0 {
            floatButtonDelegate?.floatStatus(forHide: false, withAnimal: true)
        } else if offset.y > 1000.0 {
            floatButtonDelegate?.floatStatus(forHide: false, withAnimal: false)
        } else {
            floatButtonDelegate?.floatStatus(forHide: true, withAnimal: false)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FloatButtonTableView {
    
}
