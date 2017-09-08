//
//  LabelCollectionViewCell.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/7.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@implementation LabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *background = [UIView new];
    background.backgroundColor = [UIColor purpleColor];
    self.selectedBackgroundView = background;
}

-(void)updateCellDictory:(NSDictionary *)dic{
    self.iconImageView.image = [UIImage imageNamed:dic[@"icon"]];
    self.labelName.text = dic[@"name"];
    
}
@end
