//
//  WQMeManagerTableView.m
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQMeManagerTableView.h"

#import "CompanyInfoChangeVC.h"//公司信息修改
#import "WQMeManagerCell.h"//管理图单元格
#import "WQAdminInformationVC.h"
@implementation WQMeManagerTableView

-(NSArray *)managerArr{
    
    if (_managerArr == nil) {
        _managerArr = @[@"员工信息查询与修改",@"公司修改",@"套餐消息",@"管理单"];
    }
    return _managerArr;
    
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate =  self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        //设置cell的高度
        self.rowHeight = 60;

        //隐藏滑动条
        self.showsVerticalScrollIndicator = NO;
        //注册
        [self registerClass:[WQMeManagerCell class] forCellReuseIdentifier:managerCell];
    }
    return self;
}
static NSString *managerCell= @"managerCell";


#pragma mark ---UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.managerArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WQMeManagerCell *cell = [[WQMeManagerCell alloc]init];
    [cell memanamgerCell:tableView WithIdentifier:managerCell initWithFrame:CGRectZero];
    cell.contentLabel.text =self.managerArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    
    if (indexPath.row == 0) {
        WQAdminInformationVC *adminVC = [[WQAdminInformationVC alloc]init];
         [[self respondForController].navigationController pushViewController:adminVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        CompanyInfoChangeVC *companyVC = [CompanyInfoChangeVC infoChangeVC];
        [[self respondForController].navigationController pushViewController:companyVC animated:YES];
    }
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)scanMemberRequest{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    NSString *varcodeStr = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsACTVarCode];
    
    OrganizedClientMessage *message;
    @try {
       
    } @catch (NSException *exception) {
        return;
    }
    
   
//    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
//        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
//        if (oM) {
//            
//        }
//        
//        
//    }];
    
    
}


- (UIViewController *)respondForController {
    
    UIResponder *next = self.nextResponder;
    
    // 只要响应者链上，还有下一级响应者，就一直查找
    do {
        // 判断获取的响应者对象是否是 视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            //
            // 返回查找到的视图控制器
            return (UIViewController *)next;;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    
    return nil;
}
-(id)unarchverCustomClassFileName:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@.data",fileName ];
    //获取路径
    NSString *cachePath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取文件全路径
    NSString *fielPath = [cachePath stringByAppendingPathComponent:str];
    //把自定义对象解档
    id object= [NSKeyedUnarchiver unarchiveObjectWithFile:fielPath];
    return object;
}
@end
