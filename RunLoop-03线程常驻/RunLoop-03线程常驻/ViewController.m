//
//  ViewController.m
//  RunLoop-03线程常驻
//
//  Created by 岑志军 on 2018/4/19.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"
#import "ZJThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    ZJThread *thread = [[ZJThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
//    [thread setName:@"hahahaha"];
//    [thread start];
    
    ZJThread *thread = [[ZJThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
    
    [thread start];
}

- (void)threadTest{
    @autoreleasepool{
        NSLog(@"开启runLoop之前%@", [NSRunLoop currentRunLoop]);
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        
        NSLog(@"开启runLoop之后%@", [NSRunLoop currentRunLoop]);
        [runLoop run];
        
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
