//
//  WallpaperViewController.h
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OcHelper.h"

//学习数据存储
@interface OcHelper : NSObject

//@property 用于声明属性，它指定了属性的类型、访问修饰符和其他属性特性。
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

//可以使用构造方法（Constructor）来创建具有参数的对象。构造方法是一种特殊的方法，用于初始化对象并设置其属性。
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;
+ (instancetype)initWithName:(NSString *)name age:(NSInteger)age;

//方法声明：- (返回类型)方法名:(参数类型)参数名;
- (void)doSomething;
- (NSInteger)calculateSumWithNumber:(NSInteger)number1 andNumber:(NSInteger)number2;
- (NSString *)greetWithName:(NSString *)name;

@end
