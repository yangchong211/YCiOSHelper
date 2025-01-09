//
//  NSString+CustomMethods.m
//  ObjCApp
//
//  Created by 杨充 on 2024/12/24.
//

#import <Foundation/Foundation.h>
#import "NSString+CustomMethods.h"

@implementation NSString (CustomMethods)

//反转字符串
- (NSString *)reversedString {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger length = [self length];
    for (NSInteger i = length - 1; i >= 0; i--) {
        [reversedString appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:i]]];
    }
    return reversedString;
}

@end
