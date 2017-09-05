//
//  ExpenseViewController.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/5.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "RootViewController.h"
@class BudgetModel;
@interface ExpenseViewController : RootViewController
@property (nonatomic, strong)BudgetModel *budgetItem;
@end
