//
//  ViewController.m
//  Label斜体
//
//  Created by 岑志军 on 2018/5/15.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@property (nonatomic, copy) NSString  *testStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.testStr = @"先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。然侍卫之臣不懈于内，忠志之士忘身于外者，盖追先帝之殊遇，欲报之于陛下也。诚宜开张圣听，以光先帝遗德，恢弘志士之气，不宜妄自菲薄，引喻失义，以塞忠谏之路也。";
    
//    [self italicLabel01];
    [self italicLabel02];
}

- (void)italicLabel01{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.testStr];
    
    [attStr addAttribute:NSObliquenessAttributeName
                   value:@(0.5)
                   range:NSMakeRange(0, self.testStr.length)];
    
    [self.testLabel setAttributedText:attStr];
}

- (void)italicLabel02{
    NSInteger number = 30;//倾斜值
    CGAffineTransform matrix =  CGAffineTransformMake(1, 0, tanf(number * (CGFloat)M_PI / 180), 1, 0, 0);
    UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:[UIFont systemFontOfSize:16].fontName matrix:matrix];
    UIFont *font = [UIFont fontWithDescriptor:desc size:16];
    self.testLabel.font = font;
    
    [self.testLabel setText:self.testStr];
}

@end
