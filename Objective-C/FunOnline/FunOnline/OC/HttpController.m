//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "HttpController.h"
#import "RequestManager.h"
#import "RequestHeaders.h"
#import <MJExtension/MJExtension.h>
#import "BeanPerson.h"

@interface HttpController ()


@end

@implementation HttpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWhiteColor];
    [self testHttp];
    [self testJson1];
    [self testJson2];
}

- (void) testEasy {
    
}

- (void) testHttp {
    //get请求
    [[RequestManager manager] GET:url_article parameters:nil success:^(id  _Nullable responseObj) {
        NSLog(@"GET请求 JSON: %@", responseObj);
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"GET请求 Error: %@", error);
    }];
    
    
    //post请求
    //NSDictionary *parameters = @{@"key1": @"value1", @"key2": @"value2"};
    NSDictionary *parameters = @{@"username": @"yangchong", @"password": @"yc123456"};
    [[RequestManager manager] POST:url_login parameters:parameters success:^(id  _Nullable responseObj) {
        NSLog(@"POST请求 JSON: %@", responseObj);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"POST请求 Error: %@", error);
    }];
}

- (void) testJson1 {
    //可以使用 NSJSONSerialization 类来解析 JSON 数据。
    //NSJSONSerialization 是 Foundation 框架提供的类，用于将 JSON 数据转换为 Objective-C 对象。
    NSError *error = nil;
    NSData *jsonData = [@"{\"name\":\"John\",\"age\":30,\"city\":\"New York\"}" dataUsingEncoding:NSUTF8StringEncoding];

    // 解析 JSON 数据
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *)jsonObject;
            NSString *name = jsonDict[@"name"];
            NSNumber *age = jsonDict[@"age"];
            NSString *city = jsonDict[@"city"];
            NSLog(@"Name: %@", name);
            NSLog(@"Age: %@", age);
            NSLog(@"City: %@", city);
        }
    }
}

- (void) testJson2 {
    // 将 JSON 数据转换为模型对象
    NSLog(@"将 JSON 数据转换为模型对象");
    NSDictionary *jsonDict = @{@"name": @"John", @"age": @30, @"city": @"New York",@"isSpeakEnglish": @true};
    //使用 mj_objectWithKeyValues: 方法将 JSON 数据转换为 Person 对象
    BeanPerson *person = [BeanPerson mj_objectWithKeyValues:jsonDict];
    NSLog(@"Name: %@", person.name);
    //NSLog(@"Age: %@", person.age);
    NSLog(@"City: %@", person.city);
    
    
    // 将模型对象转换为 JSON 数据
    NSLog(@"将模型对象转换为 JSON 数据");
    //使用 mj_keyValues 方法将 Person 对象转换为 JSON 数据
    NSDictionary *personDict = [person mj_keyValues];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:personDict options:NSJSONWritingPrettyPrinted error:nil];
    //将实体对象转化为字符串
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON: %@", jsonString);
}


@end
