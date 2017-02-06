//
//  WQChangePasswordVC.m
//  Order
//
//  Created by wang on 16/7/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQChangePasswordVC.h"
#import "OrganizedClientMessage.h"
@interface WQChangePasswordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTF;

@property (weak, nonatomic) IBOutlet UITextField *newpasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *surePassWord;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *equalWord;

/** 公司*/
@property(nonatomic,strong) OrganizedMember *member;
@end

@implementation WQChangePasswordVC


-(void)awakeFromNib{
    [super awakeFromNib];
    _errorLabel.hidden = YES;
    _limitLabel.hidden = YES;
    _errorLabel.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      _member = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];
}





/**
 *  确认按钮
 *  点击确认按钮 -->  1.判断 (1)旧密码是否正确  (2)新密码是否一致 且在限制的范围               如果正确  (1)返回 (2)新密码发送服务器
                       如果失败   (1) 会提示
 
 */

- (IBAction)sureAcrion:(UIButton *)sender {
    if (_oldPassWordTF.text.length >5 &&_newpasswordTF.text.length >6 &&[_newpasswordTF.text isEqualToString:_surePassWord.text]) {
        
    }
    [self changPassWordRequest];
}


#pragma mark -网络请求
//退出公司
-(void)changPassWordRequest{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    OrganizedClientMessage *message;
    @try {
        
        message = [OrganizedClientMessage getInstanceOfUserSetInfoRequestOldPassWord:_member.m_szUserAccount oldPassword:_oldPassWordTF.text szNewPassword:_newpasswordTF.text];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            UserBean *user =[CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMemberBase];
            user.m_szPassword = _newpasswordTF.text;
            [CommonFunctions functionArchverCustomClass:user fileName:WOrganizedMemberBase];
            [self alertControllerShowWithTheme:@"修改成功,返回登录界面" suretitle:@"确认"];
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
          
        }
        
        
    }];
    
    
}

-(void)delayMethod{
  [APPD goMain];

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
