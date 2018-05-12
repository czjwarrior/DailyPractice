//
//  ViewController.m
//  NSInvocation
//
//  Created by 岑志军 on 2018/4/23.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(haha:)];
    
    NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:signature];
    
    invoc.target = self;
    invoc.selector = @selector(haha:);
    
    NSString *str = @"haha";
    [invoc setArgument:&str atIndex:2];
    
    [invoc invoke];
    
//    if (invoc.argumentsRetained) {
//        int arg;
//        [invoc getArgument:&arg atIndex:1];
//        NSLog(@"Argument ---- %d",arg);
//    }
    
    [self.view setNeedsDisplay];
    
    [self.view setNeedsLayout];
}

- (void)test1{
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(haha)];
    
    NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:signature];
    
    invoc.target = self;
    invoc.selector = @selector(haha);
    
    [invoc invoke];
}

- (void)haha{
    NSLog(@"hahaha");
}

- (void)haha:(NSString *)str{
    NSLog(@"haha----%@", str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
