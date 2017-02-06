//
//  CompanyInfoChangeVC.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CompanyInfoChangeVC.h"
#import "CompanyCell.h"
#import "UIViewExt.h"
#import "ScanDepartment.h"
#import "PositionFrameVC.h"



#import "OrganizedClientMessage.h"




@interface CompanyInfoChangeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scorllview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
/** UItableviw*/
@property(nonatomic,strong) UITableView *tableView;
/** UITextView*/
@property(nonatomic,strong) UITextView *textView;
/** 查看按钮*/
@property(nonatomic,strong) UIButton *scanBtn;
/** 修改按钮*/
@property(nonatomic,strong) UIButton *changeBtn;
/** 查看功能*/
@property(nonatomic,strong) UIButton *scanFunctionsBtn;
/** 基本信息数组 */
@property(nonatomic,strong) NSArray *baseArr;

/** 公司*/
@property(nonatomic,strong) OrganizedCompany *company;
@property(nonatomic,strong) UserCompanyBase *companybase;
@property(nonatomic,strong) OrganizedMember *member;
@end

@implementation CompanyInfoChangeVC



+(CompanyInfoChangeVC*)infoChangeVC{
    return  [[UIStoryboard storyboardWithName:@"CompanyInfoChangeVC" bundle:nil] instantiateInitialViewController];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    self.title = @"公司信息修改";
    _baseArr = @[@"名称:",@"地址:",@"电话:",@"邮箱:",@"类型:",@"公司描述:",@"查看职位架构:",@"修改职位架构:",@"购买的功能:"];
      _scrollViewHeight.constant = _baseArr.count *50 +100;
    //1.创建tableview
    [self _configurationTableView];
    //2.获取数据
    [self getCompanyInfo];
    
}

-(void)getCompanyInfo{
    _company =   [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompany];
    _companybase = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompanyBase];
    _member = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];

}
-(void)_configurationTableView{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, _baseArr.count *50 +50 +50) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.scorllview addSubview:self.tableView];
    //注册
    [self.tableView registerClass:[CompanyCell class] forCellReuseIdentifier:companyCell];

    
}

