
//
//  PalmUIColor+Extension.h
//
//  Created by 杨充 on 2024/12/23.
//


#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**16进制色*/
+ (UIColor *)colorHexString:(NSString *)colorStr;

+(UIColor *)colorWithRandom;

@end
