//
//  Created by 杨充 on 2024/12/24.
//

#import <UIKit/UIKit.h>

//学习数据存储
@interface BeanPalmStatus : NSObject

//返回的code
@property (nonatomic, assign) NSInteger code;
//返回的msg
@property (nonatomic, strong) NSString* message;
/**
 * "Unregistered" // 未录掌
 * "PreRegistered" // 预录入
 * "Registered" // 已录掌
 */
@property (nonatomic, assign) NSString* palm_status;

@end
