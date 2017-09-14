//
//  ChartView.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/8.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "ChartView.h"

@interface ChartView()
@property (nonatomic, strong)PNPieChart *pieChart;//扇形图表
@end

@implementation ChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(void)setDataArray:(NSArray<PNPieChartDataItem *> *)dataArray{
    _dataArray = dataArray;
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake((CGFloat) (self.width / 2.0 - 100), 20, 200.0, 200.0) items:_dataArray];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    [self.pieChart strokeChart];
    
    
    self.pieChart.legendStyle = PNLegendItemStyleStacked;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    [self addSubview:self.pieChart];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.pieChart.frame = CGRectMake((CGFloat) (self.width / 2.0 - 100), 20, 200.0, 200.0);
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
