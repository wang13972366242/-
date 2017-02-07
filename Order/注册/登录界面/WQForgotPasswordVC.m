//
//  WQForgotPasswordVC.m
//  Order
//
//  Created by wang on 2016/11/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQForgotPasswordVC.h"

@interface WQForgotPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;

@property (weak, nonatomic) IBOutlet UIButton *mobileBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@property (weak, nonatomic) IBOutlet UIView *BGview;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *varcodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTwo;

@end

@implementation WQForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _BGview.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  验证码用户名
 */
- (IBAction)verityUserNameAction:(UIButton *)sender {
    [self quitComapanyRequest];
}



/**
 *  获取验证码
 *
 */
- (IBAction)varCodeAction:(UIButton *)sender {
    [self oldEmailValidation];
}

/**
 *  确认
 *
 
 */
- (IBAction)sureChangePass:(UIButton *)sender {
    
    if (_passWordTF.text.length >6&& [_passWordTF.text isEqualToString: _passWordTwo.text ] && _varcodeTF.text.length >3) {
 [self sureChangePassWord];
    }
 
}


-(void)sureChangePassWord{
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    // 获取当前的时间
    
    
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:WuserAccount];
     NSString *validContact = [[NSUserDefaults standardUserDefaults] objectForKey:WValidContact];
    
    // 加密
    NSDictionary *muDic;
    NSString *messageStr;
    @try {
       OrganizedClientMessage *message = [OrganizedClientMessage  getInstanceOfUserSetInfoRequestSign:account tyepe:Password szStatValue:_passWordTF.text];
        messageStr = [message toString];
        
        
    } @catch (NSException *exception) {
        return;
    }
    if (_emailBtn.selected == YES) {
        muDic =@{KEY_REQUEST :messageStr,KEY_REQUESTFROM:@"IOS",KEY_MOBILEVARCODE:_varcodeTF.text};
        
    }else if (_mobileBtn.selected == YES){
     muDic =@{KEY_REQUEST :messageStr,KEY_REQUESTFROM:@"IOS",KEY_EMAILVARCODE:_varcodeTF.text};
    
    }
 
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            [self alertControllerShowWithTheme:@"修改成功" suretitle:@"确认"];
        }
        
        
    }];
    
    
}



#pragma -mark 用户忘记密码第一步
-(void)quitComapanyRequest{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    OrganizedClientMessage *message;
    @try {
        message = [OrganizedClientMessage getInstanceOfUserGetInfoRequest:_accountTF.text userEnumArr:@[@"Email",@"Mobile",@"ValidContact"]];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            NSDictionary * userInfoStat = [oM getUserInfoStat];
            if (userInfoStat != nil) {
                  [[NSUserDefaults standardUserDefaults] setObject:userInfoStat[@"UniqueAccount"] forKey:WuserAccount];
                 [[NSUserDefaults standardUserDefaults] setObject:userInfoStat[@"UniqueAccount"] forKey:WValidContact];
                _BGview.hidden = NO;
                if ([userInfoStat[@"ValidContact"] isEqualToString:@"CONTACT_EMAIL"] ||[userInfoStat[@"ValidContact"] isEqualToString:@"CONTACT_BOTH"]) {
                    
                    _emailBtn.selected = YES;
                    [[NSUserDefaults standardUserDefaults] setObject:userInfoStat[@"Email"] forKey:WuserForgetPassWordEmial];
                    
                  
                    _numberLabel.text =[NSString stringWithFormat:@"邮箱:%@",userInfoStat[@"Email"]];
                }else if ([userInfoStat[@"ValidContact"] isEqualToString:@"CONTACT_MOBILE"]){
                    _mobileBtn.selected = YES;
                 [[NSUserDefaults standardUserDefaults] setObject:userInfoStat[@"Mobile"] forKey:WuserForgetPassWordMobile];
                     _numberLabel.text =[NSString stringWithFormat:@"电话:%@",userInfoStat[@"Mobile"]];
                
                
                }else{
                
                    _BGview.hidden = YES;
                }
                
            }
        }
        
        
    }];
    
    
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
    
    NSString *emial = [[NSUserDefaults standardUserDefaults] objectForKey:WuserForgetPassWordEmial];
    // 加密
    NSDictionary *muDic;
    @try {
        NSString *aesEncrypt = [SecurityUtil encryptAESDataToBase64AndKey:emial key:calendarToDateTimeString];
        muDic = @{KEY_EMAILACCOUNT:aesEncrypt,KEY_TIMESTAMP:calendarToDateTimeString,KEY_REQUESTFROM:@"IOS",KEY_CHECKIDENTITY:@"1"};
        
    } @catch (NSException *exception) {
        return;
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        
        
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
