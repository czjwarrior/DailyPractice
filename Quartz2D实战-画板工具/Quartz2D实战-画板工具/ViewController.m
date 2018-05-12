//
//  ViewController.m
//  Quartz2D实战-画板工具
//
//  Created by 岑志军 on 2018/4/20.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)clear:(UIButton *)sender{
    [self.drawView clear];
}

- (IBAction)undo:(UIButton *)sender{
    [self.drawView undo];
}

- (IBAction)eraser:(UIButton *)sender{
    [self.drawView eraser];
}

- (IBAction)photo:(UIButton *)sender{
    //弹出系统相册,从中选择一张照片,把照片绘制到画板
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    
    //设置照片的来源
    pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    pickVC.delegate = self;
    
    [self presentViewController:pickVC animated:YES completion:nil];
}

- (IBAction)save:(UIButton *)sender{
    
    // 对画板截屏
    UIGraphicsBeginImageContext(self.drawView.bounds.size);
    
    //把View的layer的内容渲染到上下文当中
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    
    // 从上下文中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndPDFContext();
    
    //把生成的图片保存到系统相册
    //保存完毕时调用的方法必须得是:image:didFinishSavingWithError:contextInfo:
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)setLineColor:(UIButton *)sender{
    [self.drawView setLineColor:sender.backgroundColor];
}

- (IBAction)setLineWidth:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}

#pragma mark - Super

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"保存完毕");
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    NSData *data = UIImageJPEGRepresentation(image, 1);
//    [data writeToFile:@"/Users/cenzhijun/Desktop/photo.jpg" atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.drawView.image = image;
    
}


@end
