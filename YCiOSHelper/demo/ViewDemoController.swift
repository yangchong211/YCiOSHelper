//
//  ViewDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/28.
//

import UIKit
//import Kingfisher


//学习控制器
class ViewDemoController: UIViewController {
    
    
    private let viewUI  : UIView = UIView();
    private let button : UIButton = UIButton(type: .system)
    private let switchUI : UISwitch = UISwitch();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加一个view
        viewUI.backgroundColor = UIColor.blue;
        viewUI.layer.borderWidth = 10;
        //viewUI.layer.borderColor = UIColor.red;
        view.addSubview(viewUI);
        
        //添加手势事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(getstureRecognizer:)))
        viewUI.addGestureRecognizer(tapGesture)
        
        //按钮
        button.setTitle("点击通过nav跳转", for: .normal)
        button.frame = CGRect(x: 100, y: 120, width: 100, height: 50) // 设置按钮的位置和大小
        button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        view.addSubview(button);
        
        //switchUI
        switchUI.isOn = true;
        switchUI.addTarget(self, action: #selector(switchClick(switchUI:)), for: .touchUpInside)
        view.addSubview(switchUI);
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewUI.frame = CGRect(x:0 , y: view.safeAreaInsets.top,width: 300,height: 300);
        //添加buttton位置
        button.frame = CGRect(x: 100, y: view.safeAreaInsets.top + 350, width: 40, height: 40);
        //添加swith位置
        switchUI.frame = CGRect(x: 100, y: view.safeAreaInsets.top + 400, width: 40, height: 40);
    }
    
    @objc private func tapGesture(getstureRecognizer : UIGestureRecognizer) {
        print(getstureRecognizer.state);
    }
    
    @objc private func buttonClick(button : UIButton) {
        print("button被电击了");
        toNavController();
    }
    
    @objc private func switchClick(switchUI : UISwitch) {
        print("switch被电击了:");
    }
    
    //通过nav跳转页面
    private func toNavController() {
        //todo 如何传递参数
        let viewController = NavigationDemoController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.button.window?.rootViewController = navigationController
    }
}
