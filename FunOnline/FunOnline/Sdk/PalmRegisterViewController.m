//
//  Created by 杨充 on 2024/12/24.
//

#import "PalmRegisterViewController.h"
#import "PalmControllerDelegate.h"

@interface PalmRegisterViewController ()

@property (nonatomic, strong) UITextView *myTextView;

@end

//空中录掌UI
@implementation PalmRegisterViewController

//用于返回视图控制器的首选状态栏样式（UIStatusBarStyle）。
- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    //UIStatusBarStyle 是一个枚举类型，用于指定状态栏的样式。
    //UIStatusBarStyleDefault：默认样式，状态栏文字为黑色。
    //UIStatusBarStyleLightContent：浅色内容样式，状态栏文字为白色。
    //UIStatusBarStyleDarkContent：深色内容样式，状态栏文字为黑色（仅适用于 iOS 13 及更高版本）。
    return UIStatusBarStyleDefault;
}

//viewWillAppear:：视图即将显示时调用，可以在此方法中进行视图相关的准备工作，例如更新数据、注册通知等。
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//viewDidAppear:：视图已经显示时调用，可以在此方法中执行一些需要在视图显示后立即执行的操作，例如开始动画、请求网络数据等。
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//viewWillDisappear:：视图即将消失时调用，可以在此方法中进行一些清理工作，例如取消网络请求、保存数据等。
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

//viewDidDisappear:：视图已经消失时调用，可以在此方法中执行一些需要在视图消失后立即执行的操作，例如停止动画、释放资源等。
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

//dealloc：释放资源，当 UIViewController 实例被销毁时调用，用于释放持有的对象和资源。
- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWhiteColor];
    // 创建 UITextView
    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, 200, 150)];
    self.myTextView.text = @"点击textView我跳转到列表页面";
    self.myTextView.editable = NO; // 禁止编辑
    self.myTextView.userInteractionEnabled = YES; // 允许用户交互
    [self.view addSubview:self.myTextView];
    // 添加点击手势识别器
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.myTextView addGestureRecognizer:tapGesture2];
}


- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecognizer {
    // 处理点击事件
    NSLog(@"TextView 被点击了");
}

@end
