//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DemoViewController.h"
#import "UIKitViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "WebViewController.h"
#import "DataManager.h"
#import "HttpController.h"


@interface DemoViewController ()

@property (nonatomic, strong) UITextView *textView1;
@property (nonatomic, strong) UITextView *textView2;
@property (nonatomic, strong) UITextView *textView3;
@property (nonatomic, strong) UITextView *textView4;
@property (nonatomic, strong) UITextView *textView5;
@property (nonatomic, strong) UITextView *textView6;
@property (nonatomic, strong) UITextView *textView7;
@property (nonatomic, strong) UITextView *textView8;

@end

@implementation DemoViewController

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

//viewDidLoad：视图加载完成后调用，用于进行一次性的初始化操作，例如设置数据源、添加子视图等。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView1 = [[UITextView alloc] init];
    _textView1.text = @"1.普通控件，文本/图片/输入框/按钮";
    _textView1.font = [UIFont systemFontOfSize:12];
    _textView1.textColor = [UIColor blackColor];
    _textView1.layer.borderWidth = 1.0;
    _textView1.layer.borderColor = [UIColor grayColor].CGColor;
    _textView1.layer.cornerRadius = 5.0;
    _textView1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView1];
    [_textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@300);
        make.height.equalTo(@40);
    }];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText1:)];
    [_textView1 addGestureRecognizer: tapGesture1];
    
    _textView2 = [[UITextView alloc] init];
    _textView2.text = @"2.TableView控件案例";
    _textView2.font = [UIFont systemFontOfSize:12];
    _textView2.textColor = [UIColor blackColor];
    _textView2.layer.borderWidth = 1.0;
    _textView2.layer.borderColor = [UIColor grayColor].CGColor;
    _textView2.layer.cornerRadius = 5.0;
    _textView2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView2];
    [_textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView1.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText2:)];
    [_textView2 addGestureRecognizer: tapGesture2];
    
    
    _textView3 = [[UITextView alloc] init];
    _textView3.text = @"3.CollectionView控件案例";
    _textView3.font = [UIFont systemFontOfSize:12];
    _textView3.textColor = [UIColor blackColor];
    _textView3.layer.borderWidth = 1.0;
    _textView3.layer.borderColor = [UIColor grayColor].CGColor;
    _textView3.layer.cornerRadius = 5.0;
    _textView3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView3];
    [_textView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView2.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(self.textView2);
        make.height.equalTo(self.textView2.mas_height);
    }];
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText3:)];
    [_textView3 addGestureRecognizer: tapGesture3];
    
    _textView4 = [[UITextView alloc] init];
    _textView4.text = @"4.ScrollView控件案例";
    _textView4.font = [UIFont systemFontOfSize:12];
    _textView4.textColor = [UIColor blackColor];
    _textView4.layer.borderWidth = 1.0;
    _textView4.layer.borderColor = [UIColor grayColor].CGColor;
    _textView4.layer.cornerRadius = 5.0;
    _textView4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView4];
    [_textView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView3.mas_bottom).offset(20);
        make.width.equalTo(self.textView3.mas_width);
        make.height.equalTo(self.textView3.mas_height);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText4:)];
    [_textView4 addGestureRecognizer: tapGesture4];
    
    _textView5 = [[UITextView alloc] init];
    _textView5.text = @"5.WebView综合案例展示";
    _textView5.font = [UIFont systemFontOfSize:12];
    _textView5.textColor = [UIColor blackColor];
    _textView5.layer.borderWidth = 1.0;
    _textView5.layer.borderColor = [UIColor grayColor].CGColor;
    _textView5.layer.cornerRadius = 5.0;
    _textView5.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView5];
    [_textView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView4.mas_bottom).offset(20);
        make.width.equalTo(self.textView4.mas_width);
        make.height.equalTo(self.textView4.mas_height);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText5:)];
    [_textView5 addGestureRecognizer: tapGesture5];
    
    _textView6 = [[UITextView alloc] init];
    _textView6.text = @"6.网络请求和json解析";
    _textView6.font = [UIFont systemFontOfSize:12];
    _textView6.textColor = [UIColor blackColor];
    _textView6.layer.borderWidth = 1.0;
    _textView6.layer.borderColor = [UIColor grayColor].CGColor;
    _textView6.layer.cornerRadius = 5.0;
    _textView6.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView6];
    [_textView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView5.mas_bottom).offset(20);
        make.width.equalTo(self.textView5.mas_width);
        make.height.equalTo(self.textView5.mas_height);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    UITapGestureRecognizer *tapGesture6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText6:)];
    [_textView6 addGestureRecognizer: tapGesture6];
    
    
    [self testApi];
}

- (void)clickText1:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    UIKitViewController *vc = [[UIKitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText2:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    TableViewController *vc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText3:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText4:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
}

- (void)clickText5:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    WebViewController *vc = [[WebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText6:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    HttpController *vc = [[HttpController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) testApi {
    [DataManager.dataInstance clearCache];
    NSString *version = [DataManager.dataInstance getAppVersion];
    NSLog(@"app的版本是：%@", version);
}

- (void) sendPalmBack:(NSInteger)code data: (NSString *)data {
    NSLog(@"返回的code：%d", code);
    NSLog(@"返回的data：%@", data);
}

@end
