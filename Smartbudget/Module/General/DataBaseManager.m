//
//  DataBaseManager.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

+(instancetype)share{
    static DataBaseManager *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[DataBaseManager alloc] init];
    });
    return share;
}


@end
