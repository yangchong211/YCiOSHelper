//
//  Created by 杨充 on 2024/12/24.
//


#import "RequestAuthParams.h"

@implementation RequestAuthParams

//初始化参数
- (nonnull instancetype)initWithParams:(nonnull NSString *)userId
                               userName:(nonnull NSString *)userName
                                phoneNo:(nonnull NSString *)phoneNo
                           paymentToken:(nonnull NSString *)paymentToken
                             timestamp:(NSInteger)timestamp
                                  nonce:(nonnull NSString *)nonce
                                  appID:(nonnull NSString *)appID
                             signature:(nonnull NSString *)signature {
    RequestAuthParams *params = [[RequestAuthParams alloc] init];
    //todo 看看这里是否需要添加参数校验
    params.userId = userId;
    params.userName = userName;
    params.phoneNo = phoneNo;
    params.paymentToken = paymentToken;
    params.timestamp = timestamp;
    params.nonce = nonce;
    params.appID = appID;
    params.signature = signature;
    //打印传递的参数
    [self printParams:params];
    return params;
}

- (void) printParams: (RequestAuthParams *) params {
    NSString *result = [NSString stringWithFormat:@"%@ %@ %@ %@ %d %@ %@ %@",
                        params.userId, params.userName,
                        params.phoneNo,params.paymentToken,
                        params.timestamp,params.nonce,
                        params.appID,params.signature];
    NSLog(@"Palm , printParams result  %@" , result);
}

@end
