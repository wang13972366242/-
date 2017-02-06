//
//  WQleaveVC.m
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQleaveVC.h"
#import "WHUCalendarView.h"//日历
#import "WQLeaveView.h"//请假
#import "WQAddPaidView.h"//调休
#import "WQDayCell.h"//按天
#import "WQWeekCell.h"//按周
@interface WQleaveVC ()<UITableViewDelegate,UITableViewDataSource>
/** 选择方法*/
@property(nonatomic,strong) UIPickerView *pickV;
/** 方式*/
@property(nonatomic,strong) NSArray *pickArr;
/** scrollView*/
@property(nonatomic,strong) UIScrollView *scrollV;
/** WHUCalendarView*/
@property(nonatomic,strong) WHUCalendarView *cldV;
/** tableview*/
@property(nonatomic,strong) UITableView *tableView;
/** leave*/
@property(nonatomic,strong) WQLeaveView *leaveView;
@property(nonatomic,strong) WQAddPaidView *paidLeaveView;

/** data*/
@property(nonatomic,strong) NSArray *data;

/** different cell*/
@property(nonatomic,strong) NSString *differentStr;

/** 按钮的视图*/
@property(nonatomic,strong) UIView *threeeBtnView;

/** 查看方式按钮*/
@property(nonatomic,strong) UIButton *wayBtn;
@end

@implementation WQleaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     [self createDataSource];
    //配置子视图
    [self _confingureSubViewS];
    
}

/**
 *  视图
 *
 *  1.查看的方法Label+UIpickView
 *  2.UIScroeenView
 */

-(void)_confingureSubViewS{
    //1.label
    UILabel *label = [self creatLabelWithFrame:CGRectMake(5, 64,100, 40) textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:14.f] textColor:[UIColor blackColor] text:@"查看的方式"];
    [self.view addSubview:label];
    //UIBten
   _wayBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(label.right, 64, KScreenWidth - label.width -10, 40) title:@"按月查看" titleColor:[UIColor blackColor]];
//    _wayBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_wayBtn addTarget:self action:@selector(showPickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wayBtn];

    
    //2.UIScrollView
    CGFloat scrollVX = 0.0;
    CGFloat scrollVY = label.bottom +10;
    CGFloat scrollVW = KScreenWidth;
    CGFloat scrollVH = KScreenHeight - 100 -64;
    _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(scrollVX, scrollVY, scrollVW, scrollVH)];
    _scrollV.contentSize = CGSizeMake(KScreenWidth, KScreenHeight);
    [self.view addSubview:_scrollV];
    //按月默认
    [self monthlyCheck];
    
}

#pragma -mark 按月 按周 按日
-(void)monthlyCheck{
    //2.1日历
    _cldV = [[WHUCalendarView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 300)];
    [_scrollV addSubview:_cldV];
    //调休 或者请假3.1
    if ([self.title isEqualToString:@"请假"]) {
        _leaveView = [WQLeaveView  nibLeaveView];
        [self.scrollV addSubview:_leaveView];
        _leaveView.frame = CGRectMake(0, _cldV.bottom+10, KScreenWidth, 100);
    }else{
        _paidLeaveView = [WQAddPaidView nibPaidView];
        _paidLeaveView.frame = CGRectMake(0, _cldV.bottom+10, KScreenWidth, 100);
        [self.scrollV addSubview:_paidLeaveView];
    }

}

-(void)daylyCheck{
    [self _configurationTableView];
    [self.tableView registerClass:[WQDayCell class] forCellReuseIdentifier:managerChangeCell];
  self.differentStr = @"按天";
    self.tableView.rowHeight = 50.0f;

}

-(void)weeklyCheck{
    [self _configurationTableView];
    [self.tableView registerClass:[WQWeekCell class] forCellReuseIdentifier:managerChangeCell];
    self.differentStr = @"按周";
    self.tableView.rowHeight = 80.0f;
}

#pragma -mark 按钮出现一个视图(3个按钮)
-(void)showPickView:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
          [self showSelectedThree];
    }else{
    
        [_threeeBtnView removeFromSuperview];
    }
    
   
}


-(void)showSelectedThree{
    
    _threeeBtnView = [[UIView alloc]initWithFrame:CGRectMake(105,_wayBtn.bottom, _wayBtn.width, 90)];
    _threeeBtnView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_threeeBtnView];
    
    UIButton *monthBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, _wayBtn.bottom, 30) title:@"按月查看" titleColor:[UIColor blackColor]];
    [monthBtn addTarget:self action:@selector(threenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    monthBtn.tag = 30000;
    UIButton *weeekBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(0, 30, _wayBtn.bottom, 30) title:@"按周查看" titleColor:[UIColor blackColor]];
     [weeekBtn addTarget:self action:@selector(threenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    weeekBtn.tag = 30001;
    UIButton *dayBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, _wayBtn.bottom, 30) title:@"按天查看" titleColor:[UIColor blackColor]];
     [dayBtn addTarget:self action:@selector(threenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    dayBtn.tag = 30002;
    [_threeeBtnView addSubview:monthBtn];
    [_threeeBtnView addSubview:weeekBtn];
    [_threeeBtnView addSubview:dayBtn];
    
}


-(void)threenBtnAction:(UIButton *)sender{
    NSArray *arr = [_scrollV subviews];
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
    [_threeeBtnView removeFromSuperview];
    if (sender.tag ==30000) {
        [self monthlyCheck];
        [_wayBtn setTitle:@"按月查看" forState:UIControlStateNormal];
    }else if (sender.tag ==30001){
        [self weeklyCheck];
         [_wayBtn setTitle:@"按周查看" forState:UIControlStateNormal];
    }else if (sender.tag ==30002){
        [self daylyCheck];
          [_wayBtn setTitle:@"按天查看" forState:UIControlStateNormal];
    }


}
//创建数据源
- (void)createDataSource
{
    self.pickArr = @[@"按月查看",@"按周查看",@"按天查看"];
    self.data = @[@"1",@"2",@"3",@"4",@"5"];
}






-(void)_configurationTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    
    [self.scrollV addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

static NSString *managerChangeCell= @"WQAttendanceCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return   self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.differentStr isEqualToString:@"按天" ]) {
        WQDayCell *cell = [[WQDayCell alloc]init];
        [cell dayCell:tableView WithIdentifier:managerChangeCell initWithFrame:CGRectZero];
        
        cell.contentLabel.text = _data[indexPath.row];
        return cell;
    }else if ([self.differentStr isEqualToString:@"按周" ]){
     WQWeekCell *cell = [[WQWeekCell alloc]init];
        [cell weekCell:tableView WithIdentifier:managerChangeCell initWithFrame:CGRectZero];
        cell.weekLabel.text = @"周一";
        cell.timeLabel.text = @"1233";
        cell.numberLabel.text = @"N次";
       return cell;
    
    }
    return nil;
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
   
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}



-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}

-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    btn.frame = frame;
    return  btn;
}


@end
