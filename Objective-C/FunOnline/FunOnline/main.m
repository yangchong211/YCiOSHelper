//
//  main.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    //@autoreleasepool 是 Objective-C 中用于创建自动释放池的关键字。
    //自动释放池用于管理内存中的临时对象，以便在适当的时候释放它们，从而减少内存占用。
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
