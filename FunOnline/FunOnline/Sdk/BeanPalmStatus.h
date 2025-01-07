//
//  WallpaperViewController.h
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//
#import <UIKit/UIKit.h>

//学习数据存储
@interface BeanPalmStatus : NSObject

//返回的code和msg
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * message;
//// 1: 已录掌 0: 未录掌
@property (nonatomic, assign) NSInteger palmStatus;

@end
