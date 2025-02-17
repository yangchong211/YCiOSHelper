//
//  Created by 杨充 on 2024/12/24.
//


#import "PalmRegisterError.h"

@implementation PalmRegisterError

/** 用户取消 */
int32_t const ERR_CANCEL = 10001;
/** 未知错误 */
int32_t const ERR_DEFAULT = 10002;
/** 摄像头无权限 */
int32_t const ERR_PALM_CAMERA_PERMISSION_CHECK = 10003;
/** 摄像头初始化异常 */
int32_t const ERR_PALM_CAMERA_INIT = 10004;
/** 摄像头不满足要求 */
int32_t const ERR_PALM_CAMERA_PREVIEW_SIZE_INTERRUPT = 10005;
/** 算法初始化失败 */
int32_t const ERR_PALM_SDK_INIT = 10006;
/** 算法运行异常 */
int32_t const ERR_PALM_SDK_RUNNING = 10007;
/** 网络异常 */
int32_t const ERR_PALM_SERVER_OPEN_RESULT_FAILED = 10008;
/** 录入结果异常 */
int32_t const ERR_PALM_DATA_SDK = 10009;
/** 用户已经录掌 */
int32_t const SUCCESS_USER_REGISTERED = 10010;
/** 用户预录入掌 */
int32_t const SUCCESS_USER_PRE_REGISTERED = 10011;
/** 用户未录掌 */
int32_t const SUCCESS_USER_UN_REGISTERED = 10013;
/** 初始化参数异常 */
int32_t const ERR_PALM_INIT_INPUT = 10014;
/** 初始化资源失败 */
int32_t const ERR_PALM_INIT_ASSERT = 10015;
/** 初始化sdk鉴权失败 */
int32_t const ERR_PALM_INIT_SDK_LICENSE = 10016;
/** 初始化包名鉴权失败 */
int32_t const ERR_PALM_INIT_PACKAGE = 10017;
/** 初始化签名鉴权失败 */
int32_t const ERR_PALM_INIT_SIGNATURE = 10018;
/** 初始化加密组件失败 */
int32_t const ERR_PALM_INIT_SECURE = 10018;

@end


