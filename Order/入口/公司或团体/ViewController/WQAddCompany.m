//
//  WQAddCompany.m
//  Order
//
//  Created by wang on 2016/11/4.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAddCompany.h"
#import "WQAddCompanyVCell.h"
#import "SelectedDepartPosition.h"
#import "DateCompent.h"
#import "SexView.h"
@interface WQAddCompany ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SexViewDelegate,UITextViewDelegate,SelectedDepartPositionDelegate,UITextFieldDelegate>


/** tableview*/
@property(nonatomic,strong) UITableView *tableView;



/** userB*/
@property(nonatomic,strong) UserBean *userB;
/** member*/
@property(nonatomic,strong) OrganizedMember *member;

/** <#注释#>*/
@property(nonatomic,strong) OrganizedCompany *company;
/** */


/** 数组*/
@property(nonatomic,strong) NSMutableArray *labelArr;

/** 数组*/
@property(nonatomic,strong) NSArray *data;
/** 职位可以选取*/
@property(nonatomic,strong) SelectedDepartPosition *selcetPosition;
/** 部门可以选取*/
@property(nonatomic,strong) SelectedDepartPosition *selcetDepartment;
/** 性别*/
@property(nonatomic,strong) SexView *sexV;
/** 个人类*/
@property(nonatomic,strong) OrganizedMember *person;
@property (strong, nonatomic)UITextView *textView;

/** 临时的TextField*/
@property(nonatomic,strong) UITextField *tempTextF;
/** 临时的UITextView*/
@property(nonatomic,strong) UITextView *tempTextV;
/** 滑动视图*/
@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NSString *sexStr;
/** 密码*/
@property(nonatomic,strong) NSString *passWord;

@end

@implementation WQAddCompany

-(NSMutableArray *)labelArr{
    
    
    if (_labelArr == nil) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = @[@"用户名:",@"密码:",@"确认密码:",@"邮箱:",@"电话:",@"姓名:",@"座机:",@"性别:",@"部门:",@"职位:",@"工号:",@"家庭住址:",@"个人描述:"];
    //创建scrollview
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth, _data.count *50 +250)];
    _scrollView.contentSize = CGSizeMake(KScreenWidth, _data.count *50 +550);
    [self.view addSubview:_scrollView];
    //2.创建一个TableView
    [self configurtionTabelV];
    //3.创建一个按钮
    [self configurtionButton];
    
    [self getInfoCompanyAdddUser];
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}



-(void)getInfoCompanyAdddUser{
    
    _company =   [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedCompany];
    
    
     _userB = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMemberBase];
     _member = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];

}
#pragma mark -键盘通知
-(void)personKeyboardShow:(NSNotification *)notification{
    NSValue *rectValue = notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyBoardFrame = [rectValue CGRectValue];
    
    //   取得键盘的高度
    CGFloat height = keyBoardFrame.size.height ;
    if ([_tempTextF superview].frame.origin.y + height +40 >KScreenHeight -64||[_tempTextV superview].frame.origin.y + height +80 >KScreenHeight -64) {
        
        self.scrollView.transform = CGAffineTransformTranslate(self.scrollView.transform, 0, -height);
    }
    
}

-(void)personKeyboardHide:(NSNotification *)notification{
    
    self.scrollView.transform = CGAffineTransformIdentity;
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)configurtionTabelV{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, _data.count * 50 +80) style:UITableViewStylePlain];
    [_scrollView addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[WQAddCompanyVCell class] forCellReuseIdentifier:setCell];
    
}

-(void)configurtionButton{
    CGFloat btnW = 200.0;
    CGFloat btnX = (KScreenWidth - btnW) /2.0;
    CGFloat btnH = 30.0;
    CGFloat btnY = _tableView.height +10;
    
    UIButton *sureBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(btnX, btnY, btnW, btnH) title:@"确认" titleColor:[UIColor blackColor]];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:sureBtn];
}
static NSString *setCell= @"regiCell";


