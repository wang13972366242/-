//
//  WQRegisCompanyController.m
//  Order
//
//  Created by wang on 16/6/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//
#import "OrganizedJobTitle.h"

#import "WQRegisCompanyController.h"
/**
 *  多地址
 */
#import "WQAddressView.h"
/**
 *  职位架构
 */
#import "PositionFrameVC.h"

//指定管理员
#import "WQmanagerVC.h"
@interface WQRegisCompanyController ()<AddressViewDelegate,PositionFrameVCDelagate>

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyMobieLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyPersonLabel;



//职位构架的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGViewHeight;
//背景视图
@property (weak, nonatomic) IBOutlet UIView *BGView;

/** 地址滑动视图*/
@property(nonatomic,strong) UIScrollView *scrollView;
/** 地址的数组*/
@property(nonatomic,strong) NSMutableArray *addressArr;

@property (weak, nonatomic) IBOutlet UILabel *PCompletedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ACompletedLabel;
/** PositionFrameVC.h*/
@property(nonatomic,strong) PositionFrameVC *PVc;
/** WQmanagerVC.h*/
@property(nonatomic,strong) WQmanagerVC *mvc;
/** addVNumer*/
@property(nonatomic,assign) int addVNumer;
@end

@implementation WQRegisCompanyController

-(NSMutableArray *)addressArr{
    if (_addressArr == nil) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司注册";
    _addVNumer = 0;
    // 创建地址
    [self _creatScrollView];
    [self creatSubAddresssView];
}

//视图出现的时候添加属性
-(void)viewWillAppear:(BOOL)animated{
    UserCompanyBase *companybase = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompanyBase];
    if (companybase != nil) {
        _companyNameLabel.text = [NSString stringWithFormat:@"名称:%@",companybase.m_szName];
        _companyEmailLabel.text = [NSString stringWithFormat:@"邮箱:%@",companybase.m_szEmail];
        _companyMobieLabel.text = [NSString stringWithFormat:@"电话:%@",companybase.m_szMobile];
    }
   
}


- (IBAction)sureBtn:(UIButton *)sender {
    [self enterActivationCode];
    
}
-(void)enterActivationCode{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    //1.取出UniqueID
    NSString *uniqueID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUnique];
    //2.取出ACTVarCode
    NSString *varcode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsACTVarCode];
    //3.消息
    OrganizedClientMessage *messageActiva;
    NSDictionary *checkDic;
    
    @try {
        //1.公司
        UserCompanyBase *companybase = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompanyBase];
        
        OrganizedCompany *company = [[OrganizedCompany alloc]initWithCompany:companybase];
        [company companyaddAddress:@"武汉汉口"];
        company.m_szStaticPhoneNumber = @"027-91269753";
        company.m_szCompanyType = @"金融";
        company.m_szCompanySummary = @"创业公司";
       JobTitleStructure *job=  [[JobTitleStructure alloc]init];
        
        [job addDepartment:@"销售部"];
        OrganizedJobTitle *job1 =  [[OrganizedJobTitle alloc]initWithNameAndLevel:@"总经理" iLevel:1];
        [job addRootJobTitle:job1];
        [job addDepartment:@"销售部1" szParentDepartment:@"销售部"];
    
        [job addJobTitle:@"经理1" iJobLevel:2 szDepartment:@"销售部1"];
     
      
        company.m_JobTitleStructure = job;
        
        //2.UserBean 
            DeviceUniqueID *DU =  [[DeviceUniqueID alloc]initWithIP:[CommonFunctions deviceIPAdress] szMac:[CommonFunctions getMacAddress] szOS:@"IOS" szHostName:[CommonFunctions functionsHostName]];
        UserBean *useb = [[UserBean alloc]initWithszUsername:@"wave22234" szPassword:@"123456789" objDeviceID:DU];
        //3.OrganizedMember
     OrganizedMember *om = [[OrganizedMember alloc]initWithAccount:@"wave22234" szMobile:@"13972328235" szEmail:@"2342772@qq.com" vldct:CONTACT_MOBILE];
        om.m_szRealName =@"陈1晨";
        om.m_szEmployeeNumber = @"12334";
        om.m_szDepartmentName = @"销售部11";
        om.m_szJobTitle = @"经理1";
        om.sex = FEMALE;
    
        om.m_szHomeAddress =@"德玛西亚1";
        om.m_szSummary = @"23442";
        om.m_szOfficeAddress = @"de2maixu";
        om.m_szLandLine = @"02765337843";
        
        messageActiva =  [OrganizedClientMessage getInstanceOfCompanyActivationRequest:uniqueID usercompany:company userAdmin:useb adminUser:om];
        NSString *messageStr = [messageActiva toString];
        
        checkDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS",KEY_ACTVARCODE:varcode,KEY_MOBILEVARCODE:@"461248"};
        
        
    } @catch (NSException *exception) {
        
    }
    
    //4.合成参数
   
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:checkDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
      
        NSLog(@"%@",bodyStr);
          
        
    }];
    
    
}

#pragma mark -  多地址
-(void)_creatScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 86, KScreenWidth, 30)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(KScreenWidth, 30 );
    [self.BGView addSubview:_scrollView];
    
}

-(void)addressViewCreatSelf:(WQAddressView *)addressView addBtn:(UIButton *)addBtn{
    addBtn.userInteractionEnabled = NO;
    [self creatAddresssView];
    
}


-(void)creatAddresssView{
    
     _addVNumer ++;
    _scrollView.contentSize = CGSizeMake(KScreenWidth, 30 *_addVNumer +30);
    
    if (_addVNumer < 3) {
      _scrollView.frame = CGRectMake(0, 86, KScreenWidth, 30 *_addVNumer + 30);
        
        [self creatSubAddresssView];
    
            self.BGViewHeight.constant = 217.0 +30 *_addVNumer;

    }else{
        
        [self creatSubAddresssView];
    }
    
   
}


-(void)creatSubAddresssView{
    
    WQAddressView *addV = [[WQAddressView alloc]initWithFrame:CGRectMake(0, _addVNumer *30, KScreenWidth, 30)];
    addV.delegate = self;
    [_scrollView addSubview:addV];
    [self.addressArr addObject:addV];
}

#pragma mark -职位和管理员
- (IBAction)creatPositionBtn:(UIButton *)sender {
 
    _PVc = [PositionFrameVC frameVC];
    
    _PVc.delagate = self;
    [self.navigationController pushViewController:_PVc animated:YES];
}

- (IBAction)administratorAction:(UIButton *)sender {
    _mvc = [[WQmanagerVC alloc]init];
    [self.navigationController pushViewController:_mvc animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"department"]) {
        PositionFrameVC *frameVC = (PositionFrameVC *)segue.destinationViewController;
        frameVC.delagate = self;
    }
    
}

-(void)completePositionViewPositionFrameVC:(PositionFrameVC *)positionFrameVC{

    _PCompletedLabel.hidden = NO;

}
-(id)unarchverCustomClassFileName:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@.data",fileName ];
    //获取路径
    NSString *cachePath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取文件全路径
    NSString *fielPath = [cachePath stringByAppendingPathComponent:str];
    //把自定义对象解档
    id object= [NSKeyedUnarchiver unarchiveObjectWithFile:fielPath];
    return object;
}

@end
