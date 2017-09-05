//
//  RootViewController.h
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
-(SCLAlertView *)alertView;


/**
 add right barItem

 @param title title
 @param img img
 */
-(void)addRightBarItem:(NSString *)title image:(UIImage *)img;
- (void)handleNaviBarRightBtnClick:(id)sender;
@end
