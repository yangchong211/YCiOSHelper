//
//  Created by 杨充 on 2024/12/24.
//



#ifndef PalmRequestHeaders_h
#define PalmRequestHeaders_h


#pragma mark - ***************************** 空中录掌 *****************************

#define kFirsterUrl(url)  [NSString stringWithFormat:@"%@%@", globalHost, url]

static  NSString *globalHost = @"https://app.gz-ty.palm.tencent.com";

/** 鉴权接口，POST */
#define url_auth    kFirsterUrl(@"/wepalm/sdk/auth")

/** 获取状态接口， POST */
#define url_get_palm_status    kFirsterUrl(@"/wepalm/sdk/get-palm-status")

/** 获取优图授权信息， POST */
#define get_license    kFirsterUrl(@"/wepalm/sdk/get-license")

/**
 * "Unregistered" // 未录掌
 * "PreRegistered" // 预录入
 * "Registered" // 已录掌
 */
static const NSString *Unregistered = @"Unregistered";
static const NSString *PreRegistered = @"PreRegistered";
static const NSString *Registered = @"Registered";

//key
//鉴权license的存储key
static const NSString *SP_KEY_LICENSE = @"key_license";
//鉴权license的存储key
static const NSString *SP_KEY_LICENSE_STATUS = @"key_license_init_status";

#endif /* RequestHeaders_h */

