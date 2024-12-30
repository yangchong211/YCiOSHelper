//
//  BasicTabBarController.m
//  BotherSellerOC
//
//  Created by 杨充 on 2017/4/6.
//

#import "BasicTabBarController.h"
#import "BasicNavigationController.h"

#import "HomeViewController.h"
#import "NewsViewController.h"
#import "MusicBaseViewController.h"
#import "MineViewController.h"

#import "UIImage+Extension.h"
#import "UIColor+Extension.h"

//测试语法
#import "MyClass.h"
#import "Vehicle.h"
#import "VehicleCar.h"
#import "MyProtocolClass.h"
#import "MyProtocol.h"
#import "NSString+CustomMethods.h"


//@interface BasicTabBarController () 是一种类扩展（Class Extension）的语法，用于在类的实现文件（.m）中声明私有属性和方法。
@interface BasicTabBarController ()

@end

#pragma mark - BasicTabBarController类的实现

@implementation BasicTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    [self initChildrenController];
    [self test];
}

#pragma mark -

+ (void)load {
    [super load];
    
    //设置item
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *normalAttribute = [NSMutableDictionary dictionary];
    normalAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAttribute[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"aaaaaa"];
    [item setTitleTextAttributes:normalAttribute forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectedAttribute[NSForegroundColorAttributeName] = [UIColor colorThemeColor];
    [item setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
}


#pragma mark -

- (void)initChildrenController {
    
    HomeViewController *wallpaper = [[HomeViewController alloc] init];
    [self setupOneChildrenController:wallpaper title:@"壁纸" image:@"item-01-normal" selectedImage:@"item-01-select"];
    
    NewsViewController *news = [[NewsViewController alloc] init];
    [self setupOneChildrenController:news title:@"新闻" image:@"item-02-normal" selectedImage:@"item-02-select"];
    
    MusicBaseViewController *music = [[MusicBaseViewController alloc] init];
    [self setupOneChildrenController:music title:@"乐库" image:@"item-03-normal" selectedImage:@"item-03-select"];
    
    MineViewController *mine = [[MineViewController alloc] init];
    [self setupOneChildrenController:mine title:@"我的" image:@"item-04-normal" selectedImage:@"item-04-select"];
}


//切换控制器
- (void) setupOneChildrenController: (UIViewController *) vc title:(NSString *)title image:(NSString*)image selectedImage:(NSString*) selectedImage {
    //创建控制器
    BasicNavigationController *nav = [BasicNavigationController alloc];
    //设置容器
    [nav initWithRootViewController:vc];
    //获取标题item
    UITabBarItem *tabBarItem = [vc tabBarItem];
    //设置标题
    tabBarItem.title = title;
    if (((image.length) && (selectedImage.length)) > 0) { //图片存在
        //设置图片
        tabBarItem.image = [UIImage imageWithOriginalRenderingMode:image];
        //设置选中的图片
        tabBarItem.selectedImage = [UIImage imageWithOriginalRenderingMode:selectedImage];
    }
    // 添加子控制器
    [self addChildViewController:nav];
}

- (void) test {
    MyClass *my = [[MyClass alloc] init];
    [my doSomething];
    NSInteger age = [my age];
    NSLog(@"调用age: %d", age);
    NSInteger result = [my calculateSumWithNumber: 5 andNumber: 10];
    NSLog(@"调用带有参数的方法: %d", result);
    NSString *greeting = [my greetWithName:@"John"];
    NSLog(@"调用greetWithName: %@", greeting);
    my.name = @"John"; // 使用 set 方法设置属性值
    NSString *name = my.name; // 使用 get 方法获取属性值
    NSLog(@"获取name: %@", greeting);
    //创建有参数的对象
    MyClass *person = [[MyClass alloc] initWithName:@"John" age:25];

    
    //学习属性
    NSString *originalString = @"Hello, World!";
    NSString *reversedString = [originalString reversedString];
    NSLog(@"%@", reversedString); // 输出：!dlroW ,olleH
    
    //学习类的继承
    VehicleCar *myCar = [[VehicleCar alloc] init];
    myCar.brand = @"Toyota";
    myCar.year = 2022;
    myCar.numberOfDoors = 4;
    [myCar startEngine];
    [myCar drive];
    [myCar stopEngine];
    
    
    //学习协议
    MyProtocolClass *myProtocolClass = [[MyProtocolClass alloc] init];
    id<MyProtocol> protocolObject = myProtocolClass;
    [protocolObject doSomething];
    NSString *getName = [protocolObject getName];
}

@end
