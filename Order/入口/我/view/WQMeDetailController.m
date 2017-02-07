//
//  WQMeDetailController.m
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQMeDetailController.h"
#import "WQTMeChangeCell.h"
#import "SexView.h"
#import "OrganizedClientMessage.h"
@interface WQMeDetailController ()<UITableViewDelegate,UITableViewDataSource, WQTMeChangeCellDelegate>{
    CGFloat _cellH;
    
    BOOL _isVerif;
    UIView *_pickerSuperView;
}

/** 是否允许被编辑*/
@property(nonatomic,assign) BOOL allowEdit;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/** 第一组数据信息*/
@property(nonatomic,strong) NSMutableArray *messageOneArr;

@property(nonatomic,strong) NSMutableArray *messageOneConArr;


/** 第二组数据信息*/
@property(nonatomic,strong) NSMutableArray *messageTwoArr;

@property(nonatomic,strong) NSMutableArray *messageTwoConArr;
/** 头视图*/
@property(nonatomic,strong) UILabel *hearLabel;
/** 性别选择图片*/
@property(nonatomic,strong)SexView *sexV;
/** 性别图标*/
@property(nonatomic,strong) UIImageView *sexImageV;
//生日
/** label*/
@property(nonatomic,strong)  NSString *brithdayStr;
@property (weak, nonatomic) IBOutlet UIButton *changBtn;

/** 个人类*/
@property(nonatomic,strong) OrganizedMember *person;
@end

@implementation WQMeDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.title = @"详细信息";
    
    _person = [CommonFunctions functionUnarchverCustomClassFileName:WOrganizedMember];
    
   //配置tableview
    [self _configurationTableView];
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(meshowKeyBoard:) name:UIKeyboardWillShowNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mehidKeyBoard:) name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


-(NSMutableArray *)messageOneArr{
    
    if (_messageOneArr == nil) {
        _messageOneArr = [NSMutableArray arrayWithArray:@[@"姓名",@"职位",@"电话",@"邮箱",@"员工工号",@"生日",@"家庭住址",@"个人描述"]];
        _messageOneConArr = [NSMutableArray array];
        for (NSString *str in _messageOneArr) {
            [_messageOneConArr addObject:str];
        }
        
    }
    return _messageOneArr;
}



-(void)_configurationTableView{
    
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
     self.tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    
    //隐藏滑动条
     self.tableView.showsVerticalScrollIndicator = NO;
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView.rowHeight = 60;
    
    //注册
    [self.tableView registerClass:[WQTMeChangeCell class] forCellReuseIdentifier:managerChangeCell];
    
    
}

 static NSString *managerChangeCell= @"managerChangeCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return   self.messageOneArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WQTMeChangeCell *cell = [[WQTMeChangeCell alloc]init];
    [cell meChangeCell:tableView WithIdentifier:managerChangeCell initWithFrame:CGRectMake(0, 0, tableView.width, _cellH)];
    cell.delegate = self;
    cell.titleLabel.text = _messageOneArr[indexPath.row];
    [self assignmentWithTitle:_messageOneArr[indexPath.row] cell:cell];
    
    cell.allowEdit =  _allowEdit;
    if ( [_messageOneArr[indexPath.row] isEqualToString:@"生日"]||[_messageOneArr[indexPath.row] isEqualToString:@"家庭住址"]) {
    
    }else if ([_messageOneArr[indexPath.row] isEqualToString:@"姓名"]){
        
        if (_allowEdit == NO) {
            if (_sexImageV == nil) {
                _sexImageV = [[UIImageView alloc]initWithFrame:CGRectMake(cell.contentLabel.right+50 + 100, cell.titleLabel.origin.y + 20, 20, 20)];
                [cell.contentView addSubview:_sexImageV];
            
            }else{
            
            [cell.contentView addSubview:_sexImageV];
            }
            _sexImageV.image = [UIImage imageNamed:@"me_girlSex"];
        }else{
      
            if (_sexV == nil) {
                _sexV = [[SexView alloc]initWithFrame:CGRectMake(200, 10, 120, 30)];
                [cell.contentView addSubview:_sexV];
            }else{
                
                [cell.contentView  addSubview:_sexV];
            }
        }
        
    }else{
        
        
        
    }
    
    for (NSString *str in _messageOneArr) {
        
     
       
        
        if (_allowEdit == YES) {
            
            if (indexPath.row == 5 ) {
            if (_pickerSuperView == nil) {
            _pickerSuperView = [self configurePickView:indexPath];
            [cell.contentView addSubview:_pickerSuperView];
           
            }else{
            [cell.contentView addSubview:_pickerSuperView];
                
            }
                _pickerSuperView.hidden = NO;
                cell.contentLabel.text = _brithdayStr;
                cell.contentTextField.hidden = YES;
                
        }
        }else{
            _pickerSuperView.hidden = YES;
            
        }
    
    if ([str isEqualToString:@"电话"] ) {
       NSInteger row = [_messageOneArr indexOfObject:str];
     
        if (indexPath.row == row ||indexPath.row == row +1) {
            cell.verifBtn.hidden = NO;
            if (_person.m_validContact == CONTACT_NONE) {
                
            }
            cell.isVerif =  _isVerif;
        }else{
        
            cell.verifBtn.hidden = YES;
            
        }
  
    }
        
  
    }

    //验证码
    if (_person.m_validContact == CONTACT_BOTH) {
        cell.isVerif = YES;
    }else if (_person.m_validContact == CONTACT_MOBILE){
        if ( [cell.titleLabel.text isEqualToString:@"电话"]) {
            cell.isVerif = YES;
        }else{
        cell.isVerif = NO;
        }
     
    }else if (_person.m_validContact == CONTACT_EMAIL){
        if ( [cell.titleLabel.text isEqualToString:@"邮箱"]) {
            cell.isVerif = YES;
        }else{
            cell.isVerif = NO;

        
        }
    }else if (_person.m_validContact == CONTACT_NONE){
        cell.isVerif = NO;
    
    }
    
    if (_person.m_validContact == CONTACT_NONE) {
        _changBtn.enabled = NO;
    }else{
        _changBtn.enabled = YES;
    
    }
    
    cell.titleImg.image = [UIImage imageNamed:@"work_image_security_icon"];
     cell.bgImageV.image = [UIImage imageNamed:@"chat_btn_recording_h"];
    return cell;
}

