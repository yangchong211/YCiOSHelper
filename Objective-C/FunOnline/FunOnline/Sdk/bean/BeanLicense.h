//
//  Created by 杨充 on 2024/12/24.
//


#import <UIKit/UIKit.h>

//鉴权接口实体类
@interface BeanLicense : NSObject

//返回的code
@property (nonatomic, assign) NSInteger code;
//返回的msg
@property (nonatomic, strong) NSString * message;
//优图授权信息
@property (nonatomic, strong) NSString * license;

@end
