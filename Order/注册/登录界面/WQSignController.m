//
//  WQSignController.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQSignController.h"
#import "NSString+NSString__RegualrVierty.h"
#import "OrganizedClientMessage.h"
#import "DateCompent.h"
#import "OrganizedJobTitle.h"

#import "WQForgotPasswordVC.h"


#import "PositionFrameVC.h"//职位框架



#import "DoubleSwipeRule.h"

@interface WQSignController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;

/**
 *  验证码图片
 */
@property (weak, nonatomic) IBOutlet UIButton *verityCodeImageV;

/**
 *  主题图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *loginImageV;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *useNameTF;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *verityTF;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;


@end

@implementation WQSignController

- (void)viewDidLoad {
    [super viewDidLoad];
   //加载验证图片
    [self _loadVerityPicture];
    
    NSArray *Arr = [NSArray arrayWithObject:@"7Z3Y6-CVegm-u6h8h-q3M3P"];
    //L3J6i-OPLsV-fvqt6-4vUf4
    [[NSUserDefaults standardUserDefaults] setObject:Arr forKey:WOrganizedActivatonCode];
    
}

-(void)_loadVerityPicture{
    
    NSString * imageUrl =[NSString stringWithFormat:@"%@VerificationCode",baseUrl1];
    
    //2.创建请求工具对象
    BWNetWorkToll *newWorkTool = [BWNetWorkToll shareNetWorkTool];
    
    
    //设置网络请求标识
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    __block NSDictionary *dict ;
    
    //3.创建请求任务
    newWorkTool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png",nil];
    newWorkTool.responseSerializer = [AFHTTPResponseSerializer serializer];
    [newWorkTool POST:imageUrl parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:imageUrl]];
        dict = [NSHTTPCookie requestHeaderFieldsWithCookies:array];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kUserDefaultsCookie];
        UIImage *image = [UIImage imageWithData:responseObject];
        [_verityCodeImageV setBackgroundImage:image forState:UIControlStateNormal];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"varcode");
    }];
    
    
    
    
    
}



//切换图片
- (IBAction)verityBtn:(UIButton *)sender {
    [self _loadVerityPicture];
    
    
}


#pragma mark -网络请求
//登录
-(void)loadLoginData{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    //参数
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
       UserBean *userB;
    @try {
        DeviceUniqueID *D =  [[DeviceUniqueID alloc]initWithIP:[CommonFunctions deviceIPAdress] szMac:[CommonFunctions getMacAddress] szOS:@"IOS" szHostName:[CommonFunctions functionsHostName]];
     
        if (_useNameTF.text.length >7 || _passWordTF.text.length>7) {
           userB = [[UserBean alloc]initWithszUsername:@"wang111" szPassword:@"123456789" objDeviceID:D];
        }
        
       
        OrganizedClientMessage*oM = [OrganizedClientMessage  clientMessageGetInstanceOfUserLoginRequest:userB hasVarCode:YES];
        NSString *str = [oM toString];
        
        [dataDic addEntriesFromDictionary:@{KEY_REQUEST:str}];
        [dataDic addEntriesFromDictionary:@{KEY_VARCODE:_verityTF.text}];
        [dataDic addEntriesFromDictionary:@{KEY_REQUESTFROM:@"ios"}];
        if (_verityTF.text.length != 4) {
            _errorLabel.text = @"请输入验证码";
            return;
        }
        
    } @catch (NSException *exception) {
        _errorLabel.text = @"用户名或密码错误";
        return;
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *message;
        @try {
            message =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        } @catch (NSException *exception) {
            _errorLabel.text = @"用户登录失败";
        }
       
        
        if (message != nil) {
            NSString *isAdmin = message.m_argmentsmap[@"ACTIVATIONCODE_ISADMINCODE"];
            if ([[message.m_argmentsmap allKeys] containsObject:@"USER_ENABLED_FUNC"]) {
                NSArray *functions = message.m_argmentsmap[@"USER_ENABLED_FUNC"];
                [[NSUserDefaults standardUserDefaults] setObject:functions forKey:Wfunctions];
            }
           
            if (isAdmin &&[isAdmin isEqualToString:@"true"]) {
              [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:WISADMINCODE];
            }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:WISADMINCODE];
            }
           //公司类
            OrganizedCompany *CompanyInfo =  [message getClientCompanyObject];
            UserCompanyBase *companybase =  [message getCompanyBaseObject];
            [CommonFunctions functionArchverCustomClass:CompanyInfo fileName:WOrganizedCompany];
            [CommonFunctions functionArchverCustomClass:companybase fileName:WOrganizedCompanyBase];
            //个人类
            OrganizedMember *memberInfo = [message getClientUserObject];
            
            [CommonFunctions functionArchverCustomClass:memberInfo fileName:WOrganizedMember];
            
            
            [CommonFunctions functionArchverCustomClass:userB fileName:WOrganizedMemberBase];
            
            
            //登录成功跳转
             [APPD goMain];
        }else{
        
        _errorLabel.text = @"用户名或密码错误";
        }
        
    }];
   

}


//登录
- (IBAction)signBtn:(UIButton *)sender {
    [self loadLoginData];
//    [self testJosn];

}

-(void)testJosn{
  
    DoubleSwipeRule *rule = [[DoubleSwipeRule alloc] initDoubleRuleWithTimeLimit:MAX hours:12.0];
   NSString *siStr = [rule toString];

}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES];

}

-(void)viewDidAppear:(BOOL)animated{


    [self.navigationController setNavigationBarHidden:NO];
}

//密码
- (IBAction)changPassWord:(UIButton *)sender {
    WQForgotPasswordVC *fgVC = [[UIStoryboard storyboardWithName:@"WQForgotPasswordVC" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:fgVC animated:YES];
    
}

//注册新用户
- (IBAction)signUser:(id)sender {
    
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
