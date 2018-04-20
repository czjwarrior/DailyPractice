//
//  DrawView.m
//  Quartz2D实战-画板工具
//
//  Created by 岑志军 on 2018/4/20.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "DrawView.h"
#import "ZJBezierPath.h"

@interface DrawView()

@property (nonatomic, assign) CGFloat           lineWidth;      // 线宽
@property (nonatomic, strong) UIColor           *lineColor;     // 线颜色

@property (nonatomic, strong) ZJBezierPath      *path;          // 当前路径
@property (nonatomic, strong) NSMutableArray    *pathArray;     // 存储路径的数组

@property (nonatomic, strong) UIView            *pointView;     // 画笔笔尖

@end

@implementation DrawView

- (NSMutableArray *)pathArray{
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self addSubview:self.pointView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];

    // 初始化线的颜色和线宽
    [self setLineColor:[UIColor blackColor]];
    [self setLineWidth:1.f];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.pathArray addObject:image];
    
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark - Getter

- (UIView *)pointView{
    if (_pointView == nil) {
        _pointView = [[UIView alloc] init];
        [_pointView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pointView;
}

#pragma mark - Selector

- (void)pan:(UIPanGestureRecognizer *)pan{
    // 获取当前位置所在点
    CGPoint curP = [pan locationInView:self];
    
    // 笔尖代码
    {
        //获取偏移量
        //获取的偏移量是相对于最原始的点
        CGPoint transP = [pan translationInView:self.pointView];
        
        [self.pointView setAlpha:1.f];
        
        CGFloat pointW = self.lineWidth + 5;
        CGPoint pointP = CGPointMake(curP.x - pointW / 2, curP.y - pointW / 2);
        
        [self.pointView setFrame:(CGRect){pointP, self.lineWidth + 5, self.lineWidth + 5}];
        [self.pointView.layer setCornerRadius:self.pointView.bounds.size.width / 2];
        [self.pointView.layer setBorderWidth:1.f];
        [self.pointView.layer setBorderColor:self.lineColor.CGColor];
        
        self.pointView.transform = CGAffineTransformTranslate(self.pointView.transform, transP.x, transP.y);
        
        //清0操作(不让偏移量进行累加,获取的是相对于上一次的值,每一次走的值.)
        [pan setTranslation:CGPointMake(0, 0) inView:self.pointView];
    }
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        ZJBezierPath *path = [ZJBezierPath bezierPath];
        path.lineWidth = self.lineWidth;
        path.lineJoinStyle = kCGLineJoinMiter;
        path.lineCapStyle = kCGLineCapRound;
        path.lineColor = self.lineColor;    // //颜色必须得要在drawRect方法当中进行绘制    继承系统类,添加属性我们自己的东西.
        self.path = path;
        
        //设置路径的起点
        [self.path moveToPoint:curP];
        
        [self.pathArray addObject:path];
        
    } else if (pan.state == UIGestureRecognizerStateChanged){
        
        //添加一根线到当前手指所在的点
        [self.path addLineToPoint:curP];
        
        [self setNeedsDisplay];
        
    } else if (pan.state == UIGestureRecognizerStateEnded){
        [self.pointView setAlpha:0.f];
    }
}

#pragma mark - Public

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
}

// 清屏
- (void)clear{
    [self.pathArray removeAllObjects];
    
    // 重绘
    [self setNeedsDisplay];
}

// 撤消
- (void)undo{
    
    if (self.pathArray.count == 0) {return;}
    
    [self.pathArray removeLastObject];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)eraser{
    [self setLineColor:[UIColor whiteColor]];
}

#pragma mark - Super

- (void)drawRect:(CGRect)rect {
    
    for (ZJBezierPath *path in self.pathArray) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            // 绘制图片
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        } else {
            // 绘制路径
            [path.lineColor set];
            [path stroke];
        }
    }
    
}

@end
