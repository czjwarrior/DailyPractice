//
//  DetailVC.m
//  Animation
//
//  Created by 岑志军 on 2018/4/24.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "DetailVC.h"
#import "CustomTransition.h"

@interface DetailVC ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic,strong)    UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.navigationController != nil && self != self.navigationController.viewControllers.firstObject) {
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        [self.view addGestureRecognizer:popRecognizer];
        popRecognizer.delegate = self;
    }
    
    [self.view setBackgroundColor:[UIColor redColor]];
}

#pragma mark - UIPanGestureRecognizer handlers

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        if (progress > 0.25) {
            [self.percentDrivenTransition finishInteractiveTransition];
        } else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        
        self.percentDrivenTransition = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    return [recognizer velocityInView:self.view].x > 0;
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(CustomTransition *) animationController  {
    
    return self.percentDrivenTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (self.percentDrivenTransition) {
        
        return [[CustomTransition alloc] initWithTransitionType:operation];
        
    } else {
        return [CustomTransition transitionWithType:operation];
    }
    
    
}

@end
