//
//  Created by 杨充 on 2024/12/24.
//

#import <UIKit/UIKit.h>
#import "RequestAuthParams.h"
#import "PalmRequestManager.h"
#import "PalmRequestHeaders.h"
#import "PalmUIColor+Extension.h"
#import "PalmControllerDelegate.h"
#import "BeanAuthData.h"
#import "BeanPalmStatus.h"
#import "BeanLicense.h"
#import "WeCardPalmHelper.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "CircleView.h"
#import "NSObject+Additions.h"
#import "PalmRegisterError.h"
#import "NSBundle+Palm.h"
#import "NSObject+Additions.h"

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

// 声明 block 类型的属性
@property (nonatomic, copy) PalmRegisterListener plamBlock;

@end
