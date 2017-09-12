//
//  ChartViewController.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/11.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "ChartViewController.h"
#import "ChartView.h"
#import "ChartTableViewCell.h"
#import "BudgetModel.h"
#import "UIColor+AppConfigure.h"
#import "AppSettingDefault.h"
#import "OrderDetailTableViewCell.h"

@interface ChartViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ChartView *chartView;
    NSInteger selectIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *allOutplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *allOutplayMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *topChartBackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, strong)UITableView *detailTableView;

@end

@implementation ChartViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartView = [[ChartView alloc] init];
    [self.topChartBackView addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topChartBackView).with.insets(UIEdgeInsetsMake(0, 40, 0, 40));
    }];
    chartView.dataArray = nil;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChartTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 60;
    
    
    [self.view bringSubviewToFront:self.closeButton];
    
    self.allOutplayMoneyLabel.text = [NSString stringWithFormat:@"-%.2f",self.budgetModel.outlayMoney];
    self.allOutplayMoneyLabel.textColor = [UIColor moneyColor];
    
    selectIndex = -1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickDimiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _detailTableView && selectIndex>-1) {
        NSMutableArray *itemArray = self.dataArray[selectIndex];
        return itemArray.count;
    }
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _detailTableView && selectIndex>-1) {
        OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        NSMutableArray *itemArray = self.dataArray[selectIndex];
        OrderModel *item = itemArray[indexPath.row];
        cell.timeLabel.text = item.creatTime;
        cell.timeLabel.textColor = [UIColor _grayColor];
        ChartTableViewCell *preCell = (ChartTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
        cell.typeNameLabel.text = preCell.labelName.text;
        cell.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",item.orderNumber];
        cell.moneyLabel.textColor = [UIColor moneyColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    ChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell updateCell:self.dataArray[indexPath.row] with:self.budgetModel index:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _detailTableView) {
        return;
    }
    selectIndex = indexPath.row;
    if (!_detailTableView) {
        [self.detailTableView layoutIfNeeded];
        [UIView animateWithDuration:0.5 animations:^{
            [self.detailTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(110);
            }];
            [self.detailTableView layoutIfNeeded];
        } completion:^(BOOL finished) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [UIColor _grayColor];
            [self.view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.detailTableView);
                make.top.bottom.equalTo(self.detailTableView);
                make.width.mas_equalTo(1);
            }];
        }];
    }
    [self.detailTableView reloadData];

    
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
        if (self.orderList.count) {
            NSMutableDictionary *dic = @{}.mutableCopy;
            for (OrderModel *order in self.orderList) {
                NSString *typeStr = [NSString stringWithFormat:@"%ld",(long)order.orderType];
                NSMutableArray *array = dic[typeStr];
                if (array.count) {
                    [array addObject:order];
                }else{
                    array = @[].mutableCopy;
                    [array addObject:order];
                    [dic setValue:array forKey:typeStr];
                }
            }
            for (NSMutableArray *array in dic.allValues) {
                if (array.count) {
                    [_dataArray addObject:array];
                }
            }
        }
    }
    return _dataArray;
}

-(UITableView *)detailTableView{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.backgroundColor = [AppSettingDefault share].backgroundColor;
        _detailTableView.rowHeight = 60;
        [_detailTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"detailCell"];
        _detailTableView.tableFooterView = [UIView new];
        [self.view addSubview:self.detailTableView];
        [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView);
            make.bottom.equalTo(self.tableView);
            make.right.equalTo(self.view);
            make.left.equalTo(self.view.mas_left).offset(kScreenWidth);
        }];

    }
    return _detailTableView;
}

@end
