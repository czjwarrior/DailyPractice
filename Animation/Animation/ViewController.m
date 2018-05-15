//
//  ViewController.m
//  Animation
//
//  Created by 岑志军 on 2018/4/23.
//  Copyright © 2018年 cen. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "DetailVC.h"

#import "UIImageView+WebCache.h"

static NSString *cellID = @"cellID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:cellID];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSString *urlStr = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1524643708&di=5120d4617a9bee72ad3e2851bea94459&src=http://img1.3lian.com/2015/a1/81/d/175.jpg";
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    cell.delegate = self;
//    cell.indexRow = indexPath.row;
//
//    return cell;
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 300;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

#pragma mark - Delegate

- (void)cellBtnClick:(NSInteger)index{
    
    self.currentIndex = index;
    
//    [UIView animateWithDuration:1.f animations:^{
        DetailVC *vc = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
        
        self.navigationController.delegate = vc;
        
        [self.navigationController pushViewController:vc animated:YES];

//    }];
}

@end
