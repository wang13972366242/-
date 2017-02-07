 //
//  WQActivationCodeVC.m
//  Order
//
//  Created by wang on 16/8/4.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//


/**
 *
 *
 */

#import "WQActivationCodeVC.h"
#import "WQActibationCodeCell.h"
#import "NSString+NSString__RegualrVierty.h"
#import "OrganizedCompany.h"
#import "WQActivationModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrganizedClientMessage.h"
#import "CompanyFunction.h"



#import "WQManagerController.h"

typedef enum VerifyWay{
    mobilWay,
    emailWay,
}VerifyWay;
@interface WQActivationCodeVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  公司名称
 */
@property (weak, nonatomic) IBOutlet UITextField *companyNameTF;
/**
 *  手机号码
 */
@property (weak, nonatomic) IBOutlet UITextField *iphoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *verityCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *emailVerityCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *personNumberTF;
@property (weak, nonatomic) IBOutlet UIView *BasicView;
/** 公司*/
@property(nonatomic,strong) OrganizedCompany *userCompany;
/** tableview*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property(nonatomic,strong) UITableView *tableView;
/** 确认按钮*/
@property(nonatomic,strong) UIButton *sureBtn;
/** 价格label*/
@property(nonatomic,strong) UILabel *priceLabel;
/**
 *  整个单元格分三组  第一u
 */
/** 第一个数组*/
@property(nonatomic,strong) NSMutableArray *firstArr;
@property(nonatomic,strong) NSMutableArray *secondArr;
@property(nonatomic,strong) NSMutableArray *thirdArr;
@property (weak, nonatomic) IBOutlet UIButton *verityCodeImage;


@property (weak, nonatomic) IBOutlet UITextField *imageCodeTF;
/**
 * 手机获取验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *iphoneBtn;
/**
 * 邮箱获取验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@end

@implementation WQActivationCodeVC

-(NSMutableArray *)firstArr{
    if (_firstArr == nil) {
        _firstArr = [NSMutableArray array];
    }
    return _firstArr;
}
-(NSMutableArray *)secondArr{
    if (_secondArr == nil) {
        _secondArr =[NSMutableArray array];
    }
    return _secondArr;
}
-(NSMutableArray *)thirdArr{
    if (_thirdArr == nil) {
        _thirdArr =[NSMutableArray array];
    }
    return _thirdArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加数据
    [self addDtaasource];
    //配置子视图
    [self configurtionTabelV];
    //设置滑动视图的高度
    _scrollViewHeight.constant = 64  + (_firstArr.count +_secondArr.count +_thirdArr.count) *60+390;

    [self _loadVerityPicture];
    
    
    
}
- (IBAction)verity:(UIButton *)sender {
    [self _loadVerityPicture];
    
}
//添加数据
-(void)addDtaasource{
    NSArray *arr1  = @[@{@"titleStr":@"7天套餐"},@{@"titleStr":@"月套餐"},@{@"titleStr":@"半年套餐"},@{@"titleStr":@"年套餐"}];
    [self toArrayAddModelWithFixedArr:arr1 AddArr:self.firstArr];
   
    NSArray *arr2 = @[@{@"titleStr":@"考勤管理"},@{@"titleStr":@"物品管理"},@{@"titleStr":@"工作报告"},@{@"titleStr":@"工作绩效考评"},@{@"titleStr":@"用户管理单"},@{@"titleStr":@"工作任务管理"}];
    [self toArrayAddModelWithFixedArr:arr2 AddArr:self.secondArr];
    NSArray *arr3 = @[@{@"titleStr":@"我同意《用户协议》"}];
    [self toArrayAddModelWithFixedArr:arr3 AddArr:self.thirdArr];
    
}

-(void)toArrayAddModelWithFixedArr:(NSArray *)arr AddArr:(NSMutableArray *)addArr{
    
    for (NSDictionary *dic in arr) {
        WQActivationModel *model = [[WQActivationModel alloc]initWithDic:dic];
        [addArr addObject:model];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


//发起支付
//-(void)treasurePay
//{
//    /*
//     *点击获取prodcut实例并初始化订单信息
//     */
//    Product *product = [[Product alloc] init];
//    //将服务器的订单价格赋值
//    product.price = 0.01;//价格
//    product.subject = @"商品标题";//标题
//    product.body = @"商品描述";//描述
//    //product.orderId = self.orderID;
//    //NSLog(@"product.orderId=%@",product.orderId);
//    /*
//     *商户的唯一的parnter和seller。
//     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
//     */
//    /*============================================================================*/
//    /*=======================需要填写商户app申请的===================================*/
//    /*============================================================================*/
//
//    //合作伙伴
//    NSString *partner = @"";
//    //卖方
//    NSString *seller = @"";
//    //私钥
//    NSString *privateKey = @"";
//
//    NSLog(@"私钥的长度:%lu",(unsigned long)privateKey.length);
//
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//
//    //partner和seller获取失败,提示
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少partner或者seller或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = @"20160516103651666666"; //订单ID（由商家自行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
//    order.notifyURL =  @"www.baidu.com"; //回调URL
//
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"zfb2016428";
//
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];

