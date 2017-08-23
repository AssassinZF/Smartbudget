//
//  AppSettingDefault.m
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "AppSettingDefault.h"

@implementation AppSettingDefault

+(instancetype)share{
    static AppSettingDefault *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[AppSettingDefault alloc] init];
    });
    return share;
}

-(UIColor *)themeColor{
    return RGB(245, 67, 86);
}

-(void)projectConfigure{
}
@end
