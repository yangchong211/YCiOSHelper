//
//  Created by 杨充 on 2024/12/24.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^Success)(id _Nullable responseObj);
typedef void(^Failure)(NSError * _Nonnull error);
typedef void(^Progress)(NSProgress * _Nonnull progress);


//@interface 是用于声明类的接口的关键字。它用于定义类的属性、方法和其他成员。
@interface PalmRequestManager : NSObject

//单利对象
+ (instancetype)manager;

//设置请求头
- (void)setHeader: (NSDictionary*) parameters;


//GET请求
- (NSURLSessionDataTask *)GET_REQUEST:(NSString * )URLString
                   parameters:(nullable id)parameters
                      success:(Success)success
                      failure:(Failure)failure;

//POST请求
- (nullable NSURLSessionDataTask *)POST_REQUEST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(Success)success
                                failure:(Failure)failure;

//GET请求
- (NSURLSessionDataTask *)GET_REQUEST:(NSString *)URLString
                   parameters:(nullable id)parameters
                     progress:(nullable Progress)downloadProgress
                      success:(Success)success
                      failure:(Failure)failure;
//POST请求
- (nullable NSURLSessionDataTask *)POST_REQUEST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable Progress)uploadProgress
                                success:(Success)success
                                failure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
