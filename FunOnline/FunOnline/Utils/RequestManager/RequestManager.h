//
//  HttpRequestManager.h
//
//  ObjCApp
//
//  Created by 杨充 on 2024/12/23.
//



#import <Foundation/Foundation.h>

//AFNetWorking：iOS/macOS JSON网络请求实战指南：https://blog.csdn.net/weixin_32925455/article/details/141683739
NS_ASSUME_NONNULL_BEGIN

typedef void(^Success)(id _Nullable responseObj);
typedef void(^Failure)(NSError * _Nonnull error);
typedef void(^Progress)(NSProgress * _Nonnull progress);

@interface RequestManager : NSObject

+ (instancetype)manager;

//设置请求头
- (void) setHeader: (NSDictionary*) parameters;

- (NSURLSessionDataTask *)GET:(NSString * )URLString
                   parameters:(nullable id)parameters
                      success:(Success)success
                      failure:(Failure)failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(Success)success
                                failure:(Failure)failure;


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                     progress:(nullable Progress)downloadProgress
                      success:(Success)success
                      failure:(Failure)failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable Progress)uploadProgress
                                success:(Success)success
                                failure:(Failure)failure;

- (void)startGET:(NSString *)URLString
      parameters:(nullable id)parameters
        progress:(nullable Progress)progress
         success:(void(^)(_Nonnull id response))success
         failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
