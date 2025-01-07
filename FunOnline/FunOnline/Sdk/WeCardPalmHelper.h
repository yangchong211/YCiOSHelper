//
//  Created by 杨充 on 2024/12/24.
//


#import <Foundation/Foundation.h>
#import "PalmLangEnum.h"


@interface WeCardPalmHelper : NSObject


/**
 *  单例
 *  instancetype 是一个特殊的关键字，用于表示当前类的实例类型。它可以用作方法的返回类型，以确保返回的对象类型与调用方法的类一致。
 *  instancetype 的使用场景通常是在类方法中，用于返回当前类的实例。相比于使用 id 类型，使用 instancetype 可以提供更准确的类型信息，使代码更具可读性和类型安全性。
 */
+ (instancetype) instance;


/**
 * 初始化
 * 第一个参数是语言
 * 第二个参数是授权信息
 */
- (void) initWithLanguage: (PalmLangEnum) lang license:(nonnull NSString *) lic;

/**
 * 获取外部设置的语言
 */
- (NSString *) getLangString: (PalmLangEnum) lang;

@end