//
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"页面返回的结果 = %@",resultDic);
//            //判断
//            NSString * resultStatus = resultDic[@"resultStatus"];
//            NSLog(@"状态码:%@",resultStatus);
//            if ([resultStatus isEqualToString:@"9000"])//成功
//            {//跳转成功页面
//
//            }else if ([resultStatus isEqualToString:@"6001"])
//            {
//                <span style="font-family: Arial, Helvetica, sans-serif;">              //用户取消</span>
//            }
//
//        }];
//    }
//
//}

//配置tableview
-(void)configurtionTabelV{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 280 , KScreenWidth, (_firstArr.count +_secondArr.count +_thirdArr.count) *60 +120 ) style:UITableViewStylePlain];
    [_scrollView addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60.0;
    
    //创建确认按钮
    CGFloat  sureBtnW = 200;
    CGFloat  sureBtnX = (KScreenWidth - 200)/2.0;
    CGFloat  sureBtnY = self.tableView.bottom +15;
    
    _sureBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(sureBtnX, sureBtnY, sureBtnW, 30) title:@"确认购买" titleColor:[UIColor blackColor]];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(buyVerity:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sureBtn];
    
    
}
-(void)_loadVerityPicture{
    
    NSString * imageUrl =[NSString stringWithFormat:@"%@VerificationCode",baseUrl1];
        //2.创建请求工具对象
        BWNetWorkToll *newWorkTool = [BWNetWorkToll shareNetWorkToolWithoutBaseURL];
        //设置网络请求标识
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    newWorkTool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png",nil];
    newWorkTool.responseSerializer = [AFHTTPResponseSerializer serializer];
   
            //3.创建请求任务
    [newWorkTool POST:imageUrl parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:imageUrl]];
       NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:array];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kUserDefaultsCookie];
        
        UIImage *image = [UIImage imageWithData:responseObject];
         [_verityCodeImage setBackgroundImage:image forState:UIControlStateNormal];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Var");
        
    }];
    

}


/**
 *  电话验证
 */
- (IBAction)iphoneNumber:(UIButton *)sender {
    
    if (![CommonFunctions functionsIsMobile:_iphoneNumberTF.text]) {
        [self alertControllerShowWithTheme:@"手机格式错误" suretitle:@"确认"];
        return;
    }
    NSDictionary *dic = [OrganizedClientMessage IsBeingUsedcheckType:COMPANY_MOBILE pamar:_iphoneNumberTF.text uniqueID:nil];
    if (dic == nil) {
        [self alertControllerShowWithTheme:@"无效手机" suretitle:@"确认"];
    }else {
        [CommonFunctions functionsOpenCountdown:sender time:90];
        
          [BWNetWorkToll AFNetCheck:dic verWay:COMPANY_MOBILE viewController:self emialOrMobile:_iphoneNumberTF.text];
    }
}


/**
 *  邮箱验证
 */