static NSString *companyCell = @"CompanyCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return   _baseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CompanyCell *cell = [[CompanyCell alloc]init];
    [cell companyCell:tableView WithIdentifier:companyCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _baseArr[indexPath.row];
    //添加公司信息
    if (indexPath.row <5) {
  
    [self companyContentInformation:cell.contentLabel sureStr:_baseArr[indexPath.row]];
    }
    
    //描述
    if ([_baseArr[indexPath.row] isEqualToString:@"公司描述:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_textView == nil) {
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(80+6, 6, KScreenWidth - 10 -5 -cell.contentLabel.width, 100-12)];
            _textView.font = [UIFont systemFontOfSize:14.0f];
            [cell.contentView addSubview:_textView];
        }else{
        [cell.contentView addSubview:_textView];
        }
        _textView.text = _company.m_szCompanySummary;
    }
    //查看按钮
    if ([_baseArr[indexPath.row] isEqualToString:@"查看职位架构:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_scanBtn == nil) {
            _scanBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(100+6+15, 6, 150, 50-12) title:@"查看职位架构" titleColor:[UIColor blackColor]];
            [_scanBtn addTarget:self action:@selector(sacnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scanBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
            [cell.contentView addSubview:_scanBtn];
        }else{
        [cell.contentView addSubview:_scanBtn];
        }
    }
    
    //修改按钮
    if ([_baseArr[indexPath.row] isEqualToString:@"修改职位架构:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_changeBtn == nil) {
            _changeBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(100+6+15, 6, 150, 50-12) title:@"修改职位架构" titleColor:[UIColor blackColor]];
             [_changeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
             [_changeBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
            [cell.contentView addSubview:_changeBtn];
        }else{
            [cell.contentView addSubview:_changeBtn];
        }
    }
    
    //参看功能按钮
    if ([_baseArr[indexPath.row] isEqualToString:@"购买的功能:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_scanFunctionsBtn == nil) {
            _scanFunctionsBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(100+6+15, 6, 150, 50-12) title:@"查看购买的功能" titleColor:[UIColor blackColor]];
            [_scanFunctionsBtn addTarget:self action:@selector(scanFunctionsAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scanFunctionsBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
            [cell.contentView addSubview:_scanFunctionsBtn];
        }else{
            [cell.contentView addSubview:_scanFunctionsBtn];
        }
    }
    return cell;
}


-(void)companyContentInformation:(UILabel *)label  sureStr:(NSString *)sureStr{
    if ([sureStr isEqualToString:@"名称:"]) {
        label.text = _companybase.m_szName;
    }else if ([sureStr isEqualToString:@"地址:"]){
//        label.text = _company.m_vcAddressArr;
    
    }else if ([sureStr isEqualToString:@"电话:"]){
        label.text = _companybase.m_szMobile;
        
    }else if ([sureStr isEqualToString:@"邮箱:"]){
        
        label.text = _companybase.m_szEmail;
    }else if ([sureStr isEqualToString:@"类型:"]){
        label.text = _company.m_szCompanyType;
        
    }


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 单元阁自适应高度
    if (indexPath.row == 5) {
        return 100;
    }else{
    return 50;
    }
}

#pragma -mark 尾视图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    
    CGFloat w = 200.0;
    CGFloat x =  (KScreenWidth -w) /2.0;
    
    UIButton *btn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(x, 10, w, 30) title:@"信息修改" titleColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(sureChange:) forControlEvents:UIControlEventTouchUpInside];
     [btn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
    [view addSubview:btn];
    return view;
}


#pragma mark - 查看功能和确认修改方法

-(void)scanFunctionsAction:(UIButton *)sender{

    [self scanFunctionsAFNetWorking];

}


-(void)sureChange:(UIButton *)sender{

    [self changeInfoAFNetWorking];

}

-(void)scanFunctionsAFNetWorking{
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    // 加密
    NSDictionary *muDic;
    @try {
        OrganizedClientMessage *message = [OrganizedClientMessage getInstanceOfCompanyGetInfoRequest:_member.m_szUserAccount bIsUserLogin:true COMPANy_STAT_ID:@[@"Functionlist"]];
        NSString *messageStr = [message toString];
        muDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS"};
    } @catch (NSException *exception) {
        return;
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            @try {
                NSDictionary *infoDic = [oM getCompanyInfoStat];
                NSString *functionStr =  infoDic[@"Functionlist"];
                NSArray *arr = [CompanyFunction stringToFunctionArray:functionStr];
                NSLog(@"%@",arr);
                
            } @catch (NSException *exception) {
                return ;
            }
          
        }
        
    }];
    
    
}


-(void)changeInfoAFNetWorking{
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    // 加密
    NSDictionary *muDic;
    
    @try {
        OrganizedClientMessage *message = [OrganizedClientMessage getInstanceOfCompanySetInfoRequest:_member.m_szUserAccount values:@{@"Address":@"12312323"}];
        NSString *messageStr = [message toString];
        muDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS"};
    } @catch (NSException *exception) {
        return;
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
          
        }
        
    }];
    
    
}


#pragma mark - 查看和修改按钮职位按钮
-(void)sacnAction:(UIButton *)sender{

    ScanDepartment * scanD = [[ScanDepartment alloc]init];
    [self.navigationController pushViewController: scanD animated:YES];

}

-(void)changeAction:(UIButton *)sender{
    PositionFrameVC *Pvc =  [PositionFrameVC frameVC];;
    
    [self.navigationController pushViewController:Pvc animated:YES];
    
    
}






-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.frame = frame;
    return  btn;
}

#pragma mark -UIAlertController
-(void)alertControllerShowWithTheme:(NSString *)themeTitle suretitle:(NSString *)suretitle{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:themeTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [alertC addAction:sureAction];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
    
}


@end
