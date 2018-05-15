//
//  UIViewController+SnipView.m
//  Animation
//
//  Created by 岑志军 on 2018/4/24.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "UIViewController+SnipView.h"
#import <objc/runtime.h>

@implementation UIViewController (SnipView)

- (UIView *)snapshot {
    
    UIView *view = objc_getAssociatedObject(self, @"SnipView");
    if (!view) {
        view = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    
    return view;
}

- (void)setSnapshot:(UIView *)snapshot {
    
    objc_setAssociatedObject(self, @"SnipView", snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
