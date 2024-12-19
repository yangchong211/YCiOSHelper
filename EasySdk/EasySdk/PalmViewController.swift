//
//  PalmViewController.swift
//  PalmDaSdk
//
//  Created by 杨充 on 2024/12/9.
//

import UIKit

open class PalmViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "GPKit"
        
        let label = UILabel()
        label.text = "我是GPKit里面的控制器"
        label.textColor = .red
        view.addSubview(label)
  
        
        let button = UIButton(frame: CGRect(x: 30, y: 100, width: 50, height: 50))
        button.setTitle("返回", for: .normal)
        button.setImage(UIImage(named: "icon_share"), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside);
        view.addSubview(button)
        
        
        let imageView = UIImageView(frame: CGRect(x: 30, y: 200, width: 50, height: 50));
        imageView.image = UIImage(named: "icon_share.png")   //设置UIImage的图片名, 以及展示的样式
        imageView.isUserInteractionEnabled = true;
        imageView.contentMode = UIView.ContentMode.scaleAspectFit;
        self.view.addSubview(imageView);
    }
    
    @objc private func clickButton() {
        //推出当前控制器
        navigationController?.popViewController(animated: true)
    }
}
