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
    background.backgroundColor = [UIColor colorWithHexString:@"F2F0E3"];
    self.selectedBackgroundView = background;
}

-(void)setDicData:(NSDictionary *)dicData{
    _dicData = dicData;
    UIImage *image = self.isSelected?[UIImage imageNamed:dicData[@"iconHighlight"]]:[UIImage imageNamed:dicData[@"icon"]];
    self.iconImageView.image = image;
    self.labelName.text = dicData[@"name"];

}


-(void)changeSlected:(BOOL)isSelect{
    UIImage *image = isSelect?[UIImage imageNamed:_dicData[@"iconHighlight"]]:[UIImage imageNamed:_dicData[@"icon"]];
    self.iconImageView.image = image;
}

@end
