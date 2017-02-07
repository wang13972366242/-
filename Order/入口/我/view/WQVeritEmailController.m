//
//  WQVeritEmailController.m
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQVeritEmailController.h"
#import "OrganizedClientMessage.h"
@interface WQVeritEmailController ()
@property (weak, nonatomic) IBOutlet UILabel *oldEmial;

@property (weak, nonatomic) IBOutlet UITextField *oldVerityCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *NewEmialTF;
@property (weak, nonatomic) IBOutlet UITextField *NewCodeTF;
/** 个人消息*/
@property(nonatomic,strong) OrganizedMember *member;
@end

@implementation WQVeritEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邮箱修改";
    
    _member = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];
    
    _oldEmial.text = [NSString stringWithFormat:@"邮箱:%@",_member.m_szEmail];
}


#pragma -mark 网络请求
- (IBAction)oldAction:(UIButton *)sender {
    
    [self oldEmailValidation];
}




- (IBAction)newAction:(UIButton *)sender {
    //第一步校验数据
    
    if (![CommonFunctions functionsIsValidEmail:_NewEmialTF.text]) {
        [self alertControllerShowWithTheme:@"邮箱格式错误" suretitle:@"确认"];
        return;
    }
    NSDictionary *dic = [OrganizedClientMessage IsBeingUsedcheckType:COMPANY_EMAIL pamar:_NewEmialTF.text uniqueID:nil];
    if (dic == nil) {
        [self alertControllerShowWithTheme:@"无效邮箱" suretitle:@"确认"];
    }else {
        [CommonFunctions functionsOpenCountdown:sender time:90];
        [BWNetWorkToll AFNetCheck:dic verWay:COMPANY_EMAIL viewController:self emialOrMobile:_NewEmialTF.text];
    }
    
}



//确认激活码
- (IBAction)sureChangeEmial:(UIButton *)sender {
   
    [self verityEmailvarCode];

}


/**
 * 验证过的邮箱获取激活码
 *
 * @param context
 * @param email
 */
-(void)oldEmailValidation{
    NSString * strUrl =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
    // 获取当前的时间
    NSString *calendarToDateTimeString = [CommonFunctions calendarToDateTimeString:[NSDate date]];
    // 加密
    NSDictionary *muDic;
    @try {
        NSString *aesEncrypt = [SecurityUtil encryptAESDataToBase64AndKey:_member.m_szEmail key:calendarToDateTimeString];
        muDic = @{KEY_EMAILACCOUNT:aesEncrypt,KEY_TIMESTAMP:calendarToDateTimeString,KEY_REQUESTFROM:@"IOS",KEY_CHECKIDENTITY:@"1"};

    } @catch (NSException *exception) {
        return;
    }
 
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
    
        
    }];
    
    
}


/**
 * 邮箱认证获取 supervarcode
 * @param context
 * @param code
 */
-(void)verityEmailvarCode{

    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    OrganizedClientMessage *messsage;
    @try {
        messsage = [OrganizedClientMessage getInstanceOfUserGetSuperCodeRequest:_member.m_szUserAccount useEnum:email emialOrMboileNumber:_member.m_szEmail];
    } @catch (NSException *exception) {
        return;
    }
    NSString *messageStr = [messsage toString];
    NSDictionary *muDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS",KEY_EMAILVARCODE:_oldVerityCodeTF.text};
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        
        
        
        if (oM) {
            NSString *superVar = headerDic[@"SuperVarCode"];
//            [self changeEmailInfoRequest:superVar];
        }
        
        
        
    }];
    

}
        
        
#pragma mark -网络请求修改电话

-(void)changeEmailInfoRequest:(NSString*)superCode{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    //url
    
    
    OrganizedClientMessage *message;
    @try {
        message = [OrganizedClientMessage getInstanceOfUserSetInfoRequestSign:_member.m_szUserAccount tyepe:email szStatValue:_NewEmialTF.text];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios",KEY_MOBILEVARCODE:@"123454",KEY_SUPERVARCODE:superCode};
    
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
        
    }];
    
    
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

+(WQVeritEmailController *)shareStortyEmial{
    
    return  [[UIStoryboard storyboardWithName:@"WQVeritEmailController" bundle:nil] instantiateInitialViewController];
    
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
