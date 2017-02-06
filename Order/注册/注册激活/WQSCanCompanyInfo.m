//
//  WQSCanCompanyInfo.m
//  Order
//
//  Created by wang on 2016/11/9.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQSCanCompanyInfo.h"
#import "DateCompent.h"
@interface WQSCanCompanyInfo ()
@property (weak, nonatomic) IBOutlet UITextField *companyNameTF;
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *mobilebtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *varCodeTF;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation WQSCanCompanyInfo

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _BGView.hidden = YES;
}

//验证公司名称
- (IBAction)sureBtn:(UIButton *)sender {
    [self checkCompanyName];
}
//获取验证码
- (IBAction)getVarCode:(UIButton *)sender {
    [self oldEmailValidation];
}

//验证验证码
- (IBAction)checkVerification:(UIButton *)sender {
    [self checkvarCode];
}


-(void)checkCompanyName{
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    // 加密
    NSDictionary *muDic;
    @try {
        OrganizedClientMessage *message = [OrganizedClientMessage getInstanceOfCompanyGetInfoRequest:_companyNameTF.text bIsUserLogin:false COMPANy_STAT_ID:@[@"Email",@"Mobile",@"Validcontact"]];
        NSString *messageStr = [message toString];
        muDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    } @catch (NSException *exception) {
        return;
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            NSDictionary *userInfoStat = [oM getCompanyInfoStat];
            _BGView.hidden = NO;
            if ([userInfoStat[@"Validcontact"] isEqualToString:@"CONTACT_EMAIL"] ||[userInfoStat[@"ValidContact"] isEqualToString:@"CONTACT_BOTH"]) {
                
                _emailBtn.selected = YES;
                [[NSUserDefaults standardUserDefaults] setObject:userInfoStat[@"Email"] forKey:WuserForgetPassWordEmial];
                
                
                _numberLabel.text =[NSString stringWithFormat:@"邮箱:%@",userInfoStat[@"Email"]];
            }else if ([userInfoStat[@"Validcontact"] isEqualToString:@"CONTACT_MOBILE"]){
                _mobilebtn.selected = YES;
                [[NSUserDefaults standardUserDefaults] setObject:userInfoStat[@"Mobile"] forKey:WuserForgetPassWordMobile];
                _numberLabel.text =[NSString stringWithFormat:@"电话:%@",userInfoStat[@"Mobile"]];
                
                
            }else{
                
                _BGView.hidden = YES;
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
    NSString *calendarToDateTimeString = [DateCompent getCurrentCalendar];
    
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


-(void)checkvarCode{
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    // 加密
    NSDictionary *muDic;
    @try {
        OrganizedClientMessage *message = [OrganizedClientMessage getInstanceOfCompanyGetInfoRequest:_companyNameTF.text bIsUserLogin:false COMPANy_STAT_ID:@[@"Activationcode"]];
        NSString *messageStr = [message toString];
        muDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios",KEY_EMAILVARCODE:_varCodeTF.text};
    } @catch (NSException *exception) {
        return;
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:muDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        NSMutableString *mustr = [NSMutableString string];
        if (oM) {
            NSArray *arra = [oM getActivatonCodePair];
             [[NSUserDefaults standardUserDefaults] setObject:arra forKey:WOrganizedActivatonCode];
            for (NSString  *var in arra) {
                [mustr appendString:var];
                [mustr appendString:@"/r/n"];
            }
            _textField.text = mustr;
        }
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
