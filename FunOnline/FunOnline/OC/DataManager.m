//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()


@end

@implementation DataManager

+ (instancetype) dataInstance {
    static DataManager *instance = nil;
    static dispatch_once_t onceToken;
    //使用 dispatch_once 函数确保只有一个线程能够执行实例化代码。
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

- (void) clearCache {
    NSLog(@"开始清除缓存");
}

- (NSString *) getAppVersion {
    return @"1.0.1";
}

@end
