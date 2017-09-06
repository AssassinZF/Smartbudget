//
//  ExpenseViewController.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/5.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "ExpenseViewController.h"
#import "BudgetModel.h"
#import "AppSettingDefault.h"
#import "OrderTableViewCell.h"
#import "PullDwonView.h"

static NSString * const cellID = @"CELLID";
static CGFloat cellHeight = 50;


@interface ExpenseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    PullDwonView *headerView;
}
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *outPlayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation ExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.budgetItem.budgetName;
    self.view.backgroundColor = [AppSettingDefault share].themeColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = cellHeight;
    [self loadAllOrder];
    
    UIView *pullView = [[UIView alloc] init];
    pullView.backgroundColor = [UIColor purpleColor];
    pullView.bounds = CGRectMake(0, 0, 100, 100);
    pullView.center = CGPointMake(self.tableView.centerX, 100);
    [self.tableView addSubview:pullView];
    
    self.allMoneyLabel.text = [NSString stringWithFormat:@"%.2f",self.budgetItem.budgetMoney];
    self.outPlayMoneyLabel.text = [NSString stringWithFormat:@"-%.2f",self.budgetItem.outlayMoney];
    self.surplusLabel.text = [NSString stringWithFormat:@"%.2f",self.budgetItem.budgetMoney-self.budgetItem.outlayMoney];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!headerView) {
        CGRect tableF = self.tableView.frame;
        CGRect headerViewF = CGRectMake(0,- ViewHeight, tableF.size.width, ViewHeight);
        headerView = [[PullDwonView alloc] initWithFrame:headerViewF];
        [self.tableView addSubview:headerView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete cell
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    view.frame = CGRectMake(0, 0, self.tableView.width, 20);
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        headerView.scrollOffy = ABS(scrollView.contentOffset.y);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"将要结束拖拽");
}

-(void)loadAllOrder{
    NSArray *orders = [OrderModel findWithFormat:[NSString stringWithFormat:@"WHERE orderName=%@",self.budgetItem.budgetName]];
    self.dataArray = orders.mutableCopy;
    [self.tableView reloadData];
}

@end
