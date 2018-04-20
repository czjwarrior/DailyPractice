//
//  DrawView.h
//  Quartz2D实战-画板工具
//
//  Created by 岑志军 on 2018/4/20.
//  Copyright © 2018年 cen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

// 要绘制的图片
@property (nonatomic, strong) UIImage  *image;

// 设置线宽
- (void)setLineWidth:(CGFloat)lineWidth;

// 设置线的颜色
- (void)setLineColor:(UIColor *)lineColor;

// 清屏
- (void)clear;

// 撤消
- (void)undo;

// 橡皮檫
- (void)eraser;

@end
