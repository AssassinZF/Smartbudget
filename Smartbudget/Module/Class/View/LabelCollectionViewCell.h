//
//  LabelCollectionViewCell.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/7.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
-(void)updateCellDictory:(NSDictionary *)dic;
@end
