//
//  RootNavgationController.m
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "RootNavgationController.h"
#import "AppSettingDefault.h"

@interface RootNavgationController ()

@end

@implementation RootNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [AppSettingDefault share].themeColor;
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
