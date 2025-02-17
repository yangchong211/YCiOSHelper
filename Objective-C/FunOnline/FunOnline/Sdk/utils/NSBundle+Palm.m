

#import "NSBundle+Palm.h"



@implementation NSBundle (Palm)


+ (NSString *) localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil];
}

+ (NSString *) localizedStringForKey:(NSString *)key value:(NSString *)value {
    //获取外部设置的语言
    NSString *languageCode = WeCardPalmHelper.instance.languageCode;
    //NSLog(@"Palm , localizedStringForKey lang  %@" , languageCode);
    //如果获取为空，则默认是中文
    NSString *language = ([languageCode isEmpty]) ? @"zh" : languageCode;
    //NSLog(@"Palm , localizedStringForKey language  %@" , language);
    //获取bundle
    NSBundle *bundle = [self defaultI18nBundleWithLanguage :language];
    //获取语言
    value = [bundle localizedStringForKey:key value:value table:nil];
    //返回数据
    return value;
}

+ (NSBundle *) defaultI18nBundleWithLanguage:(NSString *) language {
    if ([language isEqualToString:@"en"]) {
        language = @"en";
    } else if ([language isEqualToString:@"zh"]) {
        language = @"zh";
    } else if ([language isEqualToString:@"ja"]) {
        language = @"ja";
    } else {
        language = @"en";
    }
    //NSLog(@"Palm , defaultI18nBundleWithLanguage lang  %@" , language);
    //使用[NSBundle mainBundle]获取应用程序的主bundle。
    NSBundle *mainBundle = [NSBundle mainBundle];
    //第一步：如何获取指定bundle
    //NSBundle类提供了pathForResource:ofType:方法，用于获取指定资源文件的路径。
    //这个方法可以用于获取应用程序包中的资源文件的完整路径。
    NSString *bundlePath = [mainBundle pathForResource:@"palmsdk" ofType:@"bundle"];
    NSBundle *palmBundle = [NSBundle bundleWithPath:bundlePath];
    //第二步：获取bundle文件中的翻译
    //按语言选取语言包，找到对应的lproj文件路径
    NSString *path = [palmBundle pathForResource:language ofType:@"lproj"];
    //从Xxx.bundle中查找资源，找到对应的NSBundle
    //NSBundle类提供了bundleWithPath:方法，用于创建一个指定路径的bundle对象。这个方法可以用于加载指定路径下的资源文件或插件。
    return [NSBundle bundleWithPath:path];
    //如果指定路径下存在有效的bundle文件，bundleWithPath:方法将返回一个NSBundle对象。否则，它将返回nil。
}
@end