- (IBAction)emailCodeBtn:(UIButton *)sender {
    //第一步校验数据
    
    if (![CommonFunctions functionsIsValidEmail:_emailTF.text]) {
        [self alertControllerShowWithTheme:@"邮箱格式错误" suretitle:@"确认"];
        return;
    }
    NSDictionary *dic = [OrganizedClientMessage IsBeingUsedcheckType:COMPANY_EMAIL pamar:_emailTF.text uniqueID:nil];
    if (dic == nil) {
        [self alertControllerShowWithTheme:@"无效邮箱" suretitle:@"确认"];
    }else {
        [CommonFunctions functionsOpenCountdown:sender time:90];
        [BWNetWorkToll AFNetCheck:dic verWay:COMPANY_EMAIL viewController:self emialOrMobile:_emailTF.text];
    }
    
    
}
#pragma -mark 确认购买
-(void)buyVerity:(UIButton *)sender{
//   [self alertControllerShow:@"是否激活" suretitle:@"确认" cancletitle:@"取消"];
 [self AFNetWorkingBuyVerity];
//    [self text];
    
}

-(void)text{
    
       NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    NSCalendar *cld = [NSCalendar currentCalendar];
    PurchaseIASD *purchase = [[PurchaseIASD alloc]initWithInternalOrder:@"20161026123" szOutOrder:@"20161026135" clrTime:cld fPrice:98 szOtherInfo:nil];
    OrganizedClientMessage *purchseMessage =  [OrganizedClientMessage getInstanceOfCompanyGenerateActivationCodeRequest:@"8c391993806565f08d79a98ee25c8088;" purchaseinfo:purchase];
    NSString  *purchaseStr = [purchseMessage toString];
    NSDictionary *purchaseDic = @{KEY_REQUEST:purchaseStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:purchaseDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        NSLog(@"%@",bodyStr);
        
    }];
}
#pragma mark -网络请求
//邮箱验证的网络请求
-(void)AFNetCheck:(NSDictionary *)mudic verWay:(CheckType)verWay{

    //设置网络请求工具
    BWNetWorkToll *newWorkTool = [BWNetWorkToll shareNetWorkToolWithoutBaseURL];
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@CheckUniqueStatOccupied",baseUrl1];
    //设置响应格式
    
    newWorkTool.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    //设置可接受的格式
    newWorkTool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    //设置参数
    
    //添加蒙版
    __block NSString *returnStr;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 2.0), ^{
        [newWorkTool POST:strUrl parameters:mudic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:strUrl]];
           NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:array];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (dict[kUserDefaultsCookie]) {
               [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kUserDefaultsCookie];
            }
           
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *dic = response.allHeaderFields;
            returnStr = dic[@"CheckType"];
            if ([returnStr isEqualToString:@"true"] ) {
                if (verWay==ACCOUNT_NAME  ) {
                    return;
                }
                [self AFNetWorkingCheckEmalAndMob:verWay];
                
                
            }else{
            
                if (verWay == COMPANY_EMAIL ) {
                
                [self alertControllerShowWithTheme:@"邮箱不可用" suretitle:@"确认"];
                }else if(verWay == COMPANY_MOBILE){
                
                  [self alertControllerShowWithTheme:@"手机不可用" suretitle:@"确认"];
                }else if (verWay == ACCOUNT_NAME){
                
                 [self alertControllerShowWithTheme:@"名称不可用" suretitle:@"确认"];
                
                }
                
            }
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
        
        
    });


}

