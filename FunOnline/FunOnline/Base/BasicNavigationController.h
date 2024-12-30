//
//  BasicNavigationController.h
//  BotherSellerOC
//
//  Created by 杨充 on 2017/4/6.
//

#import <UIKit/UIKit.h>

@interface BasicNavigationController : UINavigationController

/**
 全屏滑动返回手势
 */
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end
