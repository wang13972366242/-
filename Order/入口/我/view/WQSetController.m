//
//  WQSetController.m
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQSetController.h"
#import "WQSetSecondController.h"
#import "OrganizedClientMessage.h"
@interface WQSetController ()<UITableViewDelegate,UITableViewDataSource>
/** 数据*/
@property(nonatomic,strong) NSArray *setArr;
/** tableView*/
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation WQSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建tableView
    [self configurationTableView];
}

-(NSArray *)setArr{
    
    if (_setArr == nil) {
        _setArr = @[@"关于我们",@"意见反馈",@"技术支持",@"检查更新",@"给应用评分",@"版本号",@"语言切换"];
    }
    return _setArr;
    
}

-(void)configurationTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    
  
}

static NSString *setCell= @"setCell";


#pragma mark ---UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.setArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.setArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.backgroundColor = [UIColor lightGrayColor];
    [footBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    footBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    //    footBtn.titleLabel.textColor = [UIColor blackColor];
    [footBtn addTarget:self action:@selector(addSubTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    footBtn.frame = CGRectMake(20, 5, KScreenWidth-40, 80.0);
    
    
    return footBtn;
}
//跳转到登录界面
-(void)addSubTitleAction:(UIButton *)sender{
    [self quitComapanyRequest];
    
    
}

#pragma mark -网络请求
//退出登录
-(void)quitComapanyRequest{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    UserBean *user =[CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMemberBase];
    OrganizedClientMessage *oMessage;
   
    @try {
        oMessage = [OrganizedClientMessage getInstanceOfUserLogOutRequest:user];
        
    } @catch (NSException *exception) {
        
    }
   NSString *messageStr = [oMessage toString];
    NSDictionary *params = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    
        [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:params viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
            OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
            if (oM) {
            [APPD goLoginViewController];
            }
            
        }];
    
    
}
//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WQSetSecondController *setSceondVC  = [[WQSetSecondController alloc]init];
    
    setSceondVC.titleStr = _setArr[indexPath.row];
    
    [self.navigationController pushViewController:setSceondVC animated:YES];
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}



@end
