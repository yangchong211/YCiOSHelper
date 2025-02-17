//
//  MoreViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"

#import "IBWaterWaveView.h"
#import "SecurityManager.h"

#import "FavoriteViewController.h"
#import "FeedBackViewController.h"
#import "LoginViewController.h"
#import "DemoViewController.h"
#import "PalmRegisterViewController.h"
#import "PalmLangEnum.h"
#import "WeCardPalmHelper.h"
#import "RequestAuthParams.h"


static NSString *const kMineCellReuseIdentifier = @"kMineCellReuseIdentifier";

@interface MineViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel     *userNameLabel;
@property (nonatomic, strong) UIButton    *loginButton;
@property (nonatomic, strong) NSArray     *dataObjets;

@end

@implementation MineViewController

//data数据
- (NSArray *)dataObjets {
    if (!_dataObjets) {
        _dataObjets = @[
                        [MineModel initWithTitle:@"我的收藏" image:@"mine_star"],
                        [MineModel initWithTitle:@"给我评价" image:@"mine_store"],
                        [MineModel initWithTitle:@"意见反馈" image:@"mine_feedback"],
                        [MineModel initWithTitle:@"清除缓存" image:@"mine_clear"],
                        [MineModel initWithTitle:@"UI控件演示" image:@"mine_clear"],
                        [MineModel initWithTitle:@"刷掌演示" image:@"mine_clear"]
                        ];
    }
    return _dataObjets;
}

#pragma mark - Life Cycle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//view视图加载出来
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    [self configSubview];
}

- (void)configSubview {
    CGFloat h = iPhone5 ? SCREEN_HEIGHT * 0.42 : SCREEN_WIDTH * 0.62;
    //创建一个headView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
    
    // d0e765, 33aab4
    IBWaterWaveView *waveView = [[IBWaterWaveView alloc] initWithFrame:headerView.bounds startColor:IBHexColorA(0xd0e765, 0.5) endColor:IBHexColorA(0x33aab4, 0.7)];
    [headerView addSubview:waveView];
    //创建用户
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[self reloadLogonImage]];
    logoImageView.frame = CGRectMake(0, 0, 90, 90);
    logoImageView.center = CGPointMake(headerView.mj_w*0.5, headerView.mj_h*0.5);
    logoImageView.layer.cornerRadius = 45.0;
    logoImageView.layer.borderWidth = 3.0;
    logoImageView.layer.borderColor = [UIColor colorBoardLineColor].CGColor;
    logoImageView.layer.masksToBounds = YES;
    [headerView addSubview:logoImageView];
    self.tableView.tableHeaderView = headerView;
    self.logoImageView = logoImageView;
    
    CGFloat labelY = CGRectGetMaxY(logoImageView.frame) + 5;
    CGFloat labelW = SCREEN_WIDTH - 30*2;
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, labelY, labelW, 20)];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    self.userNameLabel.textColor = [UIColor colorDarkTextColor];
    self.userNameLabel.text = [self reloadLogonName];
    [headerView addSubview:self.userNameLabel];
    
    WeakSelf;
    waveView.waveChangeBlock = ^(CGFloat currentY) {
        CGRect frame = logoImageView.frame;
        frame.origin.y = currentY - CGRectGetHeight(logoImageView.frame) - 5;
        logoImageView.frame = frame;
        weakSelf.userNameLabel.tj_y = CGRectGetMaxY(frame) + 5;
    };
    
    //下面是tableView
    CGFloat height = iPhoneX ? (SCREEN_HEIGHT - 83) : (SCREEN_HEIGHT - 49);
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:kMineCellReuseIdentifier];
    //设置底部view
    self.tableView.tableFooterView = [self defaultFooter];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

//设置默认的底部view
- (UIView *)defaultFooter {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor colorWhiteColor];
    //创建按钮
    self.loginButton = [[UIButton alloc] initWithFrame:view.bounds];
    //设置title
    [self.loginButton setTitle:[self reloadIsExist] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(logonIn) forControlEvents:UIControlEventTouchUpInside];
    //添加view
    [view addSubview:self.loginButton];
    return view;
}

//设置开始登陆
- (void)logonIn {
    if ([CacheManager sharedManager].isLogon) {
        //退出
        [self showExitSheet];
        return;
    }
    //创建开始登陆的控制器Vc
    WeakSelf;
    LoginViewController *logonVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:logonVC animated:YES];
    //登陆页面的回调
    logonVC.logonDidFinisedBlock = ^{
        [XDProgressHUD showHUDWithLongText:@"登录成功" hideDelay:1.0];
        [weakSelf updateObjects];
        [weakSelf starFrting];
    };
}

