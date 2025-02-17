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
    NSLog(@"Palm , PalmRegisterViewController viewWillAppear");
}

//viewDidAppear:：视图已经显示时调用，可以在此方法中执行一些需要在视图显示后立即执行的操作，例如开始动画、请求网络数据等。
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"Palm , PalmRegisterViewController viewDidAppear");
}

//viewWillDisappear:：视图即将消失时调用，可以在此方法中进行一些清理工作，例如取消网络请求、保存数据等。
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"Palm , PalmRegisterViewController viewWillDisappear");
}

//viewDidDisappear:：视图已经消失时调用，可以在此方法中执行一些需要在视图消失后立即执行的操作，例如停止动画、释放资源等。
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"Palm , PalmRegisterViewController viewDidDisappear");
}

//dealloc：释放资源，当 UIViewController 实例被销毁时调用，用于释放持有的对象和资源。
- (void)dealloc {
    //[super dealloc];    //ARC forbids explicit message send of 'dealloc'
    //在重写dealloc方法时，‌必须调用父类的dealloc方法（‌[super dealloc]）‌，‌并且这行代码应放在自定义dealloc方法的最后。‌
    //这是因为父类可能包含了一些清理工作，‌如释放继承自父类的资源或执行一些必要的清理操作。‌
    NSLog(@"Palm , PalmRegisterViewController 释放资源");
    //移除鉴权监听状态
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Palm , PalmRegisterViewController viewDidLoad");
    //设置颜色
    self.view.backgroundColor = [UIColor colorHexString:@"FFFFFF"];
    //隐藏titleBar
    self.navigationController.navigationBarHidden = YES;
    //获取参数
    RequestAuthParams* params = self.params;
    [self printRequestAuthParams:params];
    //初始化微信sdk鉴权
    [self initWxSdk];
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
    NSLog(@"Palm , PalmRegisterViewController params result : %@" , result);
}

- (void) initData:(BOOL) isLoading {
    NSString* url = url_auth;
    //将long转化为字符串
    NSString *timestamp = [NSString stringWithFormat:@"%ld", self.params.timestamp];
    NSDictionary *parameters = @{@"app_id": self.params.appID,
                                 @"user_id": self.params.userId,
                                 @"user_name": self.params.userName,
                                 @"phone_no": self.params.phoneNo,
                                 @"payment_token": self.params.paymentToken,
                                 @"timestamp": timestamp,
                                 @"nonce": self.params.nonce,
                                 @"signature": self.params.signature
    };
    //请求鉴权接口数据
    [[PalmRequestManager manager] POST_REQUEST:url parameters:parameters success:^(id  _Nullable responseObj) {
        NSLog(@"POST请求 JSON: %@", responseObj);
        //将json数据转化为bean对象
        BeanAuthData *authData = [BeanAuthData mj_objectWithKeyValues:responseObj];
        if (authData != NULL && authData.code == 0) {
            //获取鉴权正常情况
            self.isAuthSuccess = true;
            self.token = authData.user_token;
            self.traceId = authData.trace_id;
            // 更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *msg = [NSBundle localizedStringForKey:@"string_auth_success"];
                NSString *start = [NSBundle localizedStringForKey:@"string_start_palm"];
                // 在主线程更新UI
                [self.tvResultTitle setText:msg];
                [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_success"]];
                [self.tvResultDescribe setText:@""];
                [self.btnStartPalm setTitle:start forState:UIControlStateNormal];
            });
            //开始获取优图授权信息
            [self startGetLicense];
        } else {
            //获取鉴权数据异常情况
            self.isAuthSuccess = false;
            // 更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = [NSBundle localizedStringForKey:@"string_auth_api_error"];
                NSString *msg = [NSBundle localizedStringForKey:@"string_auth_error_hint"];
                NSString *start = [NSBundle localizedStringForKey:@"string_start_auth"];
                // 在主线程更新UI
                [self.tvResultTitle setText: title];
                [self.tvResultDescribe setText: msg];
                [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
                [self.btnStartPalm setTitle:start forState:UIControlStateNormal];
            });
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"POST请求 Error: %@", error);
        self.isAuthSuccess = false;
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *title = [NSBundle localizedStringForKey:@"string_auth_api_error"];
            NSString *msg = [NSBundle localizedStringForKey:@"string_auth_error_hint"];
            NSString *start = [NSBundle localizedStringForKey:@"string_start_auth"];
            // 在主线程更新UI
            [self.tvResultTitle setText: title];
            [self.tvResultDescribe setText: msg];
            [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
            [self.btnStartPalm setTitle:start forState:UIControlStateNormal];
        });
    }];
}