//网络邮箱激活码
-(void)AFNetWorkingCheckEmalAndMob:(CheckType)verWay{

    //设置网络请求工具
    BWNetWorkToll *newWorkTool = [BWNetWorkToll shareNetWorkToolWithoutBaseURL];
    //url
    NSString * strUrl;
    NSDictionary*params;
    NSString *timeStr = [CommonFunctions calendarToDateString:[NSDate date]];
    //设置cookie到请求头
    NSDictionary *dic =[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    NSString *cookie = dic[kUserDefaultsCookie];
    [newWorkTool.requestSerializer setValue:cookie forHTTPHeaderField:kUserDefaultsCookie];
    //设置编码在请求头
    
    //设置参数
    if (verWay == COMPANY_EMAIL) {
    strUrl =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
        NSString *str = [SecurityUtil encryptAESDataToBase64AndKey:_emailTF.text key:timeStr];
        params = @{KEY_EMAILACCOUNT:str,KEY_REQUESTFROM:@"ios",KEY_TIMESTAMP:timeStr};
    }else{
    strUrl =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
    NSString *str = [SecurityUtil encryptAESDataToBase64AndKey:_iphoneNumberTF.text key:timeStr];
        params = @{KEY_MOBILENUMBER:str,KEY_REQUESTFROM:@"ios",KEY_TIMESTAMP:timeStr};
    }
    //设置响应格式
    
    newWorkTool.requestSerializer = [AFHTTPRequestSerializer serializer];
    newWorkTool.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置可接受的格式
    newWorkTool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",nil];
        //添加蒙版
    [UIApplication sharedApplication].
    networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 2.0), ^{
        [newWorkTool POST:strUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:strUrl]];
            NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:array];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (dict[kUserDefaultsCookie]) {
                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kUserDefaultsCookie];
            }
            
            [UIApplication sharedApplication].
            networkActivityIndicatorVisible = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            NSLog(@"%@",error);
            
        }];
        
        
    });
    
}


//网络请求购买激活码
-(void)AFNetWorkingBuyVerity{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];

    //设置参数
    NSDictionary *dataDic;
    @try {
        UserCompanyBase *user;
        if ([self isComapanyValid] ) {
         user=  [[UserCompanyBase alloc]initWithszName:_companyNameTF.text szMobile:_iphoneNumberTF.text szEmail:_emailTF.text validContact:CONTACT_EMAIL];
        }else{
            [self alertControllerShowWithTheme:@"完善公司基本信息" suretitle:@"确认"];
            return;
        }
        
        NSArray *arr = [self getfunctionArr];
        WQActivationModel *model = [self.thirdArr lastObject];
        if ( arr == nil  ) {
            return;
        }
        
        if (model.isSelected == NO) {
            [self alertControllerShowWithTheme:@"签订用户协议" suretitle:@"确认"];
            return;
        }
        
        int number = [_personNumberTF.text intValue];
        OrganizedClientMessage*oM = [OrganizedClientMessage getInstanceOfCompanyCreateRequestCompanyBase:user functionlists:arr iMaxMember:number];
        NSString *str = [oM toString];
        dataDic = @{KEY_REQUEST:str,KEY_REQUESTFROM:@"ios",
                    @"VarCode":_imageCodeTF.text,KEY_EMAILVARCODE:_emailVerityCodeTF.text};
    } @catch (NSException *exception) {
        [self alertControllerShowWithTheme:@"完善信息" suretitle:@"确认"];
    }
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *message;
        @try {
            message =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        } @catch (NSException *exception) {
            [self alertControllerShowWithTheme:@"注册失败" suretitle:@"确认"];
        }
       
        NSString *unque = [message getCompanyInfoStatString:uniqueID];
    
        if ( unque) {
            NSDate *cld = [NSDate date];
            PurchaseIASD *purchase = [[PurchaseIASD alloc]initWithInternalOrder:@"20161026123" szOutOrder:@"20161026135" clrTime:cld fPrice:98 szOtherInfo:nil];
            OrganizedClientMessage *purchseMessage =  [OrganizedClientMessage getInstanceOfCompanyGenerateActivationCodeRequest:unque purchaseinfo:purchase];
           NSString  *purchaseStr = [purchseMessage toString];
            NSDictionary *purchaseDic = @{KEY_REQUEST:purchaseStr,KEY_REQUESTFROM:@"IOS"};
             [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:purchaseDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
                 
                 OrganizedClientMessage *message;
                 @try {
                     message  =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
                 } @catch (NSException *exception) {
                     NSLog(@"%@",exception);
                 }
                 
                 if (message != nil) {
                NSArray *activationCode = [message getActivatonCodePair];
                [[NSUserDefaults standardUserDefaults] setObject:activationCode forKey:WOrganizedActivatonCode];
                     
                     [self alertControllerShow:@"是否激活" suretitle:@"确认" cancletitle:@"取消"];
                 
                 }
             }];
        }
       
    }];
   

    
}

