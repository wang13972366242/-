//
//  WQAddCompanyController.m
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAddCompanyController.h"
#import "OrganizedClientMessage.h"
#import "WQAddCompany.h"
@interface WQAddCompanyController ()
/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *activationTF;

@property (weak, nonatomic) IBOutlet UILabel *whyLabel;
@end

@implementation WQAddCompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  确认按钮
 *  点击"确认按钮"--> 1.判断激活码是否存在切是某个公司的
 *                      (1)如果验证成功  1.退出当前控制器 2.上一个控制 显示对应公司的界面信息
                        (2)如果验证失败   1.输出原因 
 */
- (IBAction)sureBtn:(UIButton *)sender {
    
    [self enterActivationCode];
    
    
}

-(void)enterActivationCode{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    NSString *messageStr;
        OrganizedClientMessage *messageCheck =  [OrganizedClientMessage getInstanceOfUserCheckActivationCodeRequest:_activationTF.text];
        messageStr = [messageCheck toString];
    NSDictionary *checkDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:checkDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *message;
        @try {
            message  =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        } @catch (NSException *exception) {
            _whyLabel.text = @"获取信息失败";
        }
        
        if (message != nil) {
            NSString *ACTVarCode = headerDic[@"ACTVarCode"];
            [[NSUserDefaults standardUserDefaults] setObject:ACTVarCode forKey:kUserDefaultsACTVarCode];
            ///1.获取公司uniqueID
            NSString *unque = [message getCompanyInfoStatString:uniqueID];
            [[NSUserDefaults standardUserDefaults] setObject:unque forKey:kUserDefaultsUnique];
            
            //2.
                //获取公司基本信息
                
            OrganizedCompany *CompanyInfo =  [message getClientCompanyObject];
            UserCompanyBase *companyBase =  [message getCompanyBaseObject];
            [CommonFunctions functionArchverCustomClass:CompanyInfo fileName:WOrganizedCompany];
            [CommonFunctions functionArchverCustomClass:companyBase fileName:WOrganizedCompanyBase];
            WQAddCompany *addCompany = [[WQAddCompany alloc]init];
            [self.navigationController pushViewController:addCompany animated:YES];
            
            
        }else{
        
        _whyLabel.text = @"激活码错误";
        
        }
        
    }];
    
    
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
