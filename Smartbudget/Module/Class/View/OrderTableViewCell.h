//
//  OrderTableViewCell.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/5.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@interface OrderTableViewCell : UITableViewCell
@property (nonatomic, strong)OrderModel *orderModel;
@end
