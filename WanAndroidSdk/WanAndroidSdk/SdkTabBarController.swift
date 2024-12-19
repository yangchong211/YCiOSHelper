//
//  TabBarController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/4.
//

import UIKit

open class SdkTabBarController: UITabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //首页
        let feedRootVc = HomeRootController();
        addChildViewController(childViewController: feedRootVc, title: "首页");
        
        //朋友
        let friendRootVc = FriendRootController();
        addChildViewController(childViewController: friendRootVc, title: "朋友");
        
        //相机
        let cameraRootVc = CameraRootController();
        let cameraImage = UIImage(named: "icon_home_add")?.withRenderingMode(.alwaysOriginal)
        //标题传入nil
        addChildViewController(childViewController: cameraRootVc, title: nil,image: cameraImage,selectImage: cameraImage);
        
        //消息
        let messageRootVc = MessageRootController();
        addChildViewController(childViewController: messageRootVc, title: "消息");
        
        //我的
        let profileRootVc = ProfileRootController();
        addChildViewController(childViewController: profileRootVc, title: "我的");
    }


    //可以灵活的添加子vc
    //第一个参数是vc
    //第二个参数是标题
    //第三个参数是图片，正常状态
    //第四个参数是选中状态下图片
    private func addChildViewController(childViewController: UIViewController , title: String? , image: UIImage? = nil, selectImage: UIImage? = nil) {
        //声明一个导航控制器，根控制器是传进来的子vc
        let navigationCortroller = UINavigationController(rootViewController: childViewController);
        //隐藏导航栏
        navigationCortroller.setNavigationBarHidden(true, animated: false)
        
        //拿到导航控制器的tabBar
        let tabBarItem = navigationCortroller.tabBarItem;
        //设置标题，图片，选中图片
        tabBarItem?.title = title;
        tabBarItem?.image = image;
        tabBarItem?.selectedImage = selectImage;
        
        //对标题判断
        if let _ = title {
            //有标题
            //设置标题的属性，正常是灰色，选中是红色
            tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red,.font:UIFont.systemFont(ofSize: 15)], for: .normal)
            tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue,.font:UIFont.systemFont(ofSize: 15)], for: .selected)
            //systemFont是指系统的字体
            tabBarItem?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        } else {
            //对图片
            tabBarItem?.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
        }
        
        //添加子控制器，注意不要传递传入的控制器childViewController，而是用包一层的navigationCortroller
        addChild(navigationCortroller);
    }
    
}
