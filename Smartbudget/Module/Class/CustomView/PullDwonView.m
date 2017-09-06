//
//  PullDwonView.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/6.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "PullDwonView.h"
#import "AppSettingDefault.h"

static CGFloat Icon_W = 40;
static CGFloat bottomSpace = 30;

@interface PullDwonView()
{
    UIImageView *lightImageView;
    UIImageView *dashImageView;
    CGFloat pointy;
    BOOL pullFinish;//下拉重合
}
@end

@implementation PullDwonView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        lightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pullRound"]];
        lightImageView.bounds = CGRectMake(0, 0, Icon_W, Icon_W);
        lightImageView.center = CGPointMake(self.width/2, self.height- 3*bottomSpace - Icon_W-Icon_W/2);
        [self addSubview:lightImageView];
        [self bringSubviewToFront:lightImageView];
        
        dashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval"]];
        dashImageView.bounds = CGRectMake(0, 0, Icon_W, Icon_W);
        dashImageView.center = CGPointMake(self.width/2, self.height - bottomSpace - Icon_W/2);
        [self addSubview:dashImageView];
        
        pointy = lightImageView.center.y;
    }
    return self;
}

-(void)setScrollOffy:(CGFloat)scrollOffy{
    _scrollOffy = scrollOffy;
    if (scrollOffy<0) {
        return;
    }
    CGFloat crisis = bottomSpace+Icon_W;//出现绿色圆的临界值
    if (scrollOffy > crisis+bottomSpace) {
        pullFinish = YES;
        self.backgroundColor = [AppSettingDefault share].themeColor;
        lightImageView.layer.position = dashImageView.layer.position;

    }else{
        self.backgroundColor = [UIColor whiteColor];
        lightImageView.layer.position = CGPointMake(dashImageView.centerX, pointy+scrollOffy);

    }
}

@end