#pragma mark - view布局

//绘制布局
- (void) initView {
    CircleView *circleView = [[CircleView alloc] init];
    UIColor *transparentColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    circleView.backgroundColor = transparentColor;
    [self.view addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    
    
    _ivBack = [[UIImageView alloc] init];
    _ivBack.image = [UIImage imageNamed:@"icon_back_white"];
    _ivBack.contentMode = UIViewContentModeScaleAspectFit;
    //确保用户交互已启用
    _ivBack.userInteractionEnabled = YES;
    //设置背景颜色。设置透明色
    //_ivBack.backgroundColor = [[UIColor colorHexString:@"333333"] colorWithAlphaComponent:0];
    //设置成圆形
    _ivBack.layer.cornerRadius = _ivBack.frame.size.width / 2;
    _ivBack.layer.masksToBounds = YES;
    
    //_ivBack.clipsToBounds = YES;
    //添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapped:)];
    [_ivBack addGestureRecognizer:tapGesture];
    //将它加到圆形父视图view中
    [circleView addSubview:_ivBack];
    [_ivBack mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.view.mas_top).offset(100);
        //make.left.equalTo(self.view.mas_left).offset(20);
        make.center.equalTo(circleView);
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
        make.width.equalTo(@240);
        make.height.equalTo(@40);
    }];
    
    NSString *msgLic = [NSBundle localizedStringForKey:@"string_tencent_license"];
    _tvLicense = [[UITextView alloc] init];
    _tvLicense.text = msgLic;
    _tvLicense.font = [UIFont systemFontOfSize:12];
    _tvLicense.textColor = [UIColor colorHexString:@"a3a3a3"];
    _tvLicense.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tvLicense];
    [_tvLicense mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.height.equalTo(@40);
        make.width.equalTo(@280);
    }];
    
    NSString *msg = [NSBundle localizedStringForKey:@"string_start_palm"];
    self.btnStartPalm = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnStartPalm.backgroundColor = [UIColor colorHexString:@"2cc569"];
    // 设置按钮标题文本的字体大小为 14
    self.btnStartPalm.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.btnStartPalm setTitle:msg forState:UIControlStateNormal];
    [self.btnStartPalm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnStartPalm addTarget:self action:@selector(startPalm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnStartPalm];
    [self.btnStartPalm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tvLicense.mas_top).offset(-60);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    self.btnStartPalm.layer.cornerRadius = 25;
    self.btnStartPalm.layer.masksToBounds = YES;
}

#pragma mark - 点击事件处理方法

- (void)backTapped:(UITapGestureRecognizer *)gesture {
    // 在这里执行你想要的操作
    NSString *msg = [NSBundle localizedStringForKey:@"string_cancel_palm"];
    NSLog(@"Palm , 关闭页面操作 %@", msg);
    //实现接口回调
    if (self.plamBlock) {
        //用户取消
        self.plamBlock(ERR_CANCEL, msg);
    }
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
}

#pragma mark - 网络接口请求

- (void) startGetLicense {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLicenseSuccess = [defaults boolForKey:SP_KEY_LICENSE_STATUS];
    if (isLicenseSuccess) {
        NSLog(@"微卡sdk已经初始化优图鉴权成功了，不需要在请求接口");
        return;
    }
    NSString* url = get_license;
    //将long转化为字符串
    NSDictionary *parameters = @{@"user_token": self.token};
    //请求获取掌纹状态接口数据
    [[PalmRequestManager manager] POST_REQUEST:url parameters:parameters success:^(id  _Nullable responseObj) {
        NSLog(@"POST请求 获取授权信息 JSON: %@", responseObj);
        //将json数据转化为bean对象
        BeanLicense *beanLicense = [BeanLicense mj_objectWithKeyValues:responseObj];
        if (beanLicense != NULL && beanLicense.code == 0) {
            NSLog(@"在微卡空中录掌页面，获取鉴权信息，初始化微信sdk");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //存储信息
            [defaults setObject:beanLicense.license forKey: SP_KEY_LICENSE];
            //调用该api确保数据立即保存
            [defaults synchronize];
            NSLog(@"在微卡空中录掌页面，获取鉴权信息，新的 license %@" , beanLicense.license);
            //初始化微信sdk鉴权
            [self initWxSdk];
        } else {
            NSLog(@"在微卡空中录掌页面，获取license异常了，需要再重新获取");
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"POST请求 获取授权信息 Error: %@", error);
    }];
}

