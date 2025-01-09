//
//  MyClass.m
//  ObjCApp
//
//  Created by 杨充 on 2024/12/23.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"

//@interface MyClass () 是一种类扩展（Class Extension）的语法，用于在类的实现文件（.m）中声明私有属性和方法。
@interface MyClass ()

@end

@implementation MyClass

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
    }
    return self;
}

+ (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    MyClass *model = [[MyClass alloc] init];
    model.name = name;
    model.age = age;
    return model;
}

- (void)doSomething {
    NSLog(@"Doing something...");
}

- (NSInteger)calculateSumWithNumber:(NSInteger)number1 andNumber:(NSInteger)number2 {
    return number1 + number2;
}

- (NSString *)greetWithName:(NSString *)name {
    //return name + "杨充";
    return [NSString stringWithFormat:@"%@ %s", name, "打工充"];
}

- (NSInteger) age {
    return 29;
}

@end
