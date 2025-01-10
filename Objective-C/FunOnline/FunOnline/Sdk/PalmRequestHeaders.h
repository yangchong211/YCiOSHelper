//
//  Created by 杨充 on 2024/12/24.
//



#ifndef PalmRequestHeaders_h
#define PalmRequestHeaders_h


#pragma mark - ***************************** 空中录掌 *****************************

#define kFirsterUrl(url)  [NSString stringWithFormat:@"%@%@", globalHost, url]

static  NSString *globalHost = @"https://www.wanandroid.com";

/** 鉴权接口，POST */
#define url_auth    kFirsterUrl(@"/cgi/sdk/auth")

/** 获取状态接口， POST */
#define url_get_palm_status    kFirsterUrl(@"/cgi/sdk/get_palm_status")

#endif /* RequestHeaders_h */

