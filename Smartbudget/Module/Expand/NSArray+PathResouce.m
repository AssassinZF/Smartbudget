//
//  NSObject+PathResouce.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/9/8.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "NSArray+PathResouce.h"

@implementation NSArray (PathResouce)
+(NSArray *)labelTypeData{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"OrderTypeLabel" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:fileName];
}

@end
