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

static NSString * const cellID = @"CELLID";
static CGFloat cellHeight = 50;


@interface ExpenseViewController ()
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
    [self loadAllOrder];
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

-(void)loadAllOrder{
    NSArray *orders = [OrderModel findWithFormat:[NSString stringWithFormat:@"WHERE orderName=%@",self.budgetItem.budgetName]];
    self.dataArray = orders.mutableCopy;
    [self.tableView reloadData];
}
@end
