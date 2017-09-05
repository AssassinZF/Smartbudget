//
//  MainTableViewCell.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "MainTableViewCell.h"
#import "BudgetModel.h"
#import "UIColor+AppConfigure.h"

@interface MainTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *budgetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *surplusMoneyLabel;

@end

@implementation MainTableViewCell

-(void)setBudgetModel:(BudgetModel *)budgetModel{
    _budgetModel = budgetModel;
    self.budgetNameLabel.text = budgetModel.budgetName;
    NSString *money = [NSString stringWithFormat:@"%.2f",budgetModel.budgetMoney - budgetModel.outlayMoney];
    self.surplusMoneyLabel.text = money;
    self.creatTimeLabel.text = [[NSDate date] stringWithFormat:@"YYYY/MM/dd"];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",budgetModel.budgetMoney];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.surplusMoneyLabel.backgroundColor = [UIColor moneyColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.surplusMoneyLabel.clipsToBounds = YES;
    self.surplusMoneyLabel.layer.cornerRadius = self.surplusMoneyLabel.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
