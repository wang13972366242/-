//
//  Registration-ActivationController.m
//  SignModel
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "Registration-ActivationController.h"
#import "WQRegisPersonController.h"
#import "WQRegisCompanyController.h"
#import "WQSCanCompanyInfo.h"
@interface Registration_ActivationController ()
/**
 *  错误的原因
 */
@property (weak, nonatomic) IBOutlet UILabel *errorWhy;
/**
 *  激活码
 */
@property (weak, nonatomic) IBOutlet UITextField *resignTF;


@end

@implementation Registration_ActivationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  在没有登录的情况下公司信息查询
 *
 *  
 */
- (IBAction)queryCompany:(UIButton *)sender {
    WQSCanCompanyInfo *sCompany = [[UIStoryboard storyboardWithName:@"WQSCanCompanyInfo" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:sCompany animated:YES];
}


/**
 *  点击“购买激活码”，实现方法
 */
- (IBAction)buySignCodeBtn:(UIButton *)sender {
    
}


#pragma -mark 点击确认
/**
 *  点击“确认”，调用
 */

- (IBAction)confirmBtn:(UIButton *)sender {
    if (_resignTF.text.length >10) {
       [self enterActivationCode];
    }else{
    _errorWhy.text = @"输入激活码";
    
    }
    

   
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
     NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:WOrganizedActivatonCode];
    if (arr.count >0) {
        _resignTF.text = arr[0];
    }
    
    
}
/**
 * 点击“什么是激活码”按钮，调用方法
 */
- (IBAction)activationCode:(UIButton *)sender {
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)enterActivationCode{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    NSString *messageStr;
    if ([self.title isEqualToString:@"公司激活"]) {
         OrganizedClientMessage *messageCheck =  [OrganizedClientMessage getInstanceOfCompanyCheckActivationCodeRequest:_resignTF.text];
        messageStr = [messageCheck toString];
    }else{
     
        OrganizedClientMessage *messageCheck =  [OrganizedClientMessage getInstanceOfUserCheckActivationCodeRequest:_resignTF.text];
        messageStr = [messageCheck toString];
    
    }
   
    
    NSDictionary *checkDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:checkDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        NSString *ACTVarCode = headerDic[@"ACTVarCode"];
        [[NSUserDefaults standardUserDefaults] setObject:ACTVarCode forKey:kUserDefaultsACTVarCode];
        
        OrganizedClientMessage *message;
        @try {
           message  =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        } @catch (NSException *exception) {
            _errorWhy.text = @"获取信息失败";
        }
        
        UserCompanyBase *companyBase;
        OrganizedCompany *messageUser;
        if (message != nil) {
            
            ///1.获取公司uniqueID
            NSString *unque = [message getCompanyInfoStatString:uniqueID];
            [[NSUserDefaults standardUserDefaults] setObject:unque forKey:kUserDefaultsUnique];
            
            companyBase =  [message getCompanyBaseVercityObject];
            
            if (companyBase != nil ) {
                
                [CommonFunctions functionArchverCustomClass:companyBase fileName:WOrganizedCompanyBase];
            }
            //2.
            if ([self.title isEqualToString:@"公司激活"]) {
            //获取公司基本信息
       
     
            }else{
        messageUser = [message getClientCompanyObject];
            if (messageUser != nil) {
        [CommonFunctions functionArchverCustomClass:messageUser fileName:WOrganizedCompany];
            }
    
            
            }
            
        if (companyBase != nil &&messageUser != nil) {
        [self performSegueWithIdentifier:@"company" sender:nil];
            
        }else if (messageUser != nil){
         [self performSegueWithIdentifier:@"person" sender:nil];
            
        }else{
            _errorWhy.text =  @"激活失败";
            return ;
        }
            
        }else{
            _errorWhy.text =  @"请先激活公司";
            return ;
        }
        
    }];
    
    
}

@end
