//
//  UserTabVController.swift
//  FunIOS
//
//  Created by redli on 2021/8/9.
//

import Foundation
import UIKit
import SwiftEventBus
import Kingfisher
import Toast_Swift

struct MenuItem {
    var type: Int
    var icon: String
    var title: String
}


class UserVController: BaseCVontroller {
    
    private let profileUrl = "https://sf3-ttcdn-tos.pstatp.com/img/user-avatar/4639e530a32e1b721605e21908c63b4b~300x300.image"
    
    private let topView = UIView().then { (attr) in
        attr.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        attr.height = screenHeight / 4
    }
    
    private let imgLogout = UIImageView().then { attr in
        attr.image = UIImage(named: "ic_logout")
        attr.contentMode = .scaleAspectFit
        attr.isUserInteractionEnabled = true
    }
    
    //头像
    private let imgProfile = UIImageView().then { (attr) in
        attr.layer.cornerRadius = 30
        attr.layer.masksToBounds = true
        attr.isUserInteractionEnabled = true
        attr.image = UIImage(named: "mine_author")
    }
    
    //昵称
    private let labelNickName = UILabel().then { (attr) in
        attr.text = "立即登录"
        attr.lineBreakMode = .byTruncatingTail
        attr.numberOfLines = 1
        attr.font = UIFont.boldSystemFont(ofSize: 24)
        attr.isUserInteractionEnabled = true
        attr.textColor = UIColor.white
    }
    
    //等级
    private let labelLevel = UILabel().then { (attr) in
        attr.text = "lv 0"
        attr.font = UIFont.italicSystemFont(ofSize: 16)
        attr.textColor = UIColor.white
        attr.layer.masksToBounds = true
        attr.layer.cornerRadius = 5
        //        attr.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
    }
    
    //积分
    private let labelIntegral = UILabel().then { (attr) in
        attr.text = "积分 0"
        attr.font = UIFont.italicSystemFont(ofSize: 16)
        attr.textColor = UIColor.white
        attr.layer.masksToBounds = true
        attr.layer.cornerRadius = 5
        //        attr.backgroundColor = UIColor.cyan.withAlphaComponent(0.4)
    }
    
    private let tabView = UITableView().then { attr in
        attr.rowHeight = 60
        attr.separatorStyle = .none
        attr.register(cellType: UserCell.self)
    }
    
    private let data = [
        MenuItem(type: 1, icon: "ic_collection", title: "我的收藏"),
//        MenuItem(type: 2, icon: "ic_share", title: "分享"),
        MenuItem(type: 3, icon: "ic_integral", title: "我的积分"),
        MenuItem(type: 4, icon: "ic_ranking", title: "排行榜"),
        //        MenuItem(type: 5, icon: "ic_browsing", title: "浏览历史")
    ]
    
    private lazy var alertController = {
        UIAlertController(title: "退出提示", message: "你确定要退出登录吗？", preferredStyle: .alert)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "退出", style: .default) { action in
            self.clearUser()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        tabView.dataSource = self
        tabView.delegate = self
        
        view.addSubview(tabView)
        tabView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        tabView.tableHeaderView = topView
        
        topView.addSubview(imgLogout)
        imgLogout.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(statusBarHeight)
            maker.width.equalTo(26)
            maker.height.equalTo(26)
            maker.trailing.equalToSuperview().offset(-20)
        }
        imgLogout.isHidden = true
        let clearTap = UITapGestureRecognizer.init(target: self, action: #selector(onLogoutClick))
        imgLogout.addGestureRecognizer(clearTap)
        
        topView.addSubview(imgProfile)
        imgProfile.snp.makeConstraints { (maker) in
            maker.width.equalTo(65)
            maker.height.equalTo(65)
            maker.leading.equalToSuperview().offset(30)
            maker.centerY.equalToSuperview().offset(20)
        }
        
        topView.addSubview(labelNickName)
        labelNickName.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview().offset(20)
            maker.leading.equalTo(imgProfile.snp.trailing).offset(15)
        }
        
        topView.addSubview(labelLevel)
        labelLevel.snp.makeConstraints { maker in
            maker.leading.equalTo(imgProfile.snp.trailing).offset(15)
            maker.top.equalTo(labelNickName.snp.bottom)
                .offset(10)
        }
        labelLevel.isHidden = true
        
        topView.addSubview(labelIntegral)
        labelIntegral.snp.makeConstraints { maker in
            maker.leading.equalTo(labelLevel.snp.trailing).offset(10)
            maker.top.equalTo(labelNickName.snp.bottom)
                .offset(10)
        }
        labelIntegral.isHidden = true
        
        let userJson = UserDefaults.standard.string(forKey: userKey)
        if userJson == nil {
            addUserGesture()
        } else {
            let userModel = UserModel.deserialize(from: userJson)
            self.refreshUser(user: userModel)
        }
        
        SwiftEventBus.onMainThread(self, name: userEvent) { result in
            let userModel = result?.object as! UserModel
            self.refreshUser(user: userModel)
        }
    }
    
    @objc func onUserClick() {
        navigationController?.pushViewController(LoginVController(), animated: true)
    }
    
    @objc func onLogoutClick() {
        self.present(alertController, animated: true, completion:  nil)
    }
    
    private func clearUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        imgProfile.image = UIImage(named: "mine_author")
        labelNickName.text = "立即登录"
        imgLogout.isHidden = true
        labelLevel.isHidden = true
        labelIntegral.isHidden = true
        labelLevel.text = ""
        labelIntegral.text = ""
        addUserGesture()
    }
    
    private func refreshUser(user: UserModel?) {
        labelNickName.text = user?.nickname
        imgLogout.isHidden = false
        imgProfile.kf.setImage(with: URL(string: profileUrl), placeholder: UIImage(named: "mine_author"))
        
        self.showHUD(title: "刷新中")
        Api.fetchUserCoinLevel(success: { data in
            self.labelNickName.snp.updateConstraints { maker in
                maker.centerY.equalToSuperview().offset(5)
            }
            
            let coinCount = data?.coinCount ?? 0
            let level = data?.level ?? 0
            
            self.labelIntegral.text = "积分 \(coinCount)"
            self.labelLevel.text = "lv \(level)"
            
            self.labelLevel.isHidden = false
            self.labelIntegral.isHidden = false
            
            self.hideHUD()
        }, error: error(error:))
    }
    
    private func addUserGesture() {
        let userTap = UITapGestureRecognizer.init(target: self, action: #selector( onUserClick))
        let pgr = UIPinchGestureRecognizer.init(target: self, action: #selector(onUserClick))
        imgProfile.addGestureRecognizer(pgr)
        labelNickName.addGestureRecognizer(userTap)
    }
}

extension UserVController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: UserCell.self)
        tableViewCell.model = self.data[indexPath.row]
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userJson = UserDefaults.standard.string(forKey: userKey)
        if userJson == nil {
            self.view.makeToast("请点击头像登录")
            return
        }
        
        let item = self.data[indexPath.row]
        
        var controller: UIViewController?
        switch item.type {
        case 1:
            controller = CollectVController()
            break;
        case 2:
            
            break;
        case 3:
            controller = IntegralVController()
            break;
        case 4:
            controller = RankingVController()
            break;
        default:
            controller = UIViewController()
            break;
        }
        if controller != nil {
            navigationController?.pushViewController(controller!, animated: true)
        }
    }
}