#pragma -mark 界面和购买信息逻辑
//界面是否完整
-(BOOL)isComapanyValid{
    if ([CommonFunctions functionsIsValidEmail:_emailTF.text] && _companyNameTF.text.length>1 &&[CommonFunctions functionsIsNumber:_personNumberTF.text] && [CommonFunctions functionsIsMobile:_iphoneNumberTF.text]&&_companyNameTF.text.length >2 ) {
        return YES;
    }
    return NO;
}

//获取界面的功能
-(int)getComapnyTime{
    
    for (int i= 0;  i<self.firstArr.count;i++) {
        WQActivationModel *model = self.firstArr[i];
        if (model.isSelected == YES) {
            if (i ==0) {
                return 7;
            }else if (i==1){
                return 30;
            }else if (i==2){
                return 133;
            }else if (i==3){
                return 365;
            }
        }
    }
    return 0;
}

-(NSArray *)getComapnyFunctions{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i= 0;  i<self.secondArr.count;i++) {
        WQActivationModel *model = self.secondArr[i];
        if (model.isSelected == YES) {
            [arr addObject:@(i)];
        }
    }
    
    if (arr.count >0) {
       return arr;
    }
    return nil;
}

-(NSMutableArray *)getfunctionArr{
    NSArray *funArr = [self getComapnyFunctions];
    int time =[self getComapnyTime];
    NSMutableArray *arr = [NSMutableArray array];
    if (funArr &&time >0) {
        
        for (int i =0; i<funArr.count; i++) {
            int typeFunc = [funArr[i] intValue];
        CompanyFunction *cf = [[CompanyFunction alloc]initWithFunctionID:typeFunc daycount:time];
            [arr addObject:cf];
        }
         return arr;
    }else{
        [self alertControllerShowWithTheme:@"填写功能" suretitle:@"确认"];
        return nil;
    }
    return nil;

}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

-(void)verifyCompanyBaseInfo{
    
}

static NSString *actibationCodeCell= @"actibationCodeCell";


#pragma mark ---UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _firstArr.count;
    }else if (section == 1){
        return _secondArr.count;
    }else{
        return _thirdArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WQActibationCodeCell *cell = [[WQActibationCodeCell alloc]init];
    if (cell == nil) {
        cell =  [cell actibationCodeCell:tableView WithIdentifier:actibationCodeCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WQActivationModel *model;
    if (indexPath.section == 0) {
        model = _firstArr[indexPath.row];
        cell.contentLabel.text = model.titleStr;
    }else if (indexPath.section == 1){
        model = _secondArr[indexPath.row];
        cell.contentLabel.text = model.titleStr;
    }else{
        model = _thirdArr[indexPath.row];
        cell.contentLabel.text = model.titleStr;
    }
    if (model.isSelected == YES) {
        [cell.selsectBtn setImage:[UIImage imageNamed:@"TableCellSelected"] forState:UIControlStateNormal];
    }else{
        [cell.selsectBtn setImage:[UIImage imageNamed:@"TableCellDisable"] forState:UIControlStateNormal];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    UILabel *label = [self creatLabelWithFrame:CGRectMake(10, 0, KScreenWidth - 60, 30.0) textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15.0f] textColor:[UIColor orangeColor] text:nil];
    
    [view addSubview:label];
    if (section == 0) {
        label.text = @"使用时间";
    }else if (section == 1){
        label.text = @"请选择功能";
    }else{
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"价格:100";
        _priceLabel = label;
    }
    return view;
    
}

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     逻辑: 第0组 只能选择一个  选择一个其他取消选择
     第1周可以选择多个
     第2组必须选
     */
    [self.view endEditing:YES];
    WQActibationCodeCell *cell= [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        [self selsectUserTime:cell indexPath:indexPath];
        //取消cell的选中状态
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }else if (indexPath.section == 1){
        
        WQActivationModel *model = _secondArr[indexPath.row];
        model.isSelected = !model.isSelected;
    }else{
        WQActivationModel *model = _thirdArr[indexPath.row];
        model.isSelected = !model.isSelected;
        
    }
    [self.tableView reloadData];
}

-(void)selsectUserTime:(WQActibationCodeCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *indexPath0 = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:3 inSection:0];
    
    WQActivationModel *model0 = _firstArr[indexPath0.row];
    WQActivationModel *model1 = _firstArr[indexPath1.row];
    WQActivationModel *model2 = _firstArr[indexPath2.row];
    WQActivationModel *model3 = _firstArr[indexPath3.row];
    
    switch (indexPath.row) {
        case 0:
            model0.isSelected =YES;
            model1.isSelected =NO;
            model2.isSelected =NO;
            model3.isSelected =NO;
            
            break;
        case 1:
            model0.isSelected =NO;
            model1.isSelected =YES;
            model2.isSelected =NO;
            model3.isSelected =NO;
            
            break;
        case 2:
            model0.isSelected =NO;
            model1.isSelected =NO;
            model2.isSelected =YES;
            model3.isSelected =NO;
            
            break;
        case 3:
            model0.isSelected =NO;
            model1.isSelected =NO;
            model2.isSelected =NO;
            model3.isSelected =YES;
            
            break;
            
        default:
            break;
    }
    
    
}

