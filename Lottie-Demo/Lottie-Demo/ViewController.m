//
//  ViewController.m
//  Lottie-Demo
//
//  Created by 岑志军 on 2018/4/27.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"
//#import <Lottie/Lottie.h>
#import "LOTAnimationView.h"

@interface ViewController ()

@property (nonatomic, strong) LOTAnimationView *logoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.logoView = [LOTAnimationView animationNamed:@"LottieLogo1"];
    self.logoView.contentMode = UIViewContentModeScaleAspectFill;
    self.logoView.loopAnimation = YES;
    [self.view addSubview:self.logoView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.logoView play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.logoView pause];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect lottieRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.3);
    self.logoView.frame = lottieRect;
    
}

- (LOTAnimationView *)logoView{
    if (_logoView == nil) {
        _logoView = [LOTAnimationView new];
    }
    return _logoView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
