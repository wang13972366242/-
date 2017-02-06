//
//  PositionView.m
//  Digui
//
//  Created by wang on 16/7/10.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "PositionView.h"
#import "RightTableView.h"
#import "LeftTableView.h"
#import "UIViewExt.h"
#import "JobTitleStructure.h"
#import "OrganizedJobTitle.h"
#import "OrganizedDepartment.h"
#import "OrganedDepartmentID.h"


@interface PositionView()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
/**
 *  职位输入框
 */
@property (strong, nonatomic)  UITextField *positionTF;
@property(strong,nonatomic) UIButton *positionBtn;
/**
 *  部门
 */
@property (strong, nonatomic)  UITextField *departmentTF;
@property(strong,nonatomic) UIButton *departmentBtn;

/**
 *  背景视图
 */
@property (strong, nonatomic)  UIView *GBView;

/** UIPickerView*/
@property(nonatomic,strong) UIPickerView *pickerView;


/** 职位等级数组*/
@property(nonatomic,strong) NSArray *levelArr;


/** 等级数组最后一个*/
@property(nonatomic,strong) NSMutableArray *lastLV;
/** 部门数组*/
@property(nonatomic,strong) NSMutableArray *departmentArr;
/** 职位数组*/
@property(nonatomic,strong) NSMutableArray *positionArr;
/** job*/


/** 保存部门名称*/
@property(nonatomic,strong) NSString *departName;
/** 保存职位名称*/
@property(nonatomic,strong) NSString *posiName;
/** 键盘的高度*/
@property(nonatomic,assign) CGFloat  hight;
/** PositionManager*/
@property(nonatomic,strong) JobTitleStructure *jobManager;
@end

@implementation PositionView



-(NSMutableArray *)departmentArr{
    if (_departmentArr == nil) {
        _departmentArr = [NSMutableArray array];
    }
    return _departmentArr;
}
-(NSMutableArray *)positionArr{
    if (_positionArr == nil) {
        _positionArr = [NSMutableArray array];
    }
    return _positionArr;
}

-(NSMutableArray *)lastLV{
    if (_lastLV == nil) {
        _lastLV = [NSMutableArray array];
    }
    return _lastLV;
}

-(void)setTitlStr:(NSString *)titlStr{
    if (![_titlStr isEqualToString:titlStr]) {
        _titlStr = titlStr;
    }
    _titleLabel.text = titlStr;
    _leftcontentV.titlStr = _titlStr;
    _rightcontentV.titlStr = _titlStr;
}
-(void)setDepartmentID:(NSMutableArray *)departmentID{

    _departmentID = departmentID;
    _rightcontentV.departmentID =departmentID;
    _leftcontentV.departmentID =departmentID;

}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        _departmentID = [NSMutableArray array];
        self.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0];
        _levelArr = @[@"1",@"2",@"3",@"4",@"5"];
        //1.创建UIcollectionview
        [self configurationTableV];
        //2.创建按钮和输入框
        [self confiBGView:frame];
        //    UIKeyboardWillShowNotification  键盘弹出的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        
        
    }
    return self;
}


#pragma -mark 配置子视图
/**
 *  创建tableview
 */
-(void)layoutSubviews{

    [super layoutSubviews];
    

}
-(void)configurationTableV{
    
    
    _leftcontentV = [[LeftTableView alloc]initWithFrame:CGRectMake(0, 50, self.width/2 , self.height - 140) style:UITableViewStylePlain];
    [self addSubview:_leftcontentV];
    
    _rightcontentV = [[RightTableView alloc]initWithFrame:CGRectMake(self.width/2,50, self.width/2 , self.height - 140) style:UITableViewStylePlain];
    [self addSubview:_rightcontentV];
    if (_isFirst == YES) {
        _rightcontentV.isFirst = YES;
        _leftcontentV.isFirst = YES;
    }else{
        _rightcontentV.isFirst = NO;
        _leftcontentV.isFirst = NO;
    }
}


/**
 *  配置底部的视图
 */
