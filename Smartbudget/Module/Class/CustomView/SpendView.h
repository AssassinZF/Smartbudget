//
//  SpendView.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/6.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddOrderBlock)(id orderItem);

@interface SpendView : UIView
@property (nonatomic, copy)AddOrderBlock orderAddBlock;
+(instancetype)showWithSuperView:(UIView *)superView;
@end
