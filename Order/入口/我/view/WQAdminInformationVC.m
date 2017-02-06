//
//  WQAdminInformationVC.m
//  Order
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAdminInformationVC.h"
#import "SelectedView.h"
#import "UserOperationByGlobalAdmin.h"

@interface WQAdminInformationVC ()<SelectedViewDelegate>
/** label*/
@property(nonatomic,strong) UIButton *conditionsBtn;
@property(nonatomic,strong) UIButton *sureBtn;

/**  选择条件*/
@property(nonatomic,strong) SelectedView *firstSelected;
/** 查询的条件*/
@property(nonatomic,strong) NSArray *firstArr;
@property(nonatomic,strong) NSArray *secondArr;

/** text*/
@property(nonatomic,strong) UITextField *TF;
/** userBan*/
@property(nonatomic,strong) UserBean *userB;
@end

@implementation WQAdminInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询用户信息与修改";
    //配置子视图
    [self _configurationSubviews];
    
    [self _configurationDataSource];
    
     _userB = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMemberBase];
}

-(void)_configurationDataSource{
    _firstArr = @[@"名字",@"部门",@"职位",@"工号",@"电话",@"邮箱",@"功能管理员",@"公司管理员",@"公司地址"];
    _secondArr = @[@"职位",@"公司地址"];
}
//子视图 查询条件按钮 和button
-(void)_configurationSubviews{
    _conditionsBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(10, 70, KScreenWidth * 0.3, 30) titleColor:[UIColor blackColor] title:@"查询条件"];
    [_conditionsBtn addTarget:self action:@selector(conditionsOfTheQuery:) forControlEvents:UIControlEventTouchUpInside];
    [_conditionsBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
    [self.view addSubview:_conditionsBtn];
    
    _sureBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake((KScreenWidth- 20)/2, 200, KScreenWidth * 0.3, 30) titleColor:[UIColor blackColor] title:@"确认查询"];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
     [_sureBtn addTarget:self action:@selector(sureScanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
}

//查询条件
-(void)conditionsOfTheQuery:(UIButton *)sender{
    if (_firstSelected ==nil) {
    
    _firstSelected = [[SelectedView alloc]initWithFrame:CGRectMake(_conditionsBtn.left, _conditionsBtn.bottom, _conditionsBtn.width, _firstArr.count *30)];
    }
    _firstSelected.numberArr =_firstArr;
    _firstSelected.selectedDelegate = self;
    [self.view addSubview:_firstSelected];

}

//代理方法
- (void)clickCollection: (SelectedView *)selecetView didSelected: (NSString *)fieldText{
    [selecetView removeFromSuperview];
  
    [_conditionsBtn setTitle:fieldText forState:UIControlStateNormal];
    
}
#pragma -mark 确认查询
-(void)sureScanAction:(UIButton *)sender{
    [self clearFromCompany];

}


#pragma -mark 查询问题
-(void)adminQueryMethods{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
   
    
    OrganizedClientMessage *message;
    @try {
        
        AdminManagementOperation *instanceOfAdminQueryUserListOperation = [AdminManagementOperation getInstanceOfAdminQueryUserListOperation:_userB.m_szUsername dic:@{@"RealName":@"朱伟"}];
        message = [OrganizedClientMessage getInstanceOfAdminManagementOperationRequest:instanceOfAdminQueryUserListOperation];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            AdminManagementOperationResult *result =  [oM getAdminManagementOperationResultObject];
            NSDictionary *dic = [result getQueryMemberListResult];
            
        }
        
    }];
}


//查询用户详细信息
-(void)adminQueryUserDeatiledInformation{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    
    OrganizedClientMessage *message;
    @try {
        UserOperationByGlobalAdmin *userClientObjAdmin =  [UserOperationByGlobalAdmin getInstanceOfQueryUserClientInfoOperation:@"wang1224"];
        AdminManagementOperation *adminoperation = [AdminManagementOperation getInstanceOfAdminHandleUserOperation:_userB.m_szUsername userArr:@[userClientObjAdmin]];
        message = [OrganizedClientMessage getInstanceOfAdminManagementOperationRequest:adminoperation];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
            
        }
        
    }];
}




///修改多个用户信息
-(void)adminQueryMultipleUserInformation{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];

    
    OrganizedClientMessage *message;
    @try {
        UserOperationByGlobalAdmin *userClientObjAdmin =  [UserOperationByGlobalAdmin getInstanceOfChangeJobTitleOperation:@"wang1224" department:@"开发部" jobTitle:@"经理"];
         UserOperationByGlobalAdmin *userClientObjAdmin1 =  [UserOperationByGlobalAdmin getInstanceOfChangeJobTitleOperation:@"wang1224" department:@"开发部2" jobTitle:@"经理"];
        AdminManagementOperation *adminoperation = [AdminManagementOperation getInstanceOfAdminHandleUserOperation:_userB.m_szUsername userArr:@[userClientObjAdmin,userClientObjAdmin1]];
        
        message = [OrganizedClientMessage getInstanceOfAdminManagementOperationRequest:adminoperation];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
    }];
}


//提升用户为功能管理员
-(void)functionAdministrator{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    
    OrganizedClientMessage *message;
    @try {
        UserOperationByGlobalAdmin *userClientObjAdmin =  [UserOperationByGlobalAdmin getInstanceOfAssignFunctionAdminOperation:@"wang1224" functionID:FUNC_WORK_ATTENDENCE];
        
        AdminManagementOperation *adminoperation = [AdminManagementOperation getInstanceOfAdminHandleUserOperation:_userB.m_szUsername userArr:@[userClientObjAdmin]];
        
        message = [OrganizedClientMessage getInstanceOfAdminManagementOperationRequest:adminoperation];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
    }];
}



//提升为全局的管理员
-(void)companyAdministrator{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    
    OrganizedClientMessage *message;
    @try {
        UserOperationByGlobalAdmin *userClientObjAdmin =  [UserOperationByGlobalAdmin getInstanceOfAssignGlobalAdminOperation:@"wang1224"];
        
        AdminManagementOperation *adminoperation = [AdminManagementOperation getInstanceOfAdminHandleUserOperation:_userB.m_szUsername userArr:@[userClientObjAdmin]];
        
        message = [OrganizedClientMessage getInstanceOfAdminManagementOperationRequest:adminoperation];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
    }];
}



//请离公司的操作
-(void)clearFromCompany{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    
    OrganizedClientMessage *message;
    @try {
        UserOperationByGlobalAdmin *userClientObjAdmin =  [UserOperationByGlobalAdmin getInstanceOfMoveOutCompanyOperation:@"wang1224"];
        
        AdminManagementOperation *adminoperation = [AdminManagementOperation getInstanceOfAdminHandleUserOperation:_userB.m_szUsername userArr:@[userClientObjAdmin]];
        
        message = [OrganizedClientMessage getInstanceOfAdminManagementOperationRequest:adminoperation];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
    }];
}


-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame  titleColor:(UIColor *)titleColor  title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.frame = frame;
    return  btn;
}

@end