-(void)confiBGView:(CGRect )rect{
    
    _jobManager = [JobTitleStructure sharedJobTitleStructure];
    
    //1.底部视图
    _GBView = [[UIView alloc]initWithFrame:CGRectMake(0, rect.size.height -90, rect.size.width, 90)];
    _GBView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_GBView];
    
    //2.创建输入框
    CGFloat subiewWidth = (rect.size.width - 15)/2;
    CGFloat subiewHigth = 30;
    
    for (int i = 0 ; i < 2; i++) {
        UITextField *textTF = [[UITextField alloc]initWithFrame:CGRectMake(i * (5 +subiewWidth) +5, 5, subiewWidth, subiewHigth )];
        textTF.backgroundColor = [UIColor whiteColor];
        textTF.borderStyle = UITextBorderStyleRoundedRect;
        textTF.delegate = self;
        if (i == 0) {
            _departmentTF = textTF;
            
            [_GBView addSubview:_departmentTF];
        }else{
        
            _positionTF = textTF;
            _positionTF.frame = CGRectMake(10 +subiewWidth, 5, subiewWidth - 44, subiewHigth);
            [_GBView addSubview:_positionTF];
        
        }
    }
    
   //3.创建按钮
    CGFloat BtnHight = 44;
    
    for (int i = 0 ; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (5 +subiewWidth) +5, 10 +30, subiewWidth, BtnHight);
        
        if (i == 0) {
            _departmentBtn = btn;
            [_departmentBtn setTitle:@"添加部门" forState:UIControlStateNormal];
            [_departmentBtn addTarget:self action:@selector(sureDepartment:) forControlEvents:UIControlEventTouchUpInside];
            [_GBView addSubview:_departmentBtn];
        }else{
            
            _positionBtn = btn;
            [_positionBtn setTitle:@"添加职位" forState:UIControlStateNormal];
          [_positionBtn addTarget:self action:@selector(changBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_GBView addSubview:_positionBtn];
        }
    }
    //创建职位等级选择
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake( 2 * subiewWidth -34, 5, 44 , 50)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource =self;
    [self.GBView addSubview:self.pickerView];
    
    //创建头视图
    CGFloat labelWidth = self.width / 3;
    CGFloat labelHight = 20.0;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( labelWidth , 5, labelWidth, labelHight)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel .font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.layer.cornerRadius = 5;
    _titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _titleLabel.layer.borderWidth = 1;
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    _titleLabel.clipsToBounds = YES;
    [self addSubview:_titleLabel];
    //创建3个label
   UILabel *depatmentLabel =  [self creatLabelWithFrame:CGRectMake(0, 30, self.width/2, 20) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0f] textColor:[UIColor blackColor] text:@"部门"];
    [self addSubview:depatmentLabel];
    UILabel *positionLabel =  [self creatLabelWithFrame:CGRectMake(self.width/2, 30, self.width/2 -44, 20) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0f] textColor:[UIColor blackColor] text:@"职位名称"];
    [self addSubview:positionLabel];
    UILabel *levelLabel =  [self creatLabelWithFrame:CGRectMake(KScreenWidth - 44,30, 44, 20) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0f] textColor:[UIColor blackColor] text:@"级别"];
    [self addSubview:levelLabel];
    //返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setTitle:@"<" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:28.0];
    [_backBtn addTarget:self action:@selector(addSubTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.frame =  CGRectMake(15, 0, 30, 30);
    [self addSubview:_backBtn];
    
    _rihgtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rihgtBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_rihgtBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _rihgtBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [_rihgtBtn addTarget:self action:@selector(complteAction:) forControlEvents:UIControlEventTouchUpInside];
    _rihgtBtn.frame =  CGRectMake(self.width- 40, 0, 40, 30);
    [self addSubview:_rihgtBtn];

   
    
}


#pragma -mark 左边返回按钮
-(void)addSubTitleAction:(UIButton *)sender{

    
    [_delagte PositionViewClickBacek:self];

}

//右边返回按钮
-(void)complteAction:(UIButton *)sender{

    [_delagte PositionViewClickCompleteBtn:self];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    
    if (self.origin.y >0) {
        self.transform =CGAffineTransformTranslate(self.transform, 0, _hight- self.frame.origin.y-50);
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    [self enEditing:textField];
    return YES;

}

#pragma -mark 通知
- (void)showKeyBoard:(NSNotification *)notification {
    //    NSLog(@"%@",notification.userInfo);
    
    NSValue *rectValue = notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect keyBoardFrame = [rectValue CGRectValue];
    
   //   取得键盘的高度
    _hight = KScreenHeight-self.height - keyBoardFrame.size.height;
    // 设置tableView 和 inputView的 位置

  
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
  
}


#pragma -mark 添加部门和职位


/**
 *  添加职位
 */
- (void)changBtn:(UIButton *)sender {
    [self textFieldShouldReturn:_positionTF];
  
    
 
    if (_positionTF.text.length >2 ) {
       [self.rightcontentV.data addObject:_positionTF.text];
        [_positionArr addObject:_positionTF.text];
        NSString *str = [_lastLV lastObject];
        if (str) {
           
        [self.rightcontentV.leverArr addObject:str];
            
        }else{
         str = @"3";
        [self.rightcontentV.leverArr addObject:str];
            
        }
        
        if (_isFirst == YES) {
            [_jobManager addJobTitle:_positionTF.text iJobLevel:[str intValue] szDepartment:nil ];
        }else{
        [_jobManager addJobTitle:_positionTF.text iJobLevel:[str intValue] szDepartment:self.titleLabel.text ];
        
        }
     
    }
    
    [self.rightcontentV reloadData];
    _posiName = _positionTF.text;
    _positionTF.text = nil;
    
}

-(void)setIsFirst:(BOOL)isFirst{
 _jobManager =[CommonFunctions functionUnarchverCustomClassFileName:NSStringFromClass([JobTitleStructure class])];
    _isFirst = isFirst;
    //如果是直属部门 直接添加职位
    if (_isFirst == YES && _jobManager.m_rootJobTitles) {
        for (OrganizedJobTitle *jobtitle in _jobManager.m_rootJobTitles) {
            
            @try {
                [_rightcontentV.data addObject:jobtitle.m_myTitle];
                [_rightcontentV.leverArr addObject:@(jobtitle.m_imyLevel)];
            } @catch (NSException *exception) {
                NSLog(@"直属职位错误");
            }
        }
        [_rightcontentV reloadData];
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (_jobManager == nil) {
        _jobManager = [JobTitleStructure sharedJobTitleStructure];
    }
    
   
    
    
    //遍历部门字典
    [_jobManager.m_hashDepartments enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        OrganizedDepartment *department = (OrganizedDepartment *)obj;
        OrganedDepartmentID *jobID = (OrganedDepartmentID *)key;
       NSMutableArray *arr = [jobID.m_arrayLevels mutableCopy];
        [arr removeLastObject];
        if ([arr isEqualToArray:self.departmentID]) {
            
            [_leftcontentV.data addObject:department.m_szDepartmentName];
            [_leftcontentV reloadData];
        }
        
      
        if ([arr isEqualToArray:self.departmentID]) {
            if (department.m_myJobTitleList>0) {
           
        for (OrganizedJobTitle *jobtitle in department.m_myJobTitleList) {
                
            [_rightcontentV.data addObject:jobtitle.m_myTitle];
            [_rightcontentV.leverArr addObject:@(jobtitle.m_imyLevel)];
            [_rightcontentV reloadData];
        }
        }
            
        }
    }];
    

    
    
    
//
//    NSMutableArray *arr = [NSMutableArray array];
//    if (_jobManager.m_hashDepartments) {
//       
//        for (NSDictionary * dic  in _jobManager.m_hashDepartments) {
//            NSArray *arr = [dic allKeys];
//            
//            if ([ isEqualToArray:self.departmentID]) {
//                
//            [_leftcontentV.data addObject:d.name];
//            }
//        }
//    }
//    
//    if (_manager.positiontArr) {
//        for (Position * p in _manager.positiontArr) {
//              arr = [p.ID mutableCopy];
//            [arr removeLastObject];
//            if ([arr isEqualToArray: self.departmentID]) {
//            [_rightcontentV.data addObject:p.name];
//            [_rightcontentV.leverArr addObject:p.level];
//            }
//        }
//    }
    
}

/**
 *  添加部门
 */
- (void)sureDepartment:(UIButton *)sender {
    
   [self textFieldShouldReturn:_departmentTF];
    if (_departmentTF.text.length >2 || ![_departmentTF.text isEqualToString:@"添加直属部门和职位"]) {
        [self.leftcontentV.data addObject:_departmentTF.text];
        if (_isFirst == YES) {
            [_jobManager addDepartment:_departmentTF.text];
        }else{
            [_jobManager addDepartment:_departmentTF.text szParentDepartment:_titlStr];
            
        }
        
    }
    
    [self.leftcontentV reloadData];
    _departName = _departmentTF.text;
    _departmentTF.text = nil;
    
}



-(void)enEditing:(UITextField *)textField{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [[textField superview] superview].transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    
}


#pragma -mark UIPickDataSoure

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return 5;

}



-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 50)];
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.textColor =[UIColor blueColor];
    label.text = _levelArr[row];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:_levelArr[row]];
    self.lastLV = arr;
  
 
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 50.0f;

}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
 
   

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

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}
@end
