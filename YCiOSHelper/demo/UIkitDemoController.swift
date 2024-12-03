//
//  UIkitDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/29.
//

import UIKit



class UIkitDemoController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // 创建一个UILabel
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        label.text = "Hello, UIKit!"
        label.textColor = .black
        self.view.addSubview(label)
    }
    
    
}
