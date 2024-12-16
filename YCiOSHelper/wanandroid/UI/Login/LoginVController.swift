//
//  LoginVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/30.
//

import UIKit
import LGButton
import Toast_Swift
import MBProgressHUD
import SwiftEventBus

class LoginVController: BaseCVontroller {
    
    private let closeImage = UIImageView().then { (attr) in
        attr.image = UIImage(named: "ic_close")
        attr.isUserInteractionEnabled = true
    }
    
    private let labelTitle = UILabel().then { (attr) in
        attr.text = "Fun IOS"
        attr.font = UIFont.boldSystemFont(ofSize: 20)
        attr.textColor = UIColor.black
    }
    
    private let textFieldUser = UITextField().then { (attr) in
        attr.borderStyle = .roundedRect
        attr.placeholder =  "请输入账户"
        attr.clearButtonMode = .always
        attr.leftViewMode = .always
        attr.leftView = UIImageView(image: UIImage(named: "ic_user"))
    }
    
    private let textFieldPwd = UITextField().then { (attr) in
        attr.borderStyle = .roundedRect
        attr.placeholder =  "请输入密码"
        attr.isSecureTextEntry = true
        attr.clearButtonMode = .always
        attr.leftViewMode = .always
        attr.leftView = UIImageView(image: UIImage(named: "ic_password"))
    }
    
    private let btnLogin = LGButton().then { (attr) in
        attr.cornerRadius = 10
        attr.titleString = "登录"
        attr.titleFontSize = 16
        attr.titleColor = UIColor.white
        attr.bgColor = UIColor.red.withAlphaComponent(0.6)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        let barHight = navigationController?.navigationBar.frame.height
        
        view.addSubview(closeImage)
        closeImage.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(statusBarHeight + barHight!)
            maker.leading.equalToSuperview().offset(30)
            maker.height.equalTo(20)
            maker.width.equalTo(20)
        }
        let closeTap = UITapGestureRecognizer.init(target: self, action: #selector(close))
        closeImage.addGestureRecognizer(closeTap)
        
        view.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(statusBarHeight + barHight! + screenWidth / 3)
            maker.centerX.equalToSuperview()
        }
        
        view.addSubview(textFieldUser)
        textFieldUser.snp.makeConstraints { (maker) in
            maker.top.equalTo(labelTitle.snp.bottom).offset(30)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(50)
        }
        
        view.addSubview(textFieldPwd)
        textFieldPwd.snp.makeConstraints { (maker) in
            maker.top.equalTo(textFieldUser.snp.bottom).offset(20)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.height.equalTo(50)
        }
        
        view.addSubview(btnLogin)
        btnLogin.snp.makeConstraints { (maker) in
            maker.top.equalTo(textFieldPwd.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(screenWidth / 3 * 2)
            maker.height.equalTo(50)
        }
        btnLogin.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func login() {
        let username = textFieldUser.text
        let password = textFieldPwd.text
        
        if ((username?.isEmpty) == nil) {
            view.makeToast("请输入用户名")
            return
        }
        
        if ((password?.isEmpty) == nil) {
            view.makeToast("请输入密码")
            return
        }
        
        self.showHUD(title: "登录中")
        
        Api.login(username: username!, password: password!, success: { (value: UserModel?) in
            UserDefaults.standard.setValue(value?.toJSONString(prettyPrint:true), forKey: userKey)
            self.hideHUD()
            self.close()
            SwiftEventBus.post(userEvent, sender: value)
        }, error: error(error:))
    }
    
    @objc func close() {
        navigationController?.popViewController(animated: true)
    }
}
