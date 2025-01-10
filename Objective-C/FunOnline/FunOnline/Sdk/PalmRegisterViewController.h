//
//  Created by 杨充 on 2024/12/24.
//

#import <UIKit/UIKit.h>
#import "RequestAuthParams.h"
#import "PalmRequestManager.h"
#import "PalmRequestHeaders.h"
#import "PalmUIColor+Extension.h"
#import "PalmControllerDelegate.h"
#import "PalmUIColor+Extension.h"
#import "BeanAuthData.h"
#import "BeanPalmStatus.h"

//空中录掌UI
@interface PalmRegisterViewController : UIViewController

//需要传递的参数
@property (nonatomic, strong) RequestAuthParams* params;

//后台id
@property (nonatomic, strong) NSString * token;

//协议token
@property (nonatomic, strong) NSString * traceId;

//是否鉴权成功
@property (nonatomic, assign) BOOL isAuthSuccess;

@end
