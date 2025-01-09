//
//  Created by 杨充 on 2024/12/24.
//



#ifndef PalmRequestHeaders_h
#define PalmRequestHeaders_h

#pragma mark - ***************************** 测试 *****************************
/// 服务端口1
static  NSString *kGlobalHost1 = @"https://www.wanandroid.com";
#define kFirsterUrl(url)  [NSString stringWithFormat:@"%@%@", kGlobalHost1, url]

/** 玩android get请求 */
#define url_article    kFirsterUrl(@"/article/list/0/json")

/** 玩android post请求 */
#define url_login    kFirsterUrl(@"/user/login")

#pragma mark - ***************************** 空中录掌 *****************************

static  NSString *kGlobalHost2 = @"https://www.wanandroid.com";

/** 鉴权接口，POST */
#define url_auth    kFirsterUrl(@"/cgi/sdk/auth")

/** 获取状态接口， POST */
#define url_get_palm_status    kFirsterUrl(@"/cgi/sdk/get_palm_status")

#endif /* RequestHeaders_h */

