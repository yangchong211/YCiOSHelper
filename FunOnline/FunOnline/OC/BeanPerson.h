//
//  WallpaperViewController.h
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//
#import <UIKit/UIKit.h>

//学习数据存储
@interface BeanPerson : NSObject

//atomic:属性设置里面默认的就是atomic，意思就是setter/getter函数是一个原子操作
//nonatomic：指出访问器不是原子操作，而默认地，访问器是原子操作。一般不需要多线程支持的时候就用它
//readonly：此标记说明属性是只读的，默认的标记是读写，如果你指定了只读，在@implementation中只需要一个读取器。
//readwrite：此标记说明属性会被当成读写的，这也是默认属性。设置器和读取器都需要在@implementation中实现。如果使用@synthesize关键字，读取器和设置器都会被解析。
//assign：对基础数据类型 （NSInteger，CGFloat）和C数据类型（int, float, double, char, 等等）
//retain：对其他NSObject和其子类，对参数进行release旧值，再retain新值
//copy：对NSString 它指出，在赋值时使用传入值的一份拷贝。拷贝工作由copy方法执行，此属性只对那些实行了NSCopying协议的对象类型有效。


@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) BOOL isSpeakEnglish;
@property (nonatomic, strong) NSString * city;

@end
