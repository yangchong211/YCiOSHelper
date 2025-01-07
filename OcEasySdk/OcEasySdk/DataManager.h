//
//  WallpaperViewController.h
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//
#import <Foundation/Foundation.h>

//学习数据存储
@interface DataManager : NSObject

/**
 是否登录
 */
@property (nonatomic, assign) BOOL isLogon;

/**
 *  单例
 */
+ (instancetype) dataInstance;

/**
 清除当前图片缓存
 */
- (void) clearCache;

/**
 获取版本号
 */
- (NSString *) getAppVersion;


@end