#pragma -mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >7) {
        if (_emailTF == textField) {
            _emailBtn.enabled =YES;
        }else{
        
        _iphoneBtn.enabled =YES;
        }
    }else{
        if (_emailTF == textField) {
            _emailBtn.enabled =NO;
        }else{
            
            _iphoneBtn.enabled =NO;
        }
    
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //公司名称
    if (textField == _companyNameTF) {
        if (_companyNameTF.text.length <2) {
            [self alertControllerShowWithTheme:@"请填写公司名称" suretitle:@"确认"];
            return;
        }
        NSDictionary *dic = [OrganizedClientMessage IsBeingUsedcheckType:ACCOUNT_NAME pamar:_companyNameTF.text uniqueID:nil];
        if (dic == nil) {
            [self alertControllerShowWithTheme:@"无效公司名称" suretitle:@"确认"];
        }else {
            [self AFNetCheck:dic verWay:ACCOUNT_NAME];
        }
        
    }
    //手机
    if (textField== _iphoneNumberTF) {
        BOOL isTrue = [CommonFunctions functionsIsMobile:_iphoneNumberTF.text];
        if (isTrue == YES) {
        
            
        }else{
            [self alertControllerShowWithTheme:@"手机格式错误" suretitle:@"确认"];
        }
    }
    //邮箱
    if (textField== _emailTF) {
        BOOL isTrue = [CommonFunctions functionsIsValidEmail:_emailTF.text];
        if (isTrue == YES) {
            
            
        }else{
            [self alertControllerShowWithTheme:@"邮箱格式错误" suretitle:@"确认"];
        }
    }
    //人数
    if (textField == _personNumberTF) {
        if (_personNumberTF.text.length<1) {
             [self alertControllerShowWithTheme:@"请输入公司人数" suretitle:@"确认"];
        }
    }
    
    //手机验证码
    if (textField== _verityCodeTF) {
        if (_verityCodeTF.text.length >3) {
            
        }else{
            [self alertControllerShowWithTheme:@"请输入手机验证码" suretitle:@"确认"];
        }
    }
 
    //邮箱验证码
    if (textField== _emailVerityCodeTF) {
        if (_emailVerityCodeTF.text.length >3) {
            
        }else{
            [self alertControllerShowWithTheme:@"请输入邮箱验证码" suretitle:@"确认"];
        }
    }
    //图片验证码
    if (textField== _imageCodeTF) {
        if (_imageCodeTF.text.length ==4) {
            
        }else{
            [self alertControllerShowWithTheme:@"请输入图片验证码" suretitle:@"确认"];
        }
    }
    
}

-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.frame = frame;
    return  btn;
}



-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
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

-(void)alertControllerShow:(NSString *)themeTitle suretitle:(NSString *)suretitle cancletitle:(NSString *)cancletitle{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:themeTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancletitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertC addAction:sureAction];
    [alertC addAction:cancleAction];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
    
}

-(void)archverCustomClass:(id)object fileName:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@.data",fileName ];
    //获取路径
    NSString *cachePath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取文件全路径
    NSString *fielPath = [cachePath stringByAppendingPathComponent:str];
    //把自定义对象归档
    [NSKeyedArchiver archiveRootObject:object toFile:fielPath];
}
@end
