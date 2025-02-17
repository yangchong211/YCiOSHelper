//
//  Created by 杨充 on 2024/12/24.
//


#import "WeCardPalmHelper.h"
#import "RequestAuthParams.h"
#import "PalmRegisterViewController.h"
#import "NSObject+Additions.h"


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
 * @param lang 第一个参数是语言
 * @param lic 第二个参数是授权信息
 */
- (void) initWithLanguage: (PalmLangEnum) lang{
    NSString * palmLang = [self getLangString:lang];
    //直接赋值
    self.languageCode = palmLang;
    //打印字符串
    NSLog(@"Palm , initWithLanguage lang  %@" , self.languageCode);
}


/**
 * 初始化优图鉴权
 * @param sdkLicense 优图授权
 */
- (void) initAirPalmKit: (NSString *) sdkLicense {
    NSLog(@"Palm , initAirPalmKit 初始化微信sdk");
    NSString *securePubKey = @"0411ec4f1fca7026556f2969d7776dab0025e3eb147371367f127db27fd0bf0a1d04de394891d366663e02d7bb42965c5017b11cfb46ab459acef88a9cb32eff5e";
//    DBLanguageEnum enumLang;
//    //获取外部设置的语言
//    NSString *language = WeCardPalmHelper.instance.languageCode;
//    if ([language isEqualToString:@"en"]) {
//        enumLang = DBLanguageEnumLANGEN;
//    } else if ([language isEqualToString:@"zh"]) {
//        enumLang = DBLanguageEnumLANGZH;
//    } else if ([language isEqualToString:@"ja"]) {
//        enumLang = DBLanguageEnumLANGJA;
//    } else {
//        enumLang = DBLanguageEnumLANGEN;
//    }
//    //添加微信sdk初始化代码
//    AirPalmInitializerImpl *airpalmInitializer = [[AirPalmInitializerImpl alloc] init];
//    DBAirPalmInitParams *airPalmInitParams = [[DBAirPalmInitParams alloc] initWithLanguage:enumLang sdkLicense:sdkLicense securePubKey:securePubKey];
//    [AirPalmKit initAlogKit:airpalmInitializer params:airPalmInitParams];
}


/**
 * @brief 启动微卡空中录掌页面
 *
 * @param controller 启动页面的ViewController
 * @param params 启动参数
 * @param callback 线上绑掌结果回调
 */
- (void)startPalmRegister:(nonnull UIViewController *)controller params:(nonnull RequestAuthParams *)params callback:(PalmRegisterListener) listener {
    NSLog(@"Palm , 启动微卡空中录掌页面");
    //创建空中录掌控制器
    PalmRegisterViewController *vc = [[PalmRegisterViewController alloc] init];
    //设置block。这里必须赋值，否则不回调
    vc.plamBlock = listener;
    //设置参数
    vc.params = params;
    //通过路由跳转
    [controller.navigationController pushViewController:vc animated:YES];
}

/**
 * 获取外部设置的语言
 */
- (NSString *) getLangString: (PalmLangEnum) lang {
    switch (lang) {
        case LANG_KNOWN:
            return @"Unknown";
        case LANG_EN:
            return @"en";
        case LANG_ZH:
            return @"zh";
        case LANG_JA:
            return @"ja";
        default:
            return @"Unknown";
    }
}


@end
