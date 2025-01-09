
import UIKit

//open 是一个访问修饰符（access modifier），用于声明一个可以被其他模块访问和继承的类、属性、方法或初始化器。
//open 修饰符的作用范围比较宽泛，它允许其他模块中的代码对被修饰的实体进行继承、重写和访问。
//注意的是，open 修饰符的访问级别比 public 更高，因此被 open 修饰的实体可以被其他模块继承和访问，而被 public 修饰的实体只能被访问。
open class IndexController: UITabBarController {
    
    //UITabBarController 是 iOS 开发中常用的视图控制器之一，用于创建具有选项卡（Tab）界面的应用程序。
    //UITabBarController 可以在底部或顶部显示一个选项卡栏，每个选项卡对应一个视图控制器。
    //用户可以通过点击选项卡来切换不同的视图控制器和内容。
    open override func viewDidLoad() {
        super.viewDidLoad()
        //initTabBar()
        initTab()
    }
    
    //文字tab
    private func initTabBar() {
        let home = HomeController()
        let project = ProjectController()
        let wechat = MediaRootController()
        let structure = StructrureController()
        let user = UserController()
        addChildViewController(childViewController: home, title: "主页");
        addChildViewController(childViewController: project, title: "项目");
        addChildViewController(childViewController: wechat, title: "多媒体");
        addChildViewController(childViewController: structure, title: "体系");
        addChildViewController(childViewController: user, title: "我的");
    }
    
    
    //可以灵活的添加子vc
    //第一个参数是vc
    //第二个参数是标题
    private func addChildViewController(childViewController: UIViewController , title: String?) {
        //声明一个导航控制器，根控制器是传进来的子vc
        let navigationCortroller = UINavigationController(rootViewController: childViewController);
        //隐藏导航栏
        navigationCortroller.setNavigationBarHidden(true, animated: false)
        //拿到导航控制器的tabBar
        let tabBarItem = navigationCortroller.tabBarItem;
        let tabBarHeight = self.tabBar.frame.size.height;
        print("导航控制器的tabBar的高度是：\(tabBarHeight)");
        //设置标题，图片，选中图片
        tabBarItem?.title = title;
        //对标题判断
        if let _ = title {
            //有标题
            //设置标题的属性，正常是灰色，选中是红色
            tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red,.font:UIFont.systemFont(ofSize: 15)], for: .normal)
            tabBarItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue,.font:UIFont.systemFont(ofSize: 15)], for: .selected)
            //systemFont是指系统的字体
            tabBarItem?.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        }
        //添加子控制器，注意不要传递传入的控制器childViewController，而是用包一层的navigationCortroller
        addChild(navigationCortroller);
    }
    
    
    //文字+图标
    private func initTab() {
        let home = HomeController()
        let project = ProjectController()
        //let wechat = WechatController()
        let wechat = MediaRootController()
        let structure = StructrureController()
        let user = UserController()
        let tabBarHeight = self.tabBar.frame.size.height;
        print("导航控制器的tabBar的高度是：\(tabBarHeight)");
        //设置了对应的选项卡标题和图标。
        home.tabBarItem = UITabBarItem(title: "主页", image: UIImage(named: "home_tabbar_night"), selectedImage: UIImage(named: "home_tabbar_press"))
        project.tabBarItem = UITabBarItem(title: "项目", image: UIImage(named: "project_tabbar_night"), selectedImage: UIImage(named: "project_tabbar_press"))
        wechat.tabBarItem = UITabBarItem(title: "多媒体", image: UIImage(named: "wechat_tabbar_night"), selectedImage: UIImage(named: "wechat_tabbar_press"))
        structure.tabBarItem = UITabBarItem(title: "体系", image: UIImage(named: "structure_tabbar_night"), selectedImage: UIImage(named: "structure_tabbar_press"))
        user.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "mine_tabbar_night"), selectedImage: UIImage(named: "mine_tabbar_press"))
        //将这些视图控制器添加到 tabBarController 的 viewControllers 属性中。
        self.viewControllers = [home, project, wechat, structure, user]
    }

}

