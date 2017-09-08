//
//  AppSettingDefault.h
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppSettingDefault : NSObject
@property(nonatomic,strong)UIColor *themeColor;
+(instancetype)share;
-(void)projectConfigure;
-(UIColor *)backgroundColor;
@end
