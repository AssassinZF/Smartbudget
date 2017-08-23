//
//  BudgetModel.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,OutlayType){
    OutlayTypeDefault = 0,
    OutlayTypeDine,//用餐
    OutlayTypeDrink,//饮料
    OutlayTypeTraffic,//交通
    OutlayTypeMoive,//电影
};

@interface BudgetModel : NSObject
@property(nonatomic,copy)NSString *budgetName;
@property(nonatomic,copy)NSString *creatTime;
@property(nonatomic,copy)NSString *modifyTime;
@property(nonatomic,assign)CGFloat budgetMoney;//总预算
@property(nonatomic,assign)CGFloat outlayMoney;//话费金额
@end

@interface OutlayModel : NSObject
@property(nonatomic,copy)NSString *outlayName;
@property(nonatomic,copy)NSString *creatTime;
@property(nonatomic,assign)CGFloat outlayNumber;//单次支出金额

@end
