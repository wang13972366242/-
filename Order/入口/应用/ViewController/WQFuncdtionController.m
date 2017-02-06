//
//  WQFuncdtionController.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQFuncdtionController.h"
#import "WQSignController.h"
#import "WQAttendanceVC.h"//考勤

@interface WQFuncdtionController ()

@end

@implementation WQFuncdtionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//考勤
- (IBAction)attendanceAction:(UIButton *)sender {
    
    WQAttendanceVC *attenVC = [[WQAttendanceVC alloc]init];
    [self.navigationController pushViewController:attenVC animated:YES];
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
