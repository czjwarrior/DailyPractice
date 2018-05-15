//
//  CustomCell.h
//  Animation
//
//  Created by 岑志军 on 2018/4/24.
//  Copyright © 2018年 cen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellDelegate <NSObject>

- (void)cellBtnClick:(NSInteger)index;

@end

@interface CustomCell : UITableViewCell

@property (nonatomic, weak) id<CustomCellDelegate>delegate;
@property (nonatomic, assign) NSInteger indexRow;

@property (weak, nonatomic) IBOutlet UIButton *bgBtn;

@end
