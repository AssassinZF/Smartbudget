//
//  ChartViewController.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/11.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "RootViewController.h"

@class BudgetModel,OrderModel;
@interface ChartViewController : RootViewController
@property (nonatomic, strong)BudgetModel *budgetModel;//budget
@property (nonatomic, strong)NSArray <OrderModel *>*orderList;//order list
@end
