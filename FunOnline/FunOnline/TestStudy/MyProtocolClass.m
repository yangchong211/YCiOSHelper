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
    NSLog(@"MyProtocolClass Doing something");
}

- (NSString *) getName {
    return @"MyProtocolClass";
}

@end


