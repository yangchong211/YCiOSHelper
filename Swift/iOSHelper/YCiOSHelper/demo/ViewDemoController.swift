//
//  ViewDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/28.
//

import UIKit
//import Kingfisher


//学习控制器
class ViewDemoController: UIViewController ,PalmControllerDelegate {
    
    
    private let viewUI  : UIView = UIView();
    private let button : UIButton = UIButton(type: .system)
    private let switchUI : UISwitch = UISwitch();
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //初始化方法，用于创建视图控制器的实例。
        print("init 初始化方法，用于创建视图控制器的实例。");
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("init 方法允许开发者指定一个nib文件名（如果有的话），并创建视图控制器");
    }
    
    override func loadView() {
        super.loadView();
        print("loadView 视图的呈现与内容填充。");
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear 视图即将出现在屏幕上时执行的代码");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear 视图即将从屏幕上消失时执行的代码");
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear 在这里进行视图消失后的清理工作");
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        print("motionBegan 在这里处理系统事件，例如设备方向变化");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 视图控制器的视图加载完成后的初始化工作");
        
        // 自定义view的初始化
        // 配置navigationItem
        self.navigationItem.title = "控制器案例"
        // 如果有需要，可以添加导航栏按钮等
        let rightButton = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(toggleEditMode))
        self.navigationItem.rightBarButtonItem = rightButton
        
        // 配置tabBarItem
        self.tabBarItem.title = "设置"
        self.tabBarItem.image = UIImage(named: "settingsIcon")
        
        
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
    
    @objc private func toggleEditMode() {
        print("编辑按钮被点击了");
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
//        var params = [
//            "userId" : "13667225184",
//            "userName": "用户名称",
//            "paymentToken": "支付凭证号码",
//            "appId": "123456",
//        ]
        print("开始跳转空中录掌页面，并且携带参数");
        let viewController = NavigationDemoController()
        viewController.delegate = self;
        viewController.userId = "13667225184"
        viewController.userName = "用户名称"
        viewController.appId = 100;
        self.navigationController?.pushViewController(viewController, animated: true)
        //或者使用下面的
        //present(viewController, animated: true)
    }
    
    //处理刷掌sdk返回的状态
    //code是状态码
    //data是数据
    func sendPalmBack(code: Int, data: String) {
        print("开始打印回调参数");
        print(code);
        print(data)
    }
}
