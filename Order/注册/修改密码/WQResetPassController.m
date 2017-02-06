//
//  WQResetPassController.m
//  SignModel
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQResetPassController.h"

@interface WQResetPassController ()



/**
 *  手机底部视图
 */
@property (weak, nonatomic) IBOutlet UIView *iphonBGView;

/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *textErification;
/**
 *  账号
 */
@property (weak, nonatomic) IBOutlet UITextField *numberTF;





@end

@implementation WQResetPassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}



/**
 *  验证验证码
 */
- (IBAction)confirm:(UIButton *)sender {
}

/**
 *  获取验证码
 */
- (IBAction)getErification:(UIButton *)sender {
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
