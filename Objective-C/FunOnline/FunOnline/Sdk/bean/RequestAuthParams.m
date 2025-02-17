//
//  Created by 杨充 on 2024/12/24.
//


#import "RequestAuthParams.h"

@implementation RequestAuthParams

/**
 * @brief 初始化参数
 *
 * @param context      上下文
 * @param userId       用户唯一标识
 * @param userName     用户名称
 * @param phoneNo      用户手机号（带区号）
 * @param paymentToken 支付凭证
 * @param appID        应用id（微卡提供）
 * @param timestamp    时间戳（秒）
 * @param nonce        随机字符串
 * @param signature    签名
 */
- (nonnull instancetype)initWithParams:(nonnull NSString *)userId
                               userName:(nonnull NSString *)userName
                                phoneNo:(nonnull NSString *)phoneNo
                           paymentToken:(nonnull NSString *)paymentToken
                             timestamp:(NSInteger)timestamp
                                  nonce:(nonnull NSString *)nonce
                                  appID:(nonnull NSString *)appID
                             signature:(nonnull NSString *)signature
                                  side:(AirPalmSideEnum )side{
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
    params.side = side;
    //打印传递的参数
    [self printParams:params];
    return params;
}

- (void) printParams: (RequestAuthParams *) params {
    NSString *result = [NSString stringWithFormat:@"%@ %@ %@ %@ %d %@ %@ %@",
                        params.userId, params.userName,
                        params.phoneNo,params.paymentToken,
                        params.timestamp,params.nonce,
                        params.appID,params.signature,params.side];
    NSLog(@"Palm , printParams result  %@" , result);
}

@end
