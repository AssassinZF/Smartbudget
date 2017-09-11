//
//  ChartTableViewCell.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/11.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "ChartTableViewCell.h"
#import "BudgetModel.h"
#import "UIColor+AppConfigure.h"
@interface ChartTableViewCell()

@end

@implementation ChartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.scaleLabel.layer.cornerRadius = 5;
    self.scaleLabel.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell:(NSMutableArray *)array with:(BudgetModel *)budgetModel index:(NSInteger)index{
    OrderModel *order = array.firstObject;
    CGFloat sumMoney = 0.0;
    for (OrderModel *item in array) {
        sumMoney += item.orderNumber;
    }
    NSArray *labelArray = LabelAssetList;
    NSDictionary *dic = labelArray[order.orderType];
    self.scaleLabel.backgroundColor = [UIColor colorWithHexString:dic[@"color"]];
    if (budgetModel.outlayMoney>0.0) {
        self.scaleLabel.text = [NSString stringWithFormat:@"%.0f%%",(sumMoney/budgetModel.outlayMoney)*100.0];
    }
    self.labelTypeIcon.image = [UIImage imageNamed:dic[@"icon"]];
    self.labelName.text = dic[@"name"];
    self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",sumMoney];
    self.moneyLabel.textColor = [UIColor moneyColor];
    self.countLabel.text =[NSString stringWithFormat:@"%lu",(unsigned long)array.count];
    self.indexLabel.text = [NSString stringWithFormat:@"%ld",index+1];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
