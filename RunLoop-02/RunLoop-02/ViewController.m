//
//  ViewController.m
//  RunLoop-02
//
//  Created by 岑志军 on 2018/4/19.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(timerTest) object:nil];
    [thread start];
}

- (void)timerTest{
    
    @autoreleasepool{
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(updateCount) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [timer fire];
        
        [runLoop run];
    }
}

- (void)updateCount{
    
    NSLog(@"当前线程：%@",[NSThread currentThread]);
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
    
    // 必须在主线程设置label
    dispatch_async(dispatch_get_main_queue(), ^{
       
        self.count++;
        NSString *timerText = [NSString stringWithFormat:@"计时器：%ld", (long)self.count];
        [self.timerLabel setText:timerText];
        
    });
}

#pragma mark - Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"RunLoop运行模式：%@", NSRunLoop.currentRunLoop.currentMode);
}



@end
