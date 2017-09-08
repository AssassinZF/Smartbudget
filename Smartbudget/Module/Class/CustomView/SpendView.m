//
//  SpendView.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/6.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "SpendView.h"
#import "AppSettingDefault.h"
#import "UIColor+AppConfigure.h"
#import "LabelCollectionViewCell.h"
#import "BudgetModel.h"

@interface SpendView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger selectItem;
}
@property (weak, nonatomic) IBOutlet UITextField *outPlayMoneyTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation SpendView

+(instancetype)showWithSuperView:(UIView *)superView{
    SpendView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    [view initUI];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:1 animations:^{
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }];
    [view showAnimation];
    [view.outPlayMoneyTextField becomeFirstResponder];
    return view;
    
}

-(void)initUI{
    self.backgroundColor = [UIColor blackColor];
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.0];
    [self.completeBtn setTintColor:[AppSettingDefault share].themeColor];
    
    self.outPlayMoneyTextField.textColor = [UIColor moneyColor];
    self.outPlayMoneyTextField.tintColor = [UIColor moneyColor];
    
    [self.outPlayMoneyTextField setValue:[UIColor moneyColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.labelTextField.textColor = [UIColor fontColor];
    [self.labelTextField setValue:[UIColor fontColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.labelTextField.tintColor = [UIColor fontColor];

    
    self.pageControl.tintColor = [AppSettingDefault share].themeColor;
    
    self.pageControl.numberOfPages = self.dataArray.count/10;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LabelCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    UICollectionViewFlowLayout *Layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    NSInteger rowCount = 5;
    NSInteger lineCount = 2;
    Layout.minimumLineSpacing = 1;
    Layout.minimumInteritemSpacing = 1;
    CGFloat itemSizeH = (self.collectionView.height - Layout.minimumLineSpacing*(lineCount+1))/lineCount;
    CGFloat itemSizeW = (self.collectionView.width - Layout.minimumInteritemSpacing*(rowCount+1))/rowCount;
    Layout.itemSize = CGSizeMake(itemSizeW, itemSizeH);
}


- (IBAction)clickDimss:(id)sender {
    [self removeFromSuperview];

}

- (IBAction)clickDone:(id)sender {
    
    if (!_outPlayMoneyTextField.text.length) {
        return;
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"不能添加空的支出" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alert addAction:cancle];
    }
    
    OrderModel *order = [[OrderModel alloc] init];
    order.orderNumber = [self.outPlayMoneyTextField.text floatValue];
    order.orderType = 1;
    order.creatTime = [[NSDate date] stringWithFormat:@"YYYY/MM/dd hh:mm"];
    
    if (self.orderAddBlock) {
        self.orderAddBlock(order);
    }
    
    [self removeFromSuperview];
    
}

-(void)showAnimation{
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.height)];
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.backgroundView.height/2+20)];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(0.0);
    opacity.toValue = @(1.0);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.2;
    animationGroup.animations = @[position,opacity];
    
    [self.backgroundView.layer addAnimation:animationGroup forKey:nil];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LabelCollectionViewCell *oldcell = (LabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:selectItem inSection:0]];
    [oldcell changeSlected:NO];
    LabelCollectionViewCell *cell = (LabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changeSlected:YES];
    selectItem = indexPath.item;
    self.labelTextField.text = cell.dicData[@"name"];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = self.dataArray[indexPath.row];
    cell.dicData = item;
    if (indexPath.item == selectItem) {
        [cell changeSlected:YES];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < self.collectionView.width/2) {
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = 1;
    }

}

-(NSArray *)dataArray{
    if (!_dataArray) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"OrderTypeLabel" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:fileName];
    }
    return _dataArray;
}

















@end
