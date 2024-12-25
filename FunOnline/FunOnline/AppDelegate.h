//
//  AppDelegate.h
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>


//@interface 是用于声明类的接口的关键字。它用于定义一个类的属性、方法和委托等信息。
//一个典型的 @interface 声明通常包含在头文件（.h）中，用于公开类的接口，以便其他类可以访问和使用该类的属性和方法。
//@interface 关键字后面是类的名称 AppDelegate，紧接着是继承的父类 UIResponder。然后，使用大括号 {} 包含了类的属性和方法的声明。
//@interface 只是类的声明部分，具体的实现部分需要在实现文件（.m）中进行。
@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property 是用于声明类的属性的关键字。它用于定义类的实例变量，并自动生成对应的 getter 和 setter 方法。
//@property 声明通常包含在类的接口文件（.h）中，用于公开类的属性，以便其他类可以访问和使用这些属性。
//nonatomic 是一个属性修饰符，用于指定属性的线程安全性。strong 是一个内存管理修饰符，用于指定属性的引用计数策略。
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *currentNav;

@end

