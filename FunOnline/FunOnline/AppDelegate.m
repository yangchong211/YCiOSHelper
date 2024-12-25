//
//  AppDelegate.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "AppDelegate.h"
#import "BasicTabBarController.h"
#import "BasicNavigationController.h"
#import "AppDelegate+Utils.h"
#import <AVFoundation/AVFoundation.h>

#pragma mark - 拓展语法，该类中可以放属性和方法
//@interface AppDelegate () 是一种扩展（Extension）的语法，用于在类的实现文件（.m）中声明私有属性和方法。
//这些属性和方法只能在当前类的实现文件中访问，对外部代码是不可见的。
@interface AppDelegate ()

@end

#pragma mark - AppDelegate具体的实现
//@implementation 是用于实现类的具体功能的关键字。它用于定义类的方法和属性的具体实现。
//@implementation 声明通常包含在实现文件（.m）中，用于实现类的接口文件（.h）中声明的方法和属性。
@implementation AppDelegate

//默认为AppDelegate，在app受到干扰时，会产生一些系统事件，这时UIApplication会通知它的delegate对象，让delegate代理来处理这些系统事件。
//相当于swift中：func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initAvAudioItem];
    [self initWindownRoot];
    [self initialAppUtil];
    return YES;
}


//初始化音频
- (void)initAvAudioItem {
    // AudioSessionInitialize用于控制打断
    // 这种方式后台，可以连续播放非网络请求歌曲，遇到网络请求歌曲就废,需要后台申请task
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    BOOL success = [session setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (!success) {
        return;
    }
    NSError *activationError = nil;
    success = [session setActive:YES error:&activationError];
    if (!success) {
        return;
    }
}

//设置启动根容器Controller
- (void) initWindownRoot {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置白色
    self.window.backgroundColor = [UIColor whiteColor];
    //创建根容器
    BasicTabBarController *tabBar = [[BasicTabBarController alloc] init];
    //设置根容器
    self.window.rootViewController = tabBar;
    //打开窗口
    [self.window makeKeyAndVisible];
}

//获取当前导航器Nav
- (UINavigationController *) currentNav {
    //获取application属性
    UIApplication *sharedApplication = [UIApplication sharedApplication];
    //根据application获取根容器
    UIViewController *rootViewController = sharedApplication.keyWindow.rootViewController;
    //根容器转换
    UITabBarController *tabBar = (BasicTabBarController*)rootViewController;
    if (![tabBar isKindOfClass:[UITabBarController class]]) return nil;
    //选择当前的容器
    UINavigationController *nav = (BasicNavigationController *)tabBar.selectedViewController;
    return nav;
}

//即将失去活动状态的时候调用
//相当于swift中：func applicationWillResignActive(_ application: UIApplication)
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


/**
 *  程序进入后台，继续播放当前音乐
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
    if (taskID != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:taskID];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
