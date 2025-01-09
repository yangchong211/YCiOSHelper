//
//  AppDelegate+Utils.m
//  FoodCourt
//
//  Created by Original_TJ on 2018/3/12.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "AppDelegate+Utils.h"
#import <IQKeyboardManager.h>
#import <AFNetworking.h>

#ifdef DEBUG
//debug环境
#define kGtAppId           @"LRXdu2zBbr7LlFgpmOlxT9"
#define kGtAppKey          @"ELYXgbGb5x93KzjVgAxUoA"
#define kGtAppSecret       @"iTJNX0TTz09jZq8zmoun8"
#else
//else 正式环境
#define kGtAppId           @"By3KWhQXle8wyGPdwnkzQ9"
#define kGtAppKey          @"T8VSQE13Gm8NNrpXYwnlx2"
#define kGtAppSecret       @"1YAtuauCD879eO5S9nCbu2"
#endif

@implementation AppDelegate (Utils)


/** 自定义消息推送处理 */
- (void)handlePushWithUserInfo:(NSDictionary *)userInfo {}



#pragma mark - AppConfig
- (void)initialAppUtil
{
    [self startNetState];
    [self appearanceSetup];
    [self configIQManager];
}

- (void)configIQManager
{
    [IQKeyboardManager sharedManager].enable = YES; // 控制整个功能是否启用
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
}

/**
 *  iOS 11 tableView的统一适配
 */
- (void)appearanceSetup {
    
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UICollectionView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark - network state
- (void)startNetState {
    __block BOOL isStatus = NO;
    
    // 开启网络指示器
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 监听网络状态的改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //[XDHub showFailWithStatus:@"未知网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                [XDProgressHUD showHUDWithText:@"当前网络已断开，请检查联网设置" hideDelay:1.5];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //[XDHub showSuccessWithStatus:@"已切换到3G|4G网络"];
                isStatus = YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //[XDHub showSuccessWithStatus:@"已连接到WiFi网络"];
                isStatus = YES;
                break;
                
            default:
                break;
        }
        
        NSLog(@"isStatus --- %@", isStatus ? @"YES": @"NO");
    }];
    
    [manager startMonitoring];
}

@end

