//
//  Created by 杨充 on 2024/12/24.
//


#import <Foundation/Foundation.h>
#import "PalmControllerDelegate.h"

//@protocol 是用于声明协议（Protocol）的关键字。协议定义了一组方法，用于描述类或对象应该遵循的行为和功能。
@protocol PalmControllerDelegate

//协议中的方法声明与类中的方法声明类似，使用以下语法：- (返回类型)方法名;

- (void) sendPalmBack:(NSInteger)code data: (NSString *)data;

@end







