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
#import "SpendView.h"
#import "SawtoothView.h"
#import "UIColor+AppConfigure.h"

static NSString * const cellID = @"CELLID";
static CGFloat cellHeight = 60;


@interface ExpenseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    PullDwonView *headerView;
    SpendView *spendView;
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
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadAllOrder];
    
    self.allMoneyLabel.text = [NSString stringWithFormat:@"%.2f",self.budgetItem.budgetMoney];
    self.outPlayMoneyLabel.text = [NSString stringWithFormat:@"-%.2f",self.budgetItem.outlayMoney];
    self.surplusLabel.text = [NSString stringWithFormat:@"%.2f",self.budgetItem.budgetMoney-self.budgetItem.outlayMoney];
    self.surplusLabel.textColor = [UIColor moneyColor];
    
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
    OrderModel *model = self.dataArray[indexPath.row];
    cell.orderModel = model;
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
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SawtoothView *view = [[SawtoothView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 20)];
    return view;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [AppSettingDefault share].backgroundColor;
    view.frame = CGRectMake(0, 0, self.tableView.width, 1);
    return view;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        headerView.scrollOffy = ABS(scrollView.contentOffset.y);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView.contentOffset.y < -100) {
        spendView = [SpendView showWithSuperView:self.view];
        __weak typeof(self)weakSelf = self;
        spendView.orderAddBlock = ^(id orderItem) {
            if (orderItem) {
                OrderModel *item = (OrderModel *)orderItem;
                item.orderName = weakSelf.budgetItem.budgetName;
                [item save];
                [weakSelf updateTotalMoney:item];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.dataArray insertObject:item atIndex:0];
                    [weakSelf.tableView beginUpdates];
                    [weakSelf.tableView insertRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] withRowAnimation:UITableViewRowAnimationTop];
                    [weakSelf.tableView endUpdates];

                });
            }
        };

    }
    
}

-(void)updateTotalMoney:(OrderModel *)order{
    self.budgetItem.modifyTime = order.creatTime;
    self.budgetItem.outlayMoney += order.orderNumber;
    self.surplusLabel.text = [NSString stringWithFormat:@"%.00f",self.budgetItem.budgetMoney - self.budgetItem.outlayMoney];
}

-(void)loadAllOrder{
    NSArray *orders = [OrderModel findByCriteria:[NSString stringWithFormat:@"WHERE orderName=\"%@\"",self.budgetItem.budgetName]];
    self.dataArray = orders.mutableCopy;
    [self.tableView reloadData];
}

@end
