//
//  MyClass.h
//  ObjCApp
//
//  Created by 杨充 on 2024/12/23.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

//接口

@interface Vehicle : NSObject

@property (nonatomic, strong) NSString *brand;
@property (nonatomic, assign) NSInteger year;

- (void)startEngine;
- (void)stopEngine;

@end
