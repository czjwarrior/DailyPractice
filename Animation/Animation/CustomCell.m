//
//  CustomCell.m
//  Animation
//
//  Created by 岑志军 on 2018/4/24.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "CustomCell.h"

#define defaultScale 0.9
#define animateDelay 0.15   //默认动画执行时间

@interface CustomCell()

@property (nonatomic, assign) CGFloat btnScale;

@end

@implementation CustomCell


- (IBAction)pressedEvent:(id)sender {
    
    CGFloat scale = (_btnScale && _btnScale <= 1.0) ? _btnScale : defaultScale;
    [UIView animateWithDuration:animateDelay animations:^{
        self.bgBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}
- (IBAction)unPressedEvent:(UIButton *)sender {
    
    [UIView animateWithDuration:animateDelay animations:^{
        self.bgBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
       
        if ([self.delegate respondsToSelector:@selector(cellBtnClick:)]) {
            [self.delegate cellBtnClick:self.indexRow];
        }
    }];
}

@end
