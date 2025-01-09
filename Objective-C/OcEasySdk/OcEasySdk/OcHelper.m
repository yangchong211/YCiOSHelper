//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "OcHelper.h"

@interface OcHelper ()


@end

@implementation OcHelper

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
    }
    return self;
}

+ (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    OcHelper *model = [[OcHelper alloc] init];
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
