//
//  WQSignController.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQSignController.h"

@interface WQSignController ()
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;

@end

@implementation WQSignController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES];

}

-(void)viewDidAppear:(BOOL)animated{


    [self.navigationController setNavigationBarHidden:NO];
}
//修改密码
- (IBAction)changPassWord:(UIButton *)sender {
    
    
}

//注册新用户
- (IBAction)signUser:(id)sender {
    
}

//登录
- (IBAction)signBtn:(UIButton *)sender {

    _block(_userName.text,_passWord.text);
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
