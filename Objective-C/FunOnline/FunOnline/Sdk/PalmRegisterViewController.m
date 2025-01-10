//
//  Created by 杨充 on 2024/12/24.
//

#import "PalmRegisterViewController.h"

@interface PalmRegisterViewController ()

@property (nonatomic, strong) UIImageView *ivBack;
@property (nonatomic, strong) UIImageView *ivResultIcon;
@property (nonatomic, strong) UITextView *tvResultTitle;
@property (nonatomic, strong) UITextView *tvResultDescribe;
@property (nonatomic, strong) UIButton *btnStartPalm;
@property (nonatomic, strong) UITextView *tvLicense;

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
    NSLog(@"Palm , PalmRegisterViewController 释放资源");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置颜色
    self.view.backgroundColor = [UIColor colorWhiteColor];
    RequestAuthParams* params = self.params;
    //获取参数
    [self printRequestAuthParams:params];
    //视图创建和加载
    [self initView];
    //数据加载
    [self initData:false];
}

- (void) printRequestAuthParams:(RequestAuthParams*) params {
    NSString *result = [NSString stringWithFormat:@"%@ %@ %@ %@ %d %@ %@ %@",
                        params.userId, params.userName,
                        params.phoneNo,params.paymentToken,
                        params.timestamp,params.nonce,
                        params.appID,params.signature];
    NSLog(@"Palm , PalmRegisterViewController params result  %@" , result);
}

- (void) initData:(BOOL) isLoading {
    NSString* url = url_auth;
    //将long转化为字符串
    NSString *timestamp = [NSString stringWithFormat:@"%ld", self.params.timestamp];
    NSDictionary *parameters = @{@"AppId": self.params.appID,
                                 @"UserId": self.params.userId,
                                 @"UserName": self.params.userName,
                                 @"PhoneNo": self.params.phoneNo,
                                 @"PaymentToken": self.params.paymentToken,
                                 @"Timestamp": timestamp,
                                 @"Nonce": self.params.nonce,
                                 @"Signature": self.params.signature
    };
    //请求鉴权接口数据
    [[PalmRequestManager manager] POST:url parameters:parameters success:^(id  _Nullable responseObj) {
        NSLog(@"POST请求 JSON: %@", responseObj);
        //将json数据转化为bean对象
        BeanAuthData *authData = [BeanAuthData mj_objectWithKeyValues:responseObj];
        if (authData != NULL && authData.code == 0) {
            //获取鉴权正常情况
            self.isAuthSuccess = true;
            self.token = authData.userToken;
            self.traceId = authData.traceId;
            [self.tvResultTitle setText:@"授权成功"];
            [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_success"]];
            [self.tvResultDescribe setText:@""];
        } else {
            //获取鉴权数据异常情况
            self.isAuthSuccess = false;
            [self.tvResultTitle setText:@"授权数据异常"];
            [self.tvResultDescribe setText:@"请重新再试"];
            [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"POST请求 Error: %@", error);
        self.isAuthSuccess = false;
        [self.tvResultTitle setText:@"授权请求异常"];
        [self.tvResultDescribe setText:@"请检查网络后再试试"];
        [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
    }];
}

#pragma mark - view布局

//绘制布局
- (void) initView {
    _ivBack = [[UIImageView alloc] init];
    _ivBack.image = [UIImage imageNamed:@"icon_back_white"];
    _ivBack.contentMode = UIViewContentModeScaleAspectFit;
    //确保用户交互已启用
    _ivBack.userInteractionEnabled = YES;
    _ivBack.backgroundColor = [UIColor redColor];
    //设置成圆形
    _ivBack.layer.cornerRadius = _ivBack.frame.size.width / 2;
    _ivBack.clipsToBounds = YES;
    //添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapped:)];
    [_ivBack addGestureRecognizer:tapGesture];
    [self.view addSubview:_ivBack];
    [_ivBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    _ivResultIcon = [[UIImageView alloc] init];
    _ivResultIcon.image = [UIImage imageNamed:@"icon_result_success"];
    _ivResultIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_ivResultIcon];
    [_ivResultIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBack.mas_bottom).offset(80);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@65);
        make.height.equalTo(@65);
    }];
    
    _tvResultTitle = [[UITextView alloc] init];
    _tvResultTitle.text = @"这个是标题";
    _tvResultTitle.textAlignment = NSTextAlignmentCenter;
    //设置字体大小
    _tvResultTitle.font = [UIFont boldSystemFontOfSize:24];
    //设置字体颜色
    _tvResultTitle.textColor = [UIColor colorHexString:@"000000"];
    [self.view addSubview:_tvResultTitle];
    [_tvResultTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivResultIcon.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    
    _tvResultDescribe = [[UITextView alloc] init];
    _tvResultDescribe.text = @"这个是二级内容";
    _tvResultDescribe.textAlignment = NSTextAlignmentCenter;
    //设置字体大小
    _tvResultDescribe.font = [UIFont systemFontOfSize:16];
    //设置字体颜色
    _tvResultDescribe.textColor = [UIColor colorHexString:@"a3a3a3"];
    [self.view addSubview:_tvResultDescribe];
    [_tvResultDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tvResultTitle.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    
    _tvLicense = [[UITextView alloc] init];
    _tvLicense.text = @"由腾讯提供技术支持";
    _tvLicense.font = [UIFont systemFontOfSize:12];
    _tvLicense.textColor = [UIColor colorHexString:@"a3a3a3"];
    _tvLicense.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tvLicense];
    [_tvLicense mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.height.equalTo(@40);
        make.width.equalTo(@200);
    }];
    
    self.btnStartPalm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnStartPalm.backgroundColor = [UIColor colorHexString:@"2cc569"];
    // 设置按钮标题文本的字体大小为 14
    self.btnStartPalm.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.btnStartPalm setTitle:@"开始录掌" forState:UIControlStateNormal];
    [self.btnStartPalm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnStartPalm addTarget:self action:@selector(startPalm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnStartPalm];
    [self.btnStartPalm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tvLicense.mas_top).offset(-60);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@180);
        make.height.equalTo(@50);
    }];
    self.btnStartPalm.layer.cornerRadius = 25;
    self.btnStartPalm.layer.masksToBounds = YES;
}

