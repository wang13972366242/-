//
//  WQNewUserRegisterController.m
//  SignModel
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQNewUserRegisterController.h"
#import "Registration-ActivationController.h"
@interface WQNewUserRegisterController ()

@end

@implementation WQNewUserRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
/**
 *  登录
 */
- (IBAction)loadBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  公司注册
 */
- (IBAction)companySignBtn:(id)sender {
   
}
/**
 *  员工注册
 */
- (IBAction)personSignBtn:(UIButton *)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"company"]) {
        segue.destinationViewController.title =@"公司激活";
        
    }else if ([segue.identifier isEqualToString:@"person"]){
    segue.destinationViewController.title =@"员工激活";
    
    }
}


@end