//给个人内容赋值
-(void)assignmentWithTitle:(NSString *)title cell:(WQTMeChangeCell*)cell{
    if ([title isEqualToString:@"姓名"]) {
        cell.contentLabel.text = _person.m_szRealName;
    }else if ([title isEqualToString:@"职位"]) {
        cell.contentLabel.text = _person.m_szJobTitle;
    }else if ([title isEqualToString:@"电话"]) {
        cell.contentLabel.text = _person.m_szMobile;
    }else if ([title isEqualToString:@"邮箱"]) {
        cell.contentLabel.text = _person.m_szEmail;
    }else if ([title isEqualToString:@"员工工号"]) {
        cell.contentLabel.text = _person.m_szEmployeeNumber;
    }else if ([title isEqualToString:@"生日"]) {
        cell.contentLabel.text = (NSString *)_person.m_cldBirthday;
    }else if ([title isEqualToString:@"家庭住址"]) {
        cell.contentLabel.text = _person.m_szHomeAddress;
    }else if ([title isEqualToString:@"个人描述"]) {
        cell.contentLabel.text = _person.m_szSummary;
    }

    
    

}


#pragma -mark 尾视图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - WQTMeChangeCellDelegate
- (void)WQTMeChangeCell:(WQTMeChangeCell *)TMeChangeCell didEndEdit:(NSString *)fieldText
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:TMeChangeCell];
    
        [_messageOneConArr replaceObjectAtIndex:indexPath.row withObject:fieldText];
    [self.view endEditing:YES];
    
}