#pragma mark - 点击事件处理方法

- (void)backTapped:(UITapGestureRecognizer *)gesture {
    // 在这里执行你想要的操作
    NSLog(@"Palm , 关闭页面操作");
    //关闭控制器
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startPalm:(UITapGestureRecognizer *)gesture {
    NSLog(@"Palm , startPalm");
    if (self.isAuthSuccess) {
        //鉴权成功后，点击开始获取录掌授权
        [self startGetPalmStatus];
    } else {
        //如果没有鉴权，开始重新鉴权拉数据
        [self initData:true];
    }
    //[self startGetPalmStatus];
}

- (void) startGetPalmStatus {
    NSString* url = url_get_palm_status;
    //self.token = @"token";
    //将long转化为字符串
    NSDictionary *parameters = @{@"UserToken": self.token};
    //请求获取掌纹状态接口数据
    [[PalmRequestManager manager] POST:url parameters:parameters success:^(id  _Nullable responseObj) {
        NSLog(@"POST请求 获取掌纹状态接口 JSON: %@", responseObj);
        //将json数据转化为bean对象
        BeanPalmStatus *palmStatus = [BeanPalmStatus mj_objectWithKeyValues:responseObj];
        if (palmStatus != NULL && palmStatus.code == 0) {
            //获取掌纹状态正常情况
            NSString* status = palmStatus.palmStatus;
            if (Unregistered == status) {
                // 未录掌
                NSLog(@"POST请求 获取掌纹状态接口 未录掌");
            } else if (PreRegistered == status) {
                // 预录入
                NSLog(@"POST请求 获取掌纹状态接口 预录入");
            } else if (Registered == status) {
                // 已录掌
                NSLog(@"POST请求 获取掌纹状态接口 已录掌");
            } else {
                // 异常情况
                NSLog(@"POST请求 获取掌纹状态接口 其他情况 %@", status);
            }
        } else {
            //获取掌纹状态异常情况
            NSLog(@"POST请求 获取掌纹状态接口数据异常");
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"POST请求 获取掌纹状态接口 Error: %@", error);
    }];
}

@end
