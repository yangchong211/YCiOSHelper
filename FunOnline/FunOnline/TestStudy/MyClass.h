//
//  MyClass.h
//  ObjCApp
//
//  Created by 杨充 on 2024/12/23.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"

@interface MyClass : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)doSomething;
- (NSInteger)calculateSumWithNumber:(NSInteger)number1 andNumber:(NSInteger)number2;
- (NSString *)greetWithName:(NSString *)name;

@end