//邮箱验证的网络请求
//邮箱验证的网络请求
-(void)AFNetCheck:(NSDictionary *)mudic verWay:(CheckType)verWay{
    
    //设置网络请求工具
    BWNetWorkToll *newWorkTool = [BWNetWorkToll shareNetWorkToolWithoutBaseURL];
    //设置cookie到请求头
    NSDictionary *dic =[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    NSString *cookie = dic[@"Cookie"];
    [newWorkTool.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    //设置编码在请求头
    [newWorkTool.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
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
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *dic = response.allHeaderFields;
            returnStr = dic[@"CheckType"];
            if ([returnStr isEqualToString:@"true"] ) {
                if (verWay==ACCOUNT_NAME ||verWay ==EMPLOYEE_NUMBER) {
                    return;
                }
                [self AFNetWorkingCheckEmalAndMob:verWay];
                
                
            }else{
                
                if (verWay == USER_EMAIL ) {
                    
                    [self alertControllerShowWithTheme:@"邮箱不可用" suretitle:@"确认"];
                }else if(verWay == USER_MOBILE){
                    
                    [self alertControllerShowWithTheme:@"手机不可用" suretitle:@"确认"];
                }else if (verWay == ACCOUNT_NAME){
                    
                    [self alertControllerShowWithTheme:@"名称不可用" suretitle:@"确认"];
                    
                }else if (verWay ==EMPLOYEE_NUMBER){
                    [self alertControllerShowWithTheme:@"工号不可用" suretitle:@"确认"];
                    
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
    NSString *cookie = dic[@"Cookie"];
    [newWorkTool.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    //设置编码在请求头
    [newWorkTool.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    //设置参数
    if (verWay == USER_EMAIL) {
        strUrl =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
        UITextField *emilTF = (UITextField *)[self.view viewWithTag:1003];
        NSString *str = [SecurityUtil encryptAESDataToBase64AndKey:emilTF.text key:timeStr];
        params = @{KEY_EMAILACCOUNT:str,KEY_REQUESTFROM:@"ios",KEY_TIMESTAMP:timeStr};
    }else{
        strUrl =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
        UITextField *mobileTF = (UITextField *)[self.view viewWithTag:1004];
        NSString *str = [SecurityUtil encryptAESDataToBase64AndKey:mobileTF.text key:timeStr];
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
            
            [UIApplication sharedApplication].
            networkActivityIndicatorVisible = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            
        }];
        
        
    });
    
}

#pragma mark -网络请求修改电话

-(void)changeMobileInfoRequest{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
       NSString *varcodeStr = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsACTVarCode];
    
    OrganizedClientMessage *message;
    @try {
        message = [OrganizedClientMessage getInstanceOfUserSetInfoRequestSign:_person.m_szUserAccount tyepe:mobile szStatValue:@"15716368723"];
    } @catch (NSException *exception) {
        return;
    }

    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios",KEY_MOBILEVARCODE:@"123454",KEY_SUPERVARCODE:_person.m_szMobile};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
        
    }];
    
    
}

#pragma -mark 修改按钮
- (IBAction)changeInfo:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    _isVerif = !_isVerif;
    
    _allowEdit = !_allowEdit;
    if ( _allowEdit == NO) {
        
        _messageOneArr = [NSMutableArray arrayWithArray:@[@"姓名",@"职位",@"电话",@"邮箱",@"员工工号",@"生日",@"家庭住址",@"个人描述"]];
        
        //网络请求修改数据
       [self changeMobileInfoRequest];

    }else{
      _messageOneArr = [NSMutableArray arrayWithArray:@[@"姓名",@"职位",@"员工工号",@"电话",@"邮箱",@"生日",@"家庭住址",@"个人描述"]];
        
    }
    
    [_tableView reloadData];
    [_sexV selectShouldClick:sender.selected];
}



#pragma mark -网络请求修改信息
//退出公司
-(void)changeMemberInfoRequest{
    
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@OrganizedAppAdaptor",baseUrl1];
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    NSString *homeStr = [USER_STAT_ID getKeyNameForCompanyStatID:HomeAddress];
    [mudic addEntriesFromDictionary:@{homeStr:@"123443"}];
    OrganizedClientMessage *message;
    @try {
        message = [OrganizedClientMessage getInstanceOfUserSetInfoRequest:_person.m_szUserAccount mpKeyValuePairs:mudic];
    } @catch (NSException *exception) {
        return;
    }
    
    NSString *messageStr = [message toString];
    NSDictionary *dataDic = @{KEY_REQUEST:messageStr,KEY_REQUESTFROM:@"ios"};
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:dataDic viewC:self backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        OrganizedClientMessage *oM =  [[OrganizedClientMessage alloc]initWithStringToMessage:bodyStr];
        if (oM) {
            
        }
        
        
    }];
    
    
}
#pragma -mark 通知
- (void)meshowKeyBoard:(NSNotification *)notification {

    NSValue *rectValue = notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyBoardFrame = [rectValue CGRectValue];
    
    //   取得键盘的高度
    CGFloat height = keyBoardFrame.size.height ;
    
    
    CGFloat space = KScreenHeight - 64 - 50*6;
    CGFloat transformY = height - space;
    if (transformY < 0) {
        CGRect frame = self.tableView.frame;
        frame.origin.y = transformY +40 ;
        self.tableView.frame = frame;

    }
    
}


-(void)mehidKeyBoard:(NSNotification *)notification {
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = 64;
    self.tableView.frame = frame;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}


//生日选取
- (UIView *)configurePickView:(NSIndexPath *)indexPath{
    _pickerSuperView = [[UIView alloc] initWithFrame:CGRectMake(80,0, KScreenWidth -30, 60)];
    _pickerSuperView.hidden = NO;
    _pickerSuperView.backgroundColor = [UIColor colorWithHexString:@"ececec"];
    
  
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 60 , _pickerSuperView.height)];
    datePicker.maximumDate = [NSDate date];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [_pickerSuperView addSubview:datePicker];
    
    
    WQTMeChangeCell *cell =  [self.tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell.contentLabel.text.length) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:cell.contentLabel.text];
        [datePicker setDate:date];
    }
    return _pickerSuperView;
    
}

#pragma mark -- 日期选择器
- (void)datePickerChange:(UIDatePicker *)datePicker {
    
    NSDate *date = [datePicker date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    _brithdayStr = dateStr;
    
    NSLog(@"%@", dateStr);
    
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



@end
