//
//  Created by 杨充 on 2024/12/24.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PalmLangEnum.h"
#import "RequestAuthParams.h"

//常见的typedef定义，用于定义一个block类型。这个block类型接受两个参数，一个是NSInteger类型的code，另一个是NSString类型的可选msg。
//https://blog.51cto.com/u_16213440/11391183
typedef void (^PalmRegisterListener)(NSInteger code , NSString * _Nullable msg);


//在Objective-C中，方法定义中的"+"和"-"符号用于表示类方法和实例方法。
//"+" 符号表示类方法，也称为静态方法。类方法是属于类本身的方法，而不是类的实例。
//"-" 符号表示实例方法，也称为对象方法。实例方法是属于类的实例的方法，必须通过类的实例来调用。

@interface WeCardPalmHelper : NSObject

/**
 * 设置的语言
 */
@property (copy, nonatomic, nullable) NSString *languageCode;

/**
 *  单例
 *  instancetype 是一个特殊的关键字，用于表示当前类的实例类型。它可以用作方法的返回类型，以确保返回的对象类型与调用方法的类一致。
 *  instancetype 的使用场景通常是在类方法中，用于返回当前类的实例。相比于使用 id 类型，使用 instancetype 可以提供更准确的类型信息，使代码更具可读性和类型安全性。
 */
+ (instancetype _Nullable) instance;


/**
 * 初始化语言
 * @param lang 第一个参数是语言
 * @param lic 第二个参数是授权信息
 */
- (void) initWithLanguage: (PalmLangEnum) lang;


/**
 * 初始化优图鉴权
 * @param sdkLicense 优图授权
 */
- (void) initAirPalmKit: (NSString *) sdkLicense;

/**
 * @brief 启动微卡空中录掌页面
 *
 * @param controller 启动页面的ViewController
 * @param params 启动参数
 * @param callback 线上绑掌结果回调
 */
- (void)startPalmRegister:(nonnull UIViewController *)controller params:(nonnull RequestAuthParams *)params callback:(PalmRegisterListener) listener;


@end
