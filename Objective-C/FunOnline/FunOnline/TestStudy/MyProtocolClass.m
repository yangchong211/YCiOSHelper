//
//  MyProtocolClass.m
//  ObjCApp
//
//  Created by 杨充 on 2024/12/24.
//

#import <Foundation/Foundation.h>
#import "MyProtocol.h"
#import "MyProtocolClass.h"



@implementation MyProtocolClass

- (void) doSomething {
    // 实现协议中的方法
    NSLog(@"MyProtocolClass Doing something");
}

- (NSString *) getName {
    // 实现协议中的方法
    return @"MyProtocolClass";
}

@end


