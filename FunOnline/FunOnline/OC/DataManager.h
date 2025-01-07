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
 *  instancetype 是一个特殊的关键字，用于表示当前类的实例类型。它可以用作方法的返回类型，以确保返回的对象类型与调用方法的类一致。
 *  instancetype 的使用场景通常是在类方法中，用于返回当前类的实例。相比于使用 id 类型，使用 instancetype 可以提供更准确的类型信息，使代码更具可读性和类型安全性。
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
