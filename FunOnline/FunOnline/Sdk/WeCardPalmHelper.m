//
//  Created by 杨充 on 2024/12/24.
//


#import "WeCardPalmHelper.h"

@interface WeCardPalmHelper ()


@end

@implementation WeCardPalmHelper

+ (instancetype) instance {
    static WeCardPalmHelper *instance = nil;
    static dispatch_once_t onceToken;
    //使用 dispatch_once 函数确保只有一个线程能够执行实例化代码。
    dispatch_once(&onceToken, ^{
        instance = [[WeCardPalmHelper alloc] init];
    });
    return instance;
}

/**
 * 初始化
 * 第一个参数是语言
 * 第二个参数是授权信息
 */
- (void) initWithLanguage: (PalmLangEnum) lang license:(nonnull NSString *) lic {
    NSString * palmLang = [self getLangString:lang];
    //打印字符串
    NSLog(@"Palm,initWithLanguage lang  %@" , palmLang);
    NSLog(@"Palm,initWithLanguage lic  %@" , lic);
}

- (NSString *) getLangString: (PalmLangEnum) lang {
    switch (lang) {
        case LanguageEnumLANGKNOWN:
            return @"Unknown";
        case LanguageEnumLANGEN:
            return @"英文";
        case LanguageEnumLANGZH:
            return @"中文";
        case LanguageEnumLANGJA:
            return @"日语";
        default:
            return @"Unknown";
    }
}

@end
