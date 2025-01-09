
#import <UIKit/UIKit.h>


@interface NSBundle (Palm)

/** 默认使用的语言版本, 默认为 nil. 将随系统的语言自动改变 */
@property (copy, nonatomic, nullable) NSString *languageCode;


/** 默认使用的语言资源文件名, 默认为 nil, 即默认的 Localizable.strings.
 
 - Attention: 文件名不包含后缀.strings
 */
@property (copy, nonatomic, nullable) NSString *i18nFilename;

+ (instancetype) refreshBundle;
+ (UIImage *) arrowImage;
+ (UIImage *) trailArrowImage;
+ (NSString *) localizedStringForKey:(NSString *)key value:(nullable NSString *)value;
+ (NSString *) localizedStringForKey:(NSString *)key;

@end
