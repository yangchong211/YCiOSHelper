

#import "NSBundle+Palm.h"

static NSBundle *defaultI18nBundle = nil;
static NSBundle *systemI18nBundle = nil;

@implementation NSBundle (Palm)

+ (instancetype) refreshBundle {
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        #ifdef SWIFT_PACKAGE
        NSBundle *containnerBundle = SWIFTPM_MODULE_BUNDLE;
        #else
        NSBundle *containnerBundle = [NSBundle bundleForClass:[MJRefreshComponent class]];
        #endif
        refreshBundle = [NSBundle bundleWithPath:[containnerBundle pathForResource:@"palmsdk" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *) arrowImage {
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (UIImage *) trailArrowImage {
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"trail_arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *) localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil];
}

- (NSString *) localizedStringForKey:(NSString *)key value:(NSString *)value {
    NSString *table = self.i18nFilename;
    // 如果没有缓存, 则走初始化逻辑
    if (defaultI18nBundle == nil) {
        NSString *language = self.languageCode ?  language : @"zh";
        // 如果配置中没有配置语言
        if (!language) {
            language = [NSLocale preferredLanguages].firstObject;
        }
        NSBundle *bundle = nil;
        // 首先优先使用公共配置中的 i18nBundle, 如果为空则使用 mainBundle
        bundle = bundle ? bundle : NSBundle.mainBundle;
        // 按语言选取语言包
        NSString *i18nFolderPath = [bundle pathForResource:language ofType:@"lproj"];
        defaultI18nBundle = [NSBundle bundleWithPath:i18nFolderPath];
        // 检查语言包, 如果没有查找到, 则默认使用 mainBundle
        defaultI18nBundle = defaultI18nBundle ? defaultI18nBundle : NSBundle.mainBundle;
        // 获取自有的语言包
//        if (systemI18nBundle == nil) {
//            systemI18nBundle = [self defaultI18nBundleWithLanguage:language];
//        }
    }
    // 首先在 sdk 内置语言文件中寻找
    value = [systemI18nBundle localizedStringForKey:key value:value table:nil];
    // 然后在 MainBundle 对应语言文件中寻找
    value = [defaultI18nBundle localizedStringForKey:key value:value table:table];
    return value;
}

+ (NSBundle *) defaultI18nBundleWithLanguage:(NSString *)language {
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        language = @"zh";
    } else if ([language hasPrefix:@"ja"]) {
        language = @"ja";
    } else {
        language = @"en";
    }
    // 从Xxx.bundle中查找资源
    return [NSBundle bundleWithPath:[[NSBundle refreshBundle] pathForResource:language ofType:@"lproj"]];
}
@end
