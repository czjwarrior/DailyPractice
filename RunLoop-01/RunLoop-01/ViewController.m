//
//  ViewController.m
//  RunLoop-01
//
//  Created by 岑志军 on 2018/4/18.
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
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(countUpdate) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
//    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countUpdate) userInfo:nil repeats:YES];
    
}
- (IBAction)clear:(id)sender {
}
- (IBAction)setLineWidth:(UISlider *)sender {
}

- (void)countUpdate{
    
    NSLog(@"当前线程：%@", NSThread.currentThread);
    NSLog(@"RunLoop运行模式：%@", NSRunLoop.currentRunLoop.currentMode);
    
    self.count ++;
    NSString *timerText = [NSString stringWithFormat:@"计时器：%ld", (long)self.count];
    [self.timerLabel setText:timerText];
}

#pragma mark - Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"RunLoop运行模式：%@", NSRunLoop.currentRunLoop.currentMode);
}


@end
