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
@property (weak, nonatomic) IBOutlet UILabel *outPlayMoneyLabel;

@end

@implementation MainTableViewCell

-(void)setBudgetModel:(BudgetModel *)budgetModel{
    _budgetModel = budgetModel;
    self.budgetNameLabel.text = budgetModel.budgetName;
    NSString *money = [NSString stringWithFormat:@"%.2f",budgetModel.budgetMoney - budgetModel.outlayMoney];
    self.surplusMoneyLabel.text = money;
    self.creatTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@",budgetModel.creatTime,budgetModel.modifyTime];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",budgetModel.budgetMoney];
    if (budgetModel.outlayMoney > 0.00) {
        self.outPlayMoneyLabel.text = [NSString stringWithFormat:@"-%.2f",budgetModel.outlayMoney];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.surplusMoneyLabel.backgroundColor = [UIColor moneyColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.outPlayMoneyLabel.textColor = [UIColor moneyColor];
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
