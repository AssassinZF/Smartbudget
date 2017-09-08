//
//  SawtoothView.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/8.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "SawtoothView.h"
#import "AppSettingDefault.h"

@implementation SawtoothView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [AppSettingDefault share].backgroundColor;
        frame.size.height = 20;
        self.frame = frame;
        [self setNeedsDisplay];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //获取绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSInteger waveCount = 25;
    //单个波浪线的宽度
    CGFloat itemWidth = self.width/waveCount;
    //单个波浪线的高度
    CGFloat itemHeight = 8;
    
    UIColor *bgColor = [AppSettingDefault share].themeColor;
    
    
    //移动到起始点,从左上画到右上
    CGContextMoveToPoint(ctx, 0, self.height);
    for (int i = 0; i<waveCount; i++) {
        int nextX = (i+1)*itemWidth;
        
        CGContextAddLineToPoint(ctx, nextX - itemWidth*0.5, self.height - itemHeight);
        CGContextAddLineToPoint(ctx, nextX, self.height);
    }
    
    CGContextAddLineToPoint(ctx, 0, self.height);
    
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    CGContextFillPath(ctx);
    
}


@end
