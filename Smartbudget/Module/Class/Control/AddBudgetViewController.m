//
//  AddBudgetViewController.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/24.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "AddBudgetViewController.h"

@interface AddBudgetViewController ()
@property (weak, nonatomic) IBOutlet UIView *downTextFieldView;
@property (weak, nonatomic) IBOutlet UIView *topTextFieldView;
@property (weak, nonatomic) IBOutlet UITextField *moneryTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;


@end

@implementation AddBudgetViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showAnimationView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showAnimationView{
    
    [self.topTextFieldView.layer pop_addAnimation:[self springAnimation:self.topTextFieldView.centerY] forKey:@"1"];
    [self.downTextFieldView.layer pop_addAnimation:[self springAnimation:self.downTextFieldView.centerY] forKey:@"2"];
    [self.completeButton.layer pop_addAnimation:[self springAnimation:self.completeButton.centerY] forKey:@"3"];
}

-(POPSpringAnimation *)springAnimation:(CGFloat)topSpace{
    static NSInteger showCount = 6;
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    spring.springSpeed = showCount+10;
    spring.springBounciness = 10;
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.centerX, self.view.height)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.centerX, topSpace)];
    showCount -= 3;
    return spring;

}

@end
