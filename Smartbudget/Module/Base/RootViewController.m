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
    self.view.backgroundColor = [AppSettingDefault share].backgroundColor;
    
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

-(void)addRightBarItem:(NSString *)title image:(UIImage *)img{
    if (!title.length && !img) {
        return;
    }
    UIButton *item = [self button:title image:img];
    UIBarButtonItem *baritem = [[UIBarButtonItem alloc] initWithCustomView:item];
    self.navigationItem.rightBarButtonItem = baritem;
}

-(UIButton *)button:(NSString *)title image:(UIImage *)img{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);

    if (title.length) {
        btn.frame = CGRectMake(0, 0, [title sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}].width + 10, 44);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        btn.frame = CGRectMake(0, 0, img.size.width + 10, img.size.height);
        [btn setImage:img forState:UIControlStateNormal];

    }
    [btn addTarget:self action:@selector(handleNaviBarRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)handleNaviBarRightBtnClick:(id)sender {}


@end
