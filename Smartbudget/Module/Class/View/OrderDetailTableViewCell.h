//
//  OrderDetailTableViewCell.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/12.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
