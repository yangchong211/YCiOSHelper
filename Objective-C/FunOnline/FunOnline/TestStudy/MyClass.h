//
//  MyClass.h
//  ObjCApp
//
//  Created by 杨充 on 2024/12/23.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"

//@interface 是用于声明类的接口的关键字。它用于定义类的属性、方法和其他成员。
@interface MyClass : NSObject

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
