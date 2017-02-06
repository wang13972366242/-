//
//  WQManagerController.m
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQManagerController.h"
#import "WQMeManagerTableView.h"

#import "WQVeritEmailController.h"
@interface WQManagerController ()
/** 管理员界面*/
@property(nonatomic,strong) WQMeManagerTableView *tableV;
@end

@implementation WQManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理单";
//    WQVeritEmailController *dd = [[UIStoryboard storyboardWithName:@"WQVeritEmailController" bundle:nil] instantiateInitialViewController];
//    [self.navigationController pushViewController:dd animated:YES];
    NSString *isAdmin = [[NSUserDefaults standardUserDefaults] objectForKey:WISADMINCODE];
    if ([isAdmin isEqualToString:@"YES"]) {
        [self _loadManagerUI];
    }
    //配置管理员界面
    
}


-(void)_loadManagerUI{
    _tableV = [[WQMeManagerTableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableV];

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
