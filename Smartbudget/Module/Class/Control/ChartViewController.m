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

@interface ChartViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ChartView *chartView;
}
@property (weak, nonatomic) IBOutlet UILabel *allOutplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *allOutplayMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *topChartBackView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickDimiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell updateCell:self.dataArray[indexPath.row] with:self.budgetModel index:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

@end
