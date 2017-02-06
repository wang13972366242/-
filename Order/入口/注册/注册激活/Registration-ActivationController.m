//
//  Registration-ActivationController.m
//  SignModel
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "Registration-ActivationController.h"

@interface Registration_ActivationController ()
/**
 *  错误的原因
 */
@property (weak, nonatomic) IBOutlet UILabel *errorWhy;
/**
 *  激活码
 */
@property (weak, nonatomic) IBOutlet UITextField *resignTF;


@end

@implementation Registration_ActivationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/**
 *  点击“购买激活码”，实现方法
 */
- (IBAction)buySignCodeBtn:(UIButton *)sender {
}

/**
 *  点击“确认”，调用
 */
- (IBAction)confirmBtn:(UIButton *)sender {
}

/**
 * 点击“什么是激活码”按钮，调用方法
 */
- (IBAction)activationCode:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
