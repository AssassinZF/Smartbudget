//
//  ChartView.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/8.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PNChart.h>

@interface ChartView : UIView
@property (nonatomic, strong)NSArray <PNPieChartDataItem *>*dataArray;
@end