#pragma mark ---UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WQAddCompanyVCell *cell = [[WQAddCompanyVCell alloc]init];
    if (cell == nil) {
        cell =  [cell signPersonCell:tableView WithIdentifier:setCell initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titt = self.data[indexPath.row];
    
    
    //性别做出按钮
    if ([_data[indexPath.row] isEqualToString:@"性别:"]) {
        [cell.textF removeFromSuperview];
        [cell.label removeFromSuperview];
        if (_sexV == nil) {
            _sexV = [[SexView alloc] initWithFrame:CGRectMake(10, 5, 200, 40)];
            _sexV.delegate = self;
            [cell.contentView addSubview:_sexV];
        }else{
            [cell.contentView addSubview:_sexV];
            
        }
        [_sexV selectShouldClick:YES];
    }
    //描述做出可以选取
    if ([_data[indexPath.row] isEqualToString:@"个人描述:"]) {
        [cell.textF removeFromSuperview];
        if (_textView == nil) {
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(85, 5, KScreenWidth - cell.textLabel.width +5, 80)];
            [cell.contentView addSubview:_textView];
        }else{
            [cell.contentView addSubview:_textView];
            
        }
    }
    //职位做出可以选取
    if ([_data[indexPath.row] isEqualToString:@"职位:"]) {
        [cell.textF removeFromSuperview];
        [cell.label removeFromSuperview];
        if (_selcetPosition == nil) {
            _selcetPosition =  [[SelectedDepartPosition alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
            _selcetPosition.isDepartment = NO;
            _selcetPosition.delegate = self;
            [cell.contentView addSubview:_selcetPosition];
            _selcetPosition.label.text = @"职位:";
        }else{
            [cell.contentView addSubview:_selcetPosition];
            
        }
        
    }
    //部门做出可以选取
    if ([_data[indexPath.row] isEqualToString:@"部门:"]) {
        [cell.textF removeFromSuperview];
        [cell.label removeFromSuperview];
        if (_selcetDepartment == nil) {
            _selcetDepartment =  [[SelectedDepartPosition alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
            _selcetDepartment.isDepartment = YES;
            _selcetDepartment.delegate = self;
            [cell.contentView addSubview:_selcetDepartment];
            _selcetDepartment.label.text = @"部门:";
        }else{
            [cell.contentView addSubview:_selcetDepartment];
            
        }
    }
    cell.textF.tag = indexPath.row +1000;
    if (indexPath.row == 1 ||indexPath.row == 2) {
        cell.textF.secureTextEntry = YES;
    }
    cell.textF.delegate = self;
    [self.labelArr addObject:cell.textF];
    
    //赋值
    [self assiganLabel:cell.textF str:_data[indexPath.row]];
    return cell;
}

-(void)assiganLabel:(UITextField *)TF str:(NSString *)str{

    if (_member &&_company ) {
        
    
    if ([str isEqualToString:@"用户名:"]) {
        TF.text = _member.m_szUserAccount;
        
    }else if ([str isEqualToString:@"邮箱:"]){
        TF.text = _member.m_szEmail;

    }else if ([str isEqualToString:@"邮箱:"]){
        TF.text = _member.m_szEmail;
        
    }else if ([str isEqualToString:@"电话:"]){
        TF.text = _member.m_szMobile;
        
    }else if ([str isEqualToString:@"姓名:"]){
        TF.text = _member.m_szRealName;
        
    }else if ([str isEqualToString:@"座机:"]){
        TF.text = _company.m_szStaticPhoneNumber;
        
    }else if ([str isEqualToString:@"家庭住址:"]){
        TF.text = _member.m_szHomeAddress;
        
    }else if ([str isEqualToString:@"个人描述:"]){
        TF.text = _member.m_szSummary;
        
    }
        
        
    }

}


-(void)textFieldCell:(WQAddCompanyVCell *)cell placeholder:(NSString *)placeholder{
    cell.textF.placeholder = placeholder;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _data.count -1) {
        return 80.0;
    }else{
        return 40.0;
    }
    
}



//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark -赋值
-(void)sexViewBack:(SexView *)sexV sexStr:(NSString *)sex{
    _sexStr = sex;
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    _tempTextV = textView;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length >20 && textView.text.length < 200) {
        
    }else{
        [self alertControllerShowWithTheme:@"描述错误" suretitle:@"确定"];
        textView.text = nil;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _tempTextF = textField;
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _userB = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMemberBase];
    _member = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];
    
}
#pragma mark -确认
- (void)sureAction:(UIButton *)sender{
    
    
    [self memberActivationCode];
    
}


-(void)memberActivationCode{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    //1.取出UniqueID
    NSString *uniqueID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUnique];
    //2.取出ACTVarCode
    NSString *varcode = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsACTVarCode];
    //3.消息
    OrganizedClientMessage *messageActiva;
    NSDictionary *checkDic;
    //1.UserBean
    _data = @[@"用户名:",@"密码:",@"确认密码:",@"邮箱:",@"电话:",@"姓名:",@"座机:",@"性别:",@"部门:",@"职位:",@"工号:",@"家庭住址:",@"个人描述:"];
    //创建scrollview
    UserBean *useb1;
    UILabel *userNamelabel = _labelArr[0];
    UILabel *password1 = _labelArr[1];
    UILabel *password2 = _labelArr[2];
    UILabel *emil = _labelArr[3];
    UILabel *mobie = _labelArr[4];
    UILabel *realName = _labelArr[5];
    UILabel *staticnumber = _labelArr[6];
    UILabel *employeeNumber = _labelArr[10];
    UILabel *address = _labelArr[11];
    if (![password1.text isEqualToString:password2.text] ) {
        [self alertControllerShowWithTheme:@"两次密码不匹配" suretitle:@"确认"];
        return;
    }
    
    @try {
        //1.UserBean
        DeviceUniqueID *D =  [[DeviceUniqueID alloc]initWithIP:[CommonFunctions deviceIPAdress] szMac:[CommonFunctions getMacAddress] szOS:@"IOS" szHostName:[CommonFunctions functionsHostName]];
        useb1 = [[UserBean alloc]initWithszUsername:userNamelabel.text szPassword:password1.text objDeviceID:D];
    } @catch (NSException *exception) {
        [self alertControllerShowWithTheme:@"填写用户名或者密码" suretitle:@"确认"];
        return;
    }
    
    OrganizedMember *om;
    @try {
        
        //2.OrganizedMember
        om = [[OrganizedMember alloc]initWithAccount:userNamelabel.text szMobile:mobie.text szEmail:emil.text vldct:CONTACT_MOBILE];
        om.m_szRealName =realName.text;
        om.m_szEmployeeNumber = employeeNumber.text;
        om.m_szDepartmentName = @"客服";
        om.m_szJobTitle = @"客服3";
        
         om.sex = MALE;
        if ([_sexStr isEqualToString:@"男"]) {
            om.sex = MALE;
        }else if ([_sexStr isEqualToString:@"女"]){
            om.sex = FEMALE;
        }
        
        om.m_cldBirthday = [DateCompent getCurrentCalendar];
        om.m_szHomeAddress =address.text;
        om.m_szSummary = _textView.text;
        om.m_szLandLine =staticnumber.text;
        
        messageActiva = [OrganizedClientMessage getInstanceOfUserActivationRequest:uniqueID userBean:useb1 member:om];
        NSString *messageStr = [messageActiva toString];
        
        checkDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"IOS",KEY_ACTVARCODE:varcode};
        
    } @catch (NSException *exception) {
        [self alertControllerShowWithTheme:@"完善个人信息" suretitle:@"确认"];
        return;
    }
    
    //4.合成参数
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:checkDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        
        [CommonFunctions functionArchverCustomClass:om fileName:WOrganizedMember];
        [CommonFunctions functionArchverCustomClass:useb1 fileName:WOrganizedMemberBase];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addComapny" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }];
    
    
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

#pragma mark -UIAlertController
-(void)alertControllerShowWithTheme:(NSString *)themeTitle suretitle:(NSString *)suretitle{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:themeTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [alertC addAction:sureAction];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
    
}


#pragma mark -SelectedDepartPositionDelegate
-(void)selectDepartment:(NSString *)departmentName{
    
}
-(void)selectPosition:(NSString *)positionName{
    
    
    
    
}

-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    btn.frame = frame;
    return  btn;
}




@end
