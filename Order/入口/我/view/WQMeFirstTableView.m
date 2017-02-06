//
//  WQMeFirstTableView.m
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQMeFirstTableView.h"

#import "WQFirstTableViewCell.h"
#import "WQMeDetailController.h"
#import "WQMeNewsController.h"
#import "WQManagerController.h"
#import "WQSetController.h"
@interface WQMeFirstTableView()
/** 图片数组*/
@property(nonatomic,strong) NSArray *photoArr;
@end
@implementation WQMeFirstTableView

-(NSArray *)medata{

    if (_medata == nil) {
        _medata = @[@"我的信息",@"管理单",@"我的消息",@"设置"];
    }
    return _medata;
}

-(void)awakeFromNib{
    [super awakeFromNib];
  
    _photoArr = @[[UIImage imageNamed:@"my_xinxi"],[UIImage imageNamed:@"my_guanlidan"],[UIImage imageNamed:@"my_xiaoxi"],[UIImage imageNamed:@"chat_btn_setting@3x 09.22.10"]];

    self.dataSource = self;
    self.delegate =  self;
    self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    //设置cell的高度
    CGFloat rowHeight = (KScreenHeight - 64-49-50) /4;
    self.rowHeight = rowHeight;
    //隐藏滑动条
    self.showsVerticalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cel
//    [self registerClass:[WQFirstTableViewCell class] forCellReuseIdentifier:firstCell];

}
    static NSString *firstCell= @"firstCell";


#pragma mark ---UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.medata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WQFirstTableViewCell *cell = [WQFirstTableViewCell firstTableViewCell:tableView WithIdentifier:firstCell];
  
    cell.backgroundColor = [UIColor whiteColor];
    cell.labelStr = _medata[indexPath.row];
    cell.imageV.image = _photoArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WQMeDetailController *detail = [[UIStoryboard storyboardWithName:@"WQMeDetailController" bundle:nil] instantiateInitialViewController];
    WQMeNewsController *news = [[UIStoryboard storyboardWithName:@"WQMeNewsController" bundle:nil] instantiateInitialViewController];
    WQManagerController *manager = [[UIStoryboard storyboardWithName:@"WQManagerController" bundle:nil] instantiateInitialViewController];
    WQSetController *set = [[UIStoryboard storyboardWithName:@"WQSetController" bundle:nil] instantiateInitialViewController];
    
    WQRespondView *resopnd = [[WQRespondView alloc]init];
    [self addSubview:resopnd];
    
    if (indexPath.row == 0) {
        [[resopnd respondForController].navigationController pushViewController:detail animated:YES];
        
    }else if (indexPath.row == 1){
    
       [[resopnd respondForController].navigationController pushViewController:manager animated:YES];
    }else if (indexPath.row == 2){
  
     [[resopnd respondForController].navigationController pushViewController:news animated:YES];
    
    }else{
     [[resopnd respondForController].navigationController pushViewController:set animated:YES];
    
    }
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}



#pragma mark -- 触摸编辑区外关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    
}


@end
