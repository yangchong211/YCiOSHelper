//
//  Created by 杨充 on 2024/12/24.
//


#import <UIKit/UIKit.h>

//鉴权接口实体类
@interface BeanAuthData : NSObject

//返回的code和msg
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * message;
//用户token
@property (nonatomic, strong) NSString * userToken;
//traceId
@property (nonatomic, strong) NSString * traceId;

@end
