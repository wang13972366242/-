//
//  WQCompanyController.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQCompanyController.h"
#import "WQAddCompanyController.h"
#import "OrganizedClientMessage.h"
@interface WQCompanyController ()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *companyName;

@property (weak, nonatomic) IBOutlet UILabel *companyMobile;

@property (weak, nonatomic) IBOutlet UILabel *companyType;
@property (weak, nonatomic) IBOutlet UILabel *companyAddress;

@property (weak, nonatomic) IBOutlet UILabel *companyEmail;


@property (weak, nonatomic) IBOutlet UILabel *companySummary;

/**
 *  滑动是视图内容高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
/**
 *  滑动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *companyScrollView;

/**
 *  退出按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;
/**
 *  加入公司
 */
@property (weak, nonatomic) IBOutlet UIButton *addCompanyBtn;

@end

@implementation WQCompanyController



- (void)viewDidLoad {
    [super viewDidLoad];
    //1.公司显示
    [self showCompanyInformation];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCompanySucess) name:@"addComapny" object:nil];
}


-(void)showCompanyInformation{
    
    OrganizedCompany *company =   [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompany];
   UserCompanyBase *comBase = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompanyBase];
    if (company &&comBase) {
        _quitBtn.hidden =NO;
        _addCompanyBtn.hidden =YES;
        _scrollView.hidden = NO;
        
        
      [self assignmentLabel:_companyName companyinfo:comBase.m_szName appString:@"名称:"];
     [self assignmentLabel:_companyType companyinfo:company.m_szCompanyType appString:@"类型:"];
     [self assignmentLabel:_companyEmail companyinfo:comBase.m_szEmail appString:@"邮箱:"];
     [self assignmentLabel:_companyMobile companyinfo:comBase.m_szMobile appString:@"电话:"];
        NSString * addStr = [NSMutableString string];
        for (NSString *str in company.m_vcAddressArr) {
            [addStr stringByAppendingString:str];
            [addStr stringByAppendingString:@"/r/n"];
        }
     [self assignmentLabel:_companyAddress companyinfo:addStr appString:@"地址:"];
     [self assignmentLabel:_companySummary companyinfo:company.m_szCompanySummary appString:@"描述:"];
    }else{
    
        _quitBtn.hidden =YES;
        _addCompanyBtn.hidden =NO;
        _scrollView.hidden = YES;
    }


}

-(void)assignmentLabel:(UILabel *)label  companyinfo:(NSString *)companyInfo appString:(NSString *)appStr{


    label.text = [NSString stringWithFormat:@"%@%@",appStr,companyInfo];



}
/**
 *  退出按钮
 *  1.点击"退出按钮" 跳出 UIAlertController 有2个按钮 “确认”和“取消”
    2. 点击“确认” --> 1."退出按钮"隐藏 2.滑动视图隐藏 3."加入公司按钮"显示 4.UIAlerController 弹出
    3. 点击"取消" -- > 1.UIAlerController 弹出
 *
 */
- (IBAction)quitAction:(UIButton *)sender {
    
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否退出公司" message:@"请慎重考虑" preferredStyle:UIAlertControllerStyleActionSheet];
    

    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 2. 点击“确认” --> 1."退出按钮"隐藏 2.滑动视图隐藏 3."加入公司按钮"显示 4.UIAlerController 弹出
        [UIView animateWithDuration:0.25 animations:^{
            //网络请求退出公司
            [self quitComapanyRequest];
            
        }];
       
        [alertC dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
      
        [alertC dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alertC addAction:sureAction];
    [alertC addAction:continueAction];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];



}


#pragma mark -网络请求
//退出公司
-(void)quitComapanyRequest{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
     OrganizedMember *member =[CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];
    OrganizedClientMessage *message;
    @try {
        message = [OrganizedClientMessage getInstanceOfUserQuitCompanyRequest:member.m_szUserAccount];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
         OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            _quitBtn.hidden =YES;
            _addCompanyBtn.hidden =NO;
            _scrollView.hidden = YES;
        }
        
        
    }];
    
    
}
/**
 *  加入公司按钮
 *  点击"加入公司按钮" --> 1.弹出 一个验证界面 且签订代理
 *
 */
- (IBAction)addCompanyBtn:(UIButton *)sender {
    WQAddCompanyController *addVC = [[UIStoryboard storyboardWithName:@"WQAddCompanyController" bundle:nil] instantiateInitialViewController];
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}



#pragma mark - 验证界面代理方法
 //验证成功 1."加入公司按钮"隐藏  2.“退出公司”按钮显示  3."滑动视图显示"
-(void)addCompanySucess{
    
    self.quitBtn.hidden = NO;
    self.companyScrollView.hidden = NO;
    self.addCompanyBtn.hidden = YES;
    [self showCompanyInformation];

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
