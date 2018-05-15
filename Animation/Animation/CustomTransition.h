//
//  CustomTransition.h
//  Animation
//
//  Created by 岑志军 on 2018/4/24.
//  Copyright © 2018年 cen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTransition : NSObject <UIViewControllerAnimatedTransitioning>


- (instancetype)initWithTransitionType:(UINavigationControllerOperation)type;
+ (instancetype)transitionWithType:(UINavigationControllerOperation)type;

@end
