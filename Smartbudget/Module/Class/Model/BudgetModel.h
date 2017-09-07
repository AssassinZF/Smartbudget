//
//  BudgetModel.h
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

@class OrderModel;

typedef NS_ENUM(NSInteger,OutlayType){
    OutlayTypeGeneral = 0,//一般
    OutlayTypeDine,//用餐
    OutlayTypeDrink,//饮料
    OutlayTypeTraffic,//交通
    OutlayTypeMoive,//电影
    OutlayTypeShopping,//购物
    OutlayTypeMoiveStay,//住宿
    OutlayTypeGift,//礼物
};

@interface BudgetModel : JKDBModel
@property(nonatomic,copy)NSString *budgetName;
@property(nonatomic,copy)NSString *creatTime;
@property(nonatomic,copy)NSString *modifyTime;
@property(nonatomic,assign)CGFloat budgetMoney;//总预算
@property(nonatomic,assign)CGFloat outlayMoney;//支出总金额
@end

@interface OrderModel : JKDBModel
@property(nonatomic,copy)NSString *orderName;//预算名称
@property (nonatomic, assign)OutlayType orderType;//订单类型
@property(nonatomic,copy)NSString *creatTime;
@property(nonatomic,assign)CGFloat orderNumber;//订单支出金额

@end
