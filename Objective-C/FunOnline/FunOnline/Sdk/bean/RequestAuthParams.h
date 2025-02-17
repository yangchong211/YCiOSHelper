//
//  RequestAuthParams.h
//  FunOnline
//
//  Created by 杨充 on 2025/1/8.
//  Copyright © 2025 iOS. All rights reserved.
//

#ifndef RequestAuthParams_h
#define RequestAuthParams_h

#import <Foundation/Foundation.h>

//参数实体类
@interface RequestAuthParams : NSObject


//这些参数都是需要用户传递进来
@property (nonatomic, strong, nonnull) NSString *userId;
@property (nonatomic, strong, nonnull) NSString *userName;
@property (nonatomic, strong, nonnull) NSString *phoneNo;
@property (nonatomic, strong, nonnull) NSString *paymentToken;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, strong, nonnull) NSString *nonce;
@property (nonatomic, strong, nonnull) NSString *appID;
@property (nonatomic, strong, nonnull) NSString *signature;



//初始化参数
- (nonnull instancetype)initWithParams:(nonnull NSString *)userId
                               userName:(nonnull NSString *)userName
                                phoneNo:(nonnull NSString *)phoneNo
                           paymentToken:(nonnull NSString *)paymentToken
                             timestamp:(NSInteger)timestamp
                                  nonce:(nonnull NSString *)nonce
                                  appID:(nonnull NSString *)appID
                              signature:(nonnull NSString *)signature;

- (void) printParams: (RequestAuthParams *) params;

@end


#endif /* RequestAuthParams_h */
