//
//  WQVeritViewController.m
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQVeritViewController.h"

@interface WQVeritViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberBtn;
@property (weak, nonatomic) IBOutlet UITextField *oldCode;
@property (weak, nonatomic) IBOutlet UITextField *NewMobileTF;
@property (weak, nonatomic) IBOutlet UITextField *NewCodeTF;

/** 个人消息*/
@property(nonatomic,strong) OrganizedMember *member;
@end

@implementation WQVeritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _member = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];
    
    
}


/**
 *  确认
 *   点击确认-->  1.判断验证码是否成功 如果成功  -->（1）.跳转到原来的页面  （2）将新的手机号码传递过去 （3）提示错误消息不显示
     如果失败 --> (1)提示错误 (2)提示错误消息显示
 */

- (void)sureBtn:(UIButton *)sender {
    [self changeMobileInfoRequest];
    
}


- (IBAction)getOldCodeAction:(UIButton *)sender {
    
    
}

- (IBAction)getNewCodeAction:(UIButton *)sender {
    
}

- (IBAction)sureAction:(UIButton *)sender {
    
}


#pragma mark -网络请求修改电话

-(void)changeMobileInfoRequest{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    
    
    OrganizedClientMessage *message;
    @try {
        message = [OrganizedClientMessage getInstanceOfUserSetInfoRequestSign:_member.m_szUserAccount tyepe:mobile szStatValue:@"15716368723"];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios",KEY_MOBILEVARCODE:@"123454",KEY_SUPERVARCODE:@"1234"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
        
    }];
    
    
}


-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}

-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
   
    btn.frame = frame;
    return  btn;
}

+(WQVeritViewController *)shareStortyMobile{
 
    return  [[UIStoryboard storyboardWithName:@"WQVeritViewController" bundle:nil] instantiateInitialViewController];

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