//设置推出登陆
- (void)logonOut {
    WeakSelf;
    if ([SecurityManager sharedInstance].state) {
        [[SecurityManager sharedInstance] openIsTouchIDWithController:self message:@"请进行TouchID指纹正确验证" block:^(BOOL success, NSString *message){
            [XDProgressHUD showHUDWithText:message hideDelay:1.0];
            if (success) {
                [weakSelf exit];
            }
        }];
    }else {
        // 直接退出
        [weakSelf exit];
    }
}

//推出
- (void)exit {
    [XDProgressHUD showHUDWithIndeterminate:@"Logout..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [XDProgressHUD hideHUD];
        [CacheManager sharedManager].isLogon = NO;
        [UD setBool:NO forKey:UD_LOGON_ISEXIT];
        [UD synchronize];
        [self updateObjects];
    });
}

// 开启&关闭指纹解锁
- (void)starFrting{
    [[SecurityManager sharedInstance] openIsTouchIDWithController:self message:@"是否开启TouchID指纹安全保护?" block:^(BOOL success, NSString *message) {
        [XDProgressHUD showHUDWithText:message hideDelay:1.0];
    }];
}

#pragma mark - Update UserInfo
- (void)updateObjects {
    self.userNameLabel.text  = [self reloadLogonName];
    self.logoImageView.image = [self reloadLogonImage];
    [self.loginButton setTitle:[self reloadIsExist] forState:UIControlStateNormal];
}

- (NSString *)reloadIsExist {
    return [CacheManager sharedManager].isLogon ? @"退出登录" : @"登录";
}

- (NSString *)reloadLogonName {
    return [CacheManager sharedManager].isLogon ? [self getRandomString] : @"";
}

- (NSString *)getRandomString {
    NSString *str = @"FunOnline";
    return [NSString stringWithFormat:@"%@%d", str, (int)(arc4random_uniform(500)+500)];
}
//刷新用户登陆的图片
- (UIImage *)reloadLogonImage {
    UIImage *image = nil;
    if ([CacheManager sharedManager].isLogon) {
        image = [UIImage imageNamed:@"mine_exist_logo"];
    }else {
        image = [UIImage imageNamed:@"icon_default_avatar"];
    }
    return image;
}

#pragma mark - TableView for data

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //显示数量
    return self.dataObjets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMineCellReuseIdentifier];
    if (self.dataObjets.count > indexPath.row) {
        cell.model = self.dataObjets[indexPath.row];
        if (indexPath.row == self.dataObjets.count-1) {
            cell.hideLine  = YES;
            cell.hideArrow = YES;
        }
    }
    return cell;
}

#pragma mark - TableView for delegate
//点击item后会调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self jumpFavorite];
    }else if (indexPath.row == 1) {
        [self showTips];
    }else if (indexPath.row == 2) {
        [self jumpFeedBack];
    }else if (indexPath.row == 3) {
        [self showClearSheet];
    }else if (indexPath.row == 4) {
        [self jumpUIKit];
    }else {
        [self jumpPalm];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return iPhone5 ? 44 : 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)showClearSheet {
    WeakSelf;
    [LEEAlert actionsheet].config
    .LeeTitle(@"温馨提示")
    .LeeContent(@"确定清除当前缓存吗? 图片会被清除")
    .LeeContent([CacheManager sharedManager].cacheSize)
    .LeeAction(@"YES", ^{
        [weakSelf animClear];
    })
    .LeeCancelAction(@"NO", ^{
        // 点击事件Block
    })
    .LeeShow();
}

//推出登陆
- (void)showExitSheet {
    WeakSelf;
    [LEEAlert actionsheet].config
    .LeeContent(@"是否退出登录")
    .LeeAction(@"YES", ^{
        [weakSelf logonOut];
    })
    .LeeCancelAction(@"NO", ^{
        // 点击事件Block
    })
    .LeeShow();
}



#pragma mark - Other for handle

- (void)jumpFavorite{
    FavoriteViewController *favoriteVC = [[FavoriteViewController alloc] init];
    [self.navigationController pushViewController:favoriteVC animated:YES];
}

- (void)jumpFeedBack{
    FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
    [self.navigationController pushViewController:feedBackVC animated:YES];
}

