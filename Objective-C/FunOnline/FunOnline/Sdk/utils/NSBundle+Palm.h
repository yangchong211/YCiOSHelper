
#import <UIKit/UIKit.h>
#import "WeCardPalmHelper.h"
#import "NSObject+Additions.h"

@interface NSBundle (Palm)

//获取语言文案
+ (NSString *) localizedStringForKey:(NSString *)key value:(nullable NSString *)value;
//获取语言文案
+ (NSString *) localizedStringForKey:(NSString *)key;

@end
