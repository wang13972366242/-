//
//  WQAttendanceVC.m
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAttendanceVC.h"
#import "WQAttendanceCell.h"
#import "WQConfigurationClockVC.h"//考勤里面的配置界面
#import "WQClockVC.h"//打卡界面
#import "WQleaveVC.h"//请假和打卡界面
@interface WQAttendanceVC ()<UITableViewDelegate,UITableViewDataSource>
/** UITableView*/
@property(nonatomic,strong) UITableView *tableView;
/** 数据*/
@property(nonatomic,strong) NSArray *data;
@end

@implementation WQAttendanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"考勤";
    //数据
    _data = @[@"配置基本的信息",@"打卡",@"请假",@"调休",@"加班",@"统计"];
    [self _configurationTableView];
}


-(void)_configurationTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    
    //注册
    [self.tableView registerClass:[WQAttendanceCell class] forCellReuseIdentifier:managerChangeCell];
    
    
}

static NSString *managerChangeCell= @"WQAttendanceCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return   self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WQAttendanceCell *cell = [[WQAttendanceCell alloc]init];
    [cell attendanceCell:tableView WithIdentifier:managerChangeCell initWithFrame:CGRectZero];
    cell.titleLabel.text = _data[indexPath.row];
    return cell;
}



#pragma -mark 尾视图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {//配置信息
        WQConfigurationClockVC *configurationC = [WQConfigurationClockVC storyConfigurationClock];
        [self.navigationController pushViewController:configurationC animated:YES];
    }else if (indexPath.row == 1){//打卡
    
        WQClockVC *clockVC =  [WQClockVC storyClockVC];
        [self.navigationController pushViewController:clockVC animated:YES];
    }else if (indexPath.row == 2 ||indexPath.row == 3){
        //请假 调休
    
        WQleaveVC *leaveVc = [[WQleaveVC alloc]init];
        if (indexPath.row == 2) {
            leaveVc.title = @"请假";
        }else if (indexPath.row == 3){
            leaveVc.title = @"调休";
        }
        [self.navigationController pushViewController:leaveVc animated:YES];
    }else if ( indexPath.row == 4){//加班
    
    }else if (indexPath.row == 5){//统计
    
    
    }
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
