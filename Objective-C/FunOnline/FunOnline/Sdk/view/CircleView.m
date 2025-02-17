//
//  ViewController.m
//  AirPalmSdk
//
//  Created by 杨充 on 2025/2/7.
//

#import "CircleView.h"

@interface CircleView ()

@end

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    // 获取视图的大小
    CGSize size = self.bounds.size;
    CGFloat radius = MIN(size.width, size.height) / 2.0; // 取宽高中的较小值作为半径
    CGFloat centerX = size.width / 2.0;
    CGFloat centerY = size.height / 2.0;
    
    // 创建UIBezierPath对象，用于绘制圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY)
                                                              radius:radius
                                                          startAngle:0
                                                            endAngle:M_PI * 2
                                                           clockwise:YES];
    // 设置填充颜色（如果你想填充圆形）
    [[[UIColor colorHexString:@"333333"] colorWithAlphaComponent:0.2] setFill];
    // 填充路径
    [circlePath fill];
    // 设置描边颜色（如果你想绘制边框）
    [[[UIColor colorHexString:@"333333"] colorWithAlphaComponent:0.2] setStroke];
    // 设置线宽
    circlePath.lineWidth = 1;
    // 描边路径
    [circlePath stroke];
}

@end