- (void)jumpPalm {
    NSString *app_id = @"asdevxcbwdgs";
    NSString *user_id = @"test-user";
    NSString *user_name = @"hzjR9ylax2KtZNYGGdJMGxP7RoI64ORsXtFgQQzmFQ7+EE1JjjV68NCdcwS/h82+OwcznywbMowErWB3xd0VnpGq9IfiDxtSmYrZsxIusXDV0sC46ecIIfJ1WS4IcIUwgizs5Adyn2BVjjlZpyJ80jXq1yUkzoopGFnwjPi8geT2vzKFbtwbvN19MVUksgdsJdZTmSptsOBwiL8wtt4RyLwWJQkjj0tdIfcAg/kBmGHo26X0gIvR85bLOJ1Ylfr6bs2p3ANrimChMcnDY1cW75kudassMwgV/jNYvdZW6/2Zllzyx79M0QFVfCb1poOfiSJX0JdmHPk7UHJhXZqptg==";
    NSString *phone_no = @"T2aR5g99OIgUVuoxeHk7xMb/UYtY698MY3Yu7b92whlRQdFRQ0evsu1o8ONaCunNqra7m+hvhxlJ+1OPVfu4LzVh+OsYRrDYUO3zcFoLYPw0GCGSG64Og2Rq0K73pHhLGiBJVQOeAv7yT0BACW2dMvBuFQusPdgwWZ3AS6lKLrdeiaUWv7yw80Q3EykzluGS+tYqElBgyLQ6atwDP6wmMG2ouglx5hSEU9CBOtytbZCbifdLQU9U0l6dwHF5Ldo+sZe2FYIr575UhuirOfpwFEQiskk7e24JV8bcdjiTrOXvjnN6qdKZE9ONclCUAUaFIeIllcBeKa53MVpjct48tg==";
    NSString *payment_token = @"nct915fN7D8zekbfBjSEg3ZAN31QjpssjWeB/DJKs5Q1x5+uIxGpXWnDeoD4UhBVA1h2gJ17nVJ4+YISJCMLTeOPC5qj3LlVTtq3mH2YpX1/SLMGXXwB6d3akQwTGNoF+IjQ5UvlZkVO0beNYNHgzUTx4l6R3Ptguh15Z8lEcCpz+nqpsv+0rDzt2qP0fALb3Hcs9XpddnhCI/i1k5OV/tTRmtufJiz8oLWCk/oHkr9Pucm1GskhSElU7MskBzMMuxN91vLPTG9HPLLHipMXwdYJT2JOrkinmaES7ZFwpzNV1SrO+Hnsg2pPZT662cNljNZzAUdwwE7KzfHZlLeOvQ==";
    long timestamp = 1736931456;
    NSString *nonce = @"aneuxo3847s4mf7xk";
    NSString *sign = @"ikj+ScyrAoigMK2jKwaqFeit0ilizzelFh+KDG+tOjBYchVrmZz9Ea085+JGamVZjbCGi9VEKXjo8kDIiAqw8sNkBVuCEPB8L6U/+fp97ITNLc6Tqb6Klu6FI1/pHpXXBAaOeKpLV7hZ0zWux246hWV/eKub7pZR2Miwn9vktt5lFTWeQsGNte7peNNKoAG+qZP+s8zM4F4F468sLUZResGF3hXoidleT4peYuMiPti/bcn+V8Q0mpbavbyLocDAfBp+9UZuNNX0LjS0XiiWeoOhv+jBSoH2B8Mh1KCysY/BGfE9FiATuecmd5sQQSbDFahDkOtxyWbsAXuMrpiBJw==";
    
    //初始化语言
    [WeCardPalmHelper.instance initWithLanguage:LANG_JA];
    
    /**
     * @brief 初始化参数
     *
     * @param context      上下文
     * @param userId       用户唯一标识
     * @param userName     用户名称
     * @param phoneNo      用户手机号（带区号）
     * @param paymentToken 支付凭证
     * @param appID        应用id（微卡提供）
     * @param timestamp    时间戳（秒）
     * @param nonce        随机字符串
     * @param signature    签名
     */
    RequestAuthParams *params = [[RequestAuthParams alloc] initWithParams:user_id userName:user_name phoneNo:phone_no paymentToken:payment_token timestamp:timestamp nonce:nonce appID:app_id signature:sign side:SIDE_UNKNOWN];
    PalmRegisterListener plamBlock = ^(NSInteger code , NSString * _Nullable msg) {
        NSLog(@"palm , callback1 :%ld,%@", (long)code, msg);
    };
    //跳转控制器
    [WeCardPalmHelper.instance startPalmRegister: self params:params callback:plamBlock];
}

- (void)jumpUIKit{
    DemoViewController *demoVc = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:demoVc animated:YES];
}

- (void)showTips{
    [LEEAlert alert].config
    .LeeTitle(@"温馨提示")
    .LeeContent(@"应用上架AppStore后，就可以评论了哟")
    .LeeAction(@"OK", ^{
        
    })
    .LeeOpenAnimationStyle(LEEAnimationStyleZoomEnlarge | LEEAnimationStyleFade) //这里设置打开动画样式的方向为上 以及淡入效果.
    .LeeCloseAnimationStyle(LEEAnimationStyleZoomShrink | LEEAnimationStyleFade) //这里设置关闭动画样式的方向为下 以及淡出效果
    .LeeShow();
}

- (void)animClear {
    [XDProgressHUD showHUDWithIndeterminate:@"正在清除..."];
    //时间
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    //主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //延迟
    dispatch_after(time, queue, ^{
        [XDProgressHUD hideHUD];
        [[CacheManager sharedManager] clearCache];
    });
}

@end
