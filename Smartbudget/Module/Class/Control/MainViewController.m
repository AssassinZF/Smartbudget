//
//  MainViewController.m
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "MainViewController.h"
#import "UIColor+AppConfigure.h"
#import "MainTableViewCell.h"
#import "AppSettingDefault.h"
#import "AddBudgetViewController.h"
#import "BudgetModel.h"
#import "ExpenseViewController.h"

static NSString * const cellID = @"CELLID";
static CGFloat cellHeight = 80;
static CGFloat addButtonW = 50;

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *addButton;//加号
    UIView *roundView;//加号放大背景view
}
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation MainViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadLocalBudgets];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self animationShowAddButton:YES];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self animationShowAddButton:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.title = @"SmartBudget";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    roundView = [UIView new];
    roundView.backgroundColor = [AppSettingDefault share].themeColor;
    roundView.layer.cornerRadius = 0.5;
    roundView.centerX = self.view.centerX;
    roundView.centerY = self.view.height - addButtonW/2 - 40 - NavBar_H;
    roundView.size = CGSizeMake(1, 1);
    [self.view addSubview:roundView];

    
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.size = CGSizeMake(addButtonW, addButtonW);
    addButton.centerX = self.view.centerX;
    addButton.centerY = self.view.height - addButtonW/2 - 40 - NavBar_H;
    addButton.layer.cornerRadius = addButtonW/2;
    [addButton setImage:[UIImage imageNamed:@"addicon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(clickAddOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    [self addRightBarItem:nil image:[UIImage imageNamed:@"setting"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = cellHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = RGB(233, 229, 217);
        _tableView.backgroundColor = RGB(249, 248, 238);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
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
    MainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    BudgetModel *item = self.dataArray[indexPath.row];
    cell.budgetModel = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpenseViewController *VC = [[ExpenseViewController alloc] init];
    VC.budgetItem = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete cell
        BudgetModel *item = self.dataArray[indexPath.row];
        [item deleteObject];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [self.tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];

    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



#pragma mark - PriveMethod

-(void)loadLocalBudgets{
    NSArray *budgets = [BudgetModel findAll];
    self.dataArray = budgets.mutableCopy;
    [self.tableView reloadData];
    if (self.tableView.contentSize.height >= self.tableView.height) {
        CGSize size = self.tableView.contentSize;
        size.height += cellHeight;
        self.tableView.contentSize = size;
    }
}

-(void)clickAddOrder{
    AddBudgetViewController *add = [[AddBudgetViewController alloc] init];
    [self presentViewController:add animated:YES completion:^{}];
}

-(void)animationShowAddButton:(BOOL)isBig{
    [roundView.layer pop_removeAnimationForKey:@"round"];
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    spring.beginTime = CACurrentMediaTime() + 0.5;
    spring.springSpeed = 8;
    spring.springBounciness = 10;
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(isBig?addButtonW:1, isBig?addButtonW:1)];
    [roundView.layer pop_addAnimation:spring forKey:@"round"];

}

@end
