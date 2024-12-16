
import UIKit

class IndexVController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTab()
        UITabBar.appearance().tintColor = UIColor.red.withAlphaComponent(0.5)
    }
    
    private func initTab() {
        let home = HomeVController()
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

