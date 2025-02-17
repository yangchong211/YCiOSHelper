//
//  Created by 杨充 on 2024/12/24.
//


#import <Foundation/Foundation.h>

//常量类中的常量应该使用extern关键字进行声明，并在实现文件中进行定义。
//这样可以确保常量在使用时只有一个实例，并且可以在多个文件中共享使用。
@interface PalmRegisterError : NSObject

//extern int32_t const是一种用于声明常量的语法。这样的声明表示一个外部的、不可修改的32位整数常量。

/** 用户取消 */
extern int32_t const ERR_CANCEL;
/** 未知错误 */
extern int32_t const ERR_DEFAULT;
/** 摄像头无权限 */
extern int32_t const ERR_PALM_CAMERA_PERMISSION_CHECK;
/** 摄像头初始化异常 */
extern int32_t const ERR_PALM_CAMERA_INIT;
/** 摄像头不满足要求 */
extern int32_t const ERR_PALM_CAMERA_PREVIEW_SIZE_INTERRUPT;
/** 算法初始化失败 */
extern int32_t const ERR_PALM_SDK_INIT;
/** 算法运行异常 */
extern int32_t const ERR_PALM_SDK_RUNNING;
/** 网络异常 */
extern int32_t const ERR_PALM_SERVER_OPEN_RESULT_FAILED;
/** 录入结果异常 */
extern int32_t const ERR_PALM_DATA_SDK;
/** 用户已经录掌 */
extern int32_t const SUCCESS_USER_REGISTERED;
/** 用户预录入掌 */
extern int32_t const SUCCESS_USER_PRE_REGISTERED;
/** 用户预录入掌 */
extern int32_t const SUCCESS_USER_UN_REGISTERED;
/** 用户预录入掌 */
extern int32_t const SUCCESS_USER_PRE_REGISTERED;
/** 用户未录掌 */
extern int32_t const SUCCESS_USER_PRE_REGISTERED;
/** 初始化参数异常 */
extern int32_t const ERR_PALM_INIT_INPUT;
/** 初始化资源失败 */
extern int32_t const ERR_PALM_INIT_ASSERT;
/** 初始化sdk鉴权失败 */
extern int32_t const ERR_PALM_INIT_SDK_LICENSE;
/** 初始化包名鉴权失败 */
extern int32_t const ERR_PALM_INIT_PACKAGE;
/** 初始化签名鉴权失败 */
extern int32_t const ERR_PALM_INIT_SIGNATURE;
/** 初始化加密组件失败 */
extern int32_t const ERR_PALM_INIT_SECURE;

@end

