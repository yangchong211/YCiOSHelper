
import UIKit

class IndexVController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBar()
        //initTab()
    }
    
    //文字tab
    private func initTabBar() {
        let home = HomeController()
        let project = ProjectVController()
        let wechat = WechatVController()
        let structure = StructrureVController()
        let user = UserVController()
        addChildViewController(childViewController: home, title: "主页");
        addChildViewController(childViewController: project, title: "项目");
        addChildViewController(childViewController: wechat, title: "公众号");
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
        let project = ProjectVController()
        let wechat = WechatVController()
        let structure = StructrureVController()
        let user = UserVController()
        home.tabBarItem = UITabBarItem(title: "主页", image: UIImage(named: "home_tabbar_night_32x32_"), selectedImage: UIImage(named: "home_tabbar_press_32x32_"))
        project.tabBarItem = UITabBarItem(title: "项目", image: UIImage(named: "project_tabbar_night_32x32_"), selectedImage: UIImage(named: "project_tabbar_press_32x32_"))
        wechat.tabBarItem = UITabBarItem(title: "公众号", image: UIImage(named: "wechat_tabbar_night_32x32_"), selectedImage: UIImage(named: "wechat_tabbar_press_32x32_"))
        structure.tabBarItem = UITabBarItem(title: "体系", image: UIImage(named: "structure_tabbar_night_32x32_"), selectedImage: UIImage(named: "structure_tabbar_press_32x32_"))
        user.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "mine_tabbar_night_32x32_"), selectedImage: UIImage(named: "mine_tabbar_press_32x32_"))
        self.viewControllers = [home, project, wechat, structure, user]
    }

}