- (void) startGetPalmStatus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLicenseSuccess = [defaults boolForKey:SP_KEY_LICENSE_STATUS];
    if (!isLicenseSuccess) {
        NSLog(@"requestPalmStatus 校验license鉴权不通过，开始获取license");
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *msg = [NSBundle localizedStringForKey:@"string_auth_error"];
            NSString *desc = [NSBundle localizedStringForKey:@"string_check_contact_service"];
            // 在主线程更新UI
            [self.tvResultTitle setText:msg];
            [self.tvResultDescribe setText:desc];
            [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
        });
        [self startGetLicense];
        return;
    }
    NSLog(@"requestPalmStatus 开始调用微卡获取录掌状态接口");
    NSString* url = url_get_palm_status;
    //self.token = @"token";
    //将long转化为字符串
    NSDictionary *parameters = @{@"user_token": self.token};
    //请求获取掌纹状态接口数据
    [[PalmRequestManager manager] POST_REQUEST:url parameters:parameters success:^(id  _Nullable responseObj) {
        NSLog(@"POST请求 获取掌纹状态接口 JSON: %@", responseObj);
        //将json数据转化为bean对象
        BeanPalmStatus *palmStatus = [BeanPalmStatus mj_objectWithKeyValues:responseObj];
        if (palmStatus != NULL && palmStatus.code == 0) {
            //获取掌纹状态正常情况
            NSString* status = palmStatus.palm_status;
            if (Unregistered == status) {
                // 未录掌
                NSLog(@"POST请求 获取掌纹状态接口 未录掌");
                [self toWxPalm];
            } else if (PreRegistered == status) {
                // 预录入
                NSLog(@"POST请求 获取掌纹状态接口 预录入");
                // 更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *msg = [NSBundle localizedStringForKey:@"string_start_palm_success"];
                    NSString *desc = [NSBundle localizedStringForKey:@"string_check_palm_success"];
                    // 在主线程更新UI
                    [self.tvResultTitle setText:msg];
                    [self.tvResultDescribe setText:desc];
                    [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_success"]];
                });
            } else if (Registered == status) {
                // 已录掌
                NSLog(@"POST请求 获取掌纹状态接口 已录掌");
                // 更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 在主线程更新UI
                    NSString *msg = [NSBundle localizedStringForKey:@"string_user_record_palm"];
                    NSString *desc = [NSBundle localizedStringForKey:@"string_check_palm_success"];
                    // 在主线程更新UI
                    [self.tvResultTitle setText:msg];
                    [self.tvResultDescribe setText:desc];
                    [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_success"]];
                });
            } else {
                // 异常情况
                NSLog(@"POST请求 获取掌纹状态接口 其他情况 %@", status);
                // 更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *msg = [NSBundle localizedStringForKey:@"string_get_palm_error"];
                    // 在主线程更新UI
                    [self.tvResultTitle setText:msg];
                    [self.tvResultDescribe setText:@""];
                    [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
                });
            }
        } else {
            //获取掌纹状态异常情况
            NSLog(@"POST请求 获取掌纹状态接口数据异常");
            // 更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *msg = [NSBundle localizedStringForKey:@"string_get_palm_error"];
                // 在主线程更新UI
                [self.tvResultTitle setText:msg];
                [self.tvResultDescribe setText:@""];
                [self.ivResultIcon setImage:[UIImage imageNamed:@"icon_result_fail"]];
            });
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"POST请求 获取掌纹状态接口 Error: %@", error);
    }];
}

//初始化sdk鉴权
- (void) initWxSdk {
    //读取授权信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 从NSUserDefaults获取数据
    NSString *license = [defaults objectForKey:SP_KEY_LICENSE];
    if (![license isEmpty] && license.length >0) {
        NSLog(@"initAirPalmKit 初始化微信sdk %@", license);
        //添加鉴权监听状态
        //初始化微信sdk鉴权
        [WeCardPalmHelper.instance initAirPalmKit:license];
    } else {
        NSLog(@"Palm , sdkLicense 初始化授权获取的license鉴权信息是空");
    }
}


//初始化sdk空中录掌跳转
- (void) toWxPalm {

}

@end
