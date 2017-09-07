//
//  OrderTableViewCell.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/5.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "BudgetModel.h"

@interface OrderTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeName;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    self.orderTypeName.text = @"一般";
    self.creatTimeLabel.text = orderModel.creatTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.1f",orderModel.orderNumber];
}

@end
