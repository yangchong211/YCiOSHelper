//
//  HttpRequestManager.m
//
//  Created by 杨充 on 2024/12/23.
//

#import "PalmRequestManager.h"
#import "AFNetworking.h"

#define WeakSelf    __weak typeof(self) weakSelf = self

@interface PalmRequestManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@property (strong, nonatomic) NSURLSession * session;

@end


//网络请求的实现
@implementation PalmRequestManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
        //获取网络请求manager类
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置请求超时
        _sessionManager.requestSerializer.timeoutInterval = 6;
        //向AFN添加一些隐私权策略
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy = securityPolicy;
        //接收参数类型
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    }
    return self;
}


/**
 *  单例
 */
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static PalmRequestManager *httpRequest = nil;
    dispatch_once(&onceToken, ^{
        httpRequest = [[PalmRequestManager alloc] init];
    });
    return httpRequest;
}


//设置请求头
- (void) setHeader: (NSDictionary *) parameters {
    //请求头（Headers）的设置是自定义请求非常重要的一步。
    //请求头通常用于指定内容类型（Content-Type）、授权信息（Authorization）、语言（Accept-Language）等。
    //在 AFNetWorking 中设置请求头可以通过 .setRequestHeader 方法实现。
    
    //sessionManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type");
    //sessionManager.requestSerializer.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization");
}


-(NSURLSessionDataTask *)GET_REQUEST:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure{
    return [self GET_REQUEST:URLString parameters:parameters progress:nil success:success failure:failure];
}

-(NSURLSessionDataTask *)POST_REQUEST:(NSString *)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure{
    return [self POST_REQUEST:URLString parameters:parameters progress:nil success:success failure:failure];
}


-(NSURLSessionDataTask *)GET_REQUEST:(NSString *)URLString parameters:(id)parameters progress:(Progress)downloadProgress success:(Success)success failure:(Failure)failure{
    //第一个参数是存放我们的URL，也就是网络请求的地址。
    //第二个参数则是我们要发送的请求的查询数据，在get请求中我们一般放在URL中间，这里注意下在POST请求，我们需要使用一个字典来进行一个请求。
    //第三个参数则是header，在大部分请求中我们是不需要的，但是在部分要求比较严格的API中，可能就需要运用到这个参数
    //第四个参数是一个可以选择的块，一般用于大文件的下载中
    //success则是请求成功后回调块，failure则是请求失败后的回调块
    WeakSelf;
//    return [self.sessionManager GET:URLString parameters:parameters headers:nil progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [weakSelf requestTask:task responseObj:responseObject success:success];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//    }];
    return [self.sessionManager GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf requestTask:task responseObj:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(NSURLSessionDataTask *)POST_REQUEST:(NSString *)URLString parameters:(id)parameters progress:(Progress)uploadProgress success:(Success)success failure:(Failure)failure{
    //第一个参数是存放我们的URL，也就是网络请求的地址。
    //第二个参数则是我们要发送的请求的查询数据，在get请求中我们一般放在URL中间，这里注意下在POST请求，我们需要使用一个字典来进行一个请求。
    //第三个参数则是header，在大部分请求中我们是不需要的，但是在部分要求比较严格的API中，可能就需要运用到这个参数
    //第四个参数是一个可以选择的块，一般用于大文件的下载中
    //success则是请求成功后回调块，failure则是请求失败后的回调块
    WeakSelf;
    //设置请求体的 Content-Type 为 application/json
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    return [self.sessionManager POST:URLString parameters:parameters headers:nil progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [weakSelf requestTask:task responseObj:responseObject success:success];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//    }];
    //将请求体的 Content-Type 设置为 "application/json"，以确保请求体以 RAW 格式发送。
    return [_sessionManager POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf requestTask:task responseObj:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


- (void)requestTask:(NSURLSessionDataTask * _Nullable)task responseObj:(id  _Nullable)responseObject success:(Success)success {
    if ([responseObject isKindOfClass:[NSData class]]) {
        id jsonObject = [self JSONObjectWithData:responseObject];
        if ([jsonObject isKindOfClass:[NSNull class]]) {
            success(nil);
            return;
        }
        //不是字典直接返回
        if (![jsonObject isKindOfClass:[NSDictionary class]]) {
            success(jsonObject);
            return;
        }
        success(jsonObject);
    }
    else {
        success(responseObject); //返回请求数据
    }
}


- (id)JSONObjectWithData:(NSData *)data {
    id responseObj = nil;
    NSError *error = nil;
    responseObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        // NSInteger statusCode = [[responseObj valueForKey:@"code"] integerValue];
    }else {
        return error;
    }
    return responseObj;
}

@end
