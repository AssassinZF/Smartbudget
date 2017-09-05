//
//  MainTableViewCell.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BudgetModel;

@interface MainTableViewCell : UITableViewCell
@property (nonatomic, strong)BudgetModel *budgetModel;

@end
