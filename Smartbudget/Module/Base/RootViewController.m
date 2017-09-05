//
//  RootViewController.m
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "RootViewController.h"
#import "AppSettingDefault.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(249, 248, 238);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(SCLAlertView *)alertView{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [AppSettingDefault share].themeColor;
    return alert;
}

@end
