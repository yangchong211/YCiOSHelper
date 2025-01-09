//
//  Car.h
//  ObjCApp
//
//  Created by 杨充 on 2024/12/24.
//

#import <Foundation/Foundation.h>
#import "MyProtocolClass.h"
#import "MyProtocol.h"

//协议可以被类遵循（adopted），表示该类将实现协议中定义的方法。类可以通过在 @interface 中使用 <协议名> 来遵循一个或多个协议。
@interface MyProtocolClass : NSObject<MyProtocol>

@end







