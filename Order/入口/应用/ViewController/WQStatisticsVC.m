//
//  WQStatisticsVC.m
//  Order
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQStatisticsVC.h"
#import "WHUCalendarView.h"//日历
@interface WQStatisticsVC ()
@property(nonatomic,strong) WHUCalendarView *cldV;
@end

@implementation WQStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)configuration{

    _cldV = [[WHUCalendarView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 300)];
    [self.view addSubview:_cldV];
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
