//
//  ChartTableViewCell.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/11.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BudgetModel;
@interface ChartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *labelTypeIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

-(void)updateCell:(NSMutableArray *)array with:(BudgetModel *)budgetModel index:(NSInteger)index;
@end
