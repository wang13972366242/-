//
//  WQClockVC.m
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQClockVC.h"
#import "SelectedView.h"
@interface WQClockVC ()<SelectedViewDelegate>
//今天的日期
@property (weak, nonatomic) IBOutlet UILabel *toDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *singleTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *wrokingLabel;
/** SelectedView.h*/
@property(nonatomic,strong) SelectedView *differView;
/** 打卡的方式*/
@property(nonatomic,strong) NSArray  *arr;
@property (weak, nonatomic) IBOutlet UIButton *clockBtn;

@end

@implementation WQClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = @[@"WIFI打卡",@"GPS打卡"];
}

//不同的打开方式
- (IBAction)differentWay:(UIButton *)sender {
    if (_differView ==nil) {
        
        _differView = [[SelectedView alloc]initWithFrame:CGRectMake(sender.left, sender.bottom, sender.width, _arr.count *30)];
    }
    _differView.numberArr =_arr;
    _differView.selectedDelegate = self;
    [self.view addSubview:_differView];
}

//代理方法
- (void)clickCollection: (SelectedView *)selecetView didSelected: (NSString *)fieldText{
    [selecetView removeFromSuperview];
    
    [_clockBtn setTitle:fieldText forState:UIControlStateNormal];
    
}

//上下班打卡
- (IBAction)workAction:(UIButton *)sender {
}
//单次打卡
- (IBAction)singleAction:(UIButton *)sender {
    
}


+(WQClockVC *)storyClockVC{
    
    return [[UIStoryboard storyboardWithName:@"WQClockVC" bundle:nil] instantiateInitialViewController];
    
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
