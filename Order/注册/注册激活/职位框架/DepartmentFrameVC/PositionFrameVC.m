//
//  PositionFrameVC.m
//  SetDepartment
//
//  Created by wang on 16/7/24.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "PositionFrameVC.h"
#import "UIViewExt.h"
#import "PositionView.h"

#import "SonTableViewCell.h"
#import "JobTitleStructure.h"
#import "DepartModel.h"



@interface PositionFrameVC ()<UITextFieldDelegate,PositionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *setLabel;
/** 控制器数组*/
@property(nonatomic,strong) NSMutableArray *VCArr;;
/** 添加的部门名称*/
@property(nonatomic,strong) NSString *departmentName;
/** 添加的部门*/
@property(nonatomic,strong) NSMutableArray *departmentArr;
/** 添加的部门*/
@property(nonatomic,strong) NSMutableArray *positionArr;

/** PositionView.h*/
@property(nonatomic,strong) PositionView *firstPositionV;
@property(nonatomic,assign) BOOL isFirst;

/** 枚举*/
@property(nonatomic,strong) JobTitleStructure *job;
@end

@implementation PositionFrameVC

-(NSMutableArray *)subDepartmentArr{
    if (_subDepartmentArr == nil) {
        _subDepartmentArr = [NSMutableArray array];
    }
    return _subDepartmentArr;
}
-(NSMutableArray *)VCArr{
    if (_VCArr == nil) {
        _VCArr = [NSMutableArray array];
    }
    return _VCArr;
}

-(NSMutableArray *)positionArr{
    if (_positionArr == nil) {
        _positionArr = [NSMutableArray array];
    }
    return _positionArr;
}

-(NSMutableArray *)departmentArr{
    if (_departmentArr == nil) {
        _departmentArr = [NSMutableArray array];
    }
    return _departmentArr;
}



+(PositionFrameVC *)frameVC{
    return  [[UIStoryboard storyboardWithName:@"PositionFrameVC" bundle:nil] instantiateInitialViewController];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置子视图
    [self _configurationSubView];

      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creatVC:) name:@"SubcreatVC" object:nil];
    
}

//配置子视图
-(void)_configurationSubView{
    _firstPositionV = [[PositionView alloc]initWithFrame:CGRectMake(0, 150+69+5, KScreenWidth, KScreenHeight -150-49 -30)];
    
    [_firstPositionV.backBtn removeFromSuperview];
    [_firstPositionV.rihgtBtn removeFromSuperview];
    _firstPositionV.titleLabel.text = @"添加直属部门和职位";
    _firstPositionV.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    _firstPositionV.delagte = self;
    _firstPositionV.isFirst = YES;
    [self.view addSubview:_firstPositionV];
    

}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _departmentName = textField.text;

}


- (IBAction)completeBtn:(UIButton *)sender {
    
        [self.navigationController popViewControllerAnimated:YES];
        [_delagate completePositionViewPositionFrameVC:self];
    _job = [JobTitleStructure sharedJobTitleStructure];
    
    NSLog(@"%@",_job.m_hashDepartments);
    NSLog(@"%@",[_job getJobtitle]);
    [CommonFunctions functionArchverCustomClass:_job fileName:NSStringFromClass([JobTitleStructure class])];
    
}


//点击按钮的代理方法
   //1.创建PositionView
/*
 添加部门弹出 子部门视图
 判断1.如果子部门存在 (1)不需要创建，(2)只需要通过ID找到对应的控制器添加在控制器上
 2.子部门不存在    (1)创建子部门 (2)  将ID传递给子部门
 */

//创建子职位视图
-( void  )addSubDepartmentvieWithArrID:(NSMutableArray *)departmentID title:(NSString *)title{
    CGFloat subWidth = KScreenWidth *3 /4;
    CGFloat subHight = KScreenHeight *3/4;
    
    CGFloat y = (KScreenHeight - subHight)/2;
    CGFloat X = (KScreenWidth - subWidth)/2;
    PositionView *subC = [[PositionView alloc]initWithFrame:CGRectMake(X, y, subWidth, subHight)];
    subC.isFirst = NO;
    subC.departmentID = departmentID;
    subC.titlStr = title;
    
    for (PositionView *PP in _VCArr) {
        
        if ([PP.departmentID isEqualToArray:subC.departmentID]) {
           
            subC = nil;
            return ;
        }
        
    }

    subC.delagte = self;
   
    [self.view addSubview:subC];
    [self.VCArr addObject:subC];
    
    [self.view addSubview:subC];
}

#pragma -mark 通知框架
-(void)creatVC:(NSNotification *)notification{
    
    SonTableViewCell *cell = notification.userInfo[@"index"];
    
    [self addSubDepartmentvieWithArrID:cell.contentBtn.departmentID title:cell.contentLabel.text];
    
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SubcreatVC" object:nil];
    
}


#pragma PositionViewDelegate
-(void)PositionViewClickBacek:(PositionView *)subView{
    
    [subView removeFromSuperview];
    
}


-(void)PositionViewWithDepartmentAndPositions:(NSString *)department departmentID:(NSMutableArray *)departmentID positionArr:(NSMutableArray *)positionArr level:(NSMutableArray *)leve{
    
    
}

-(void)PositionViewWithDepartment:(NSString *)department departmentID:(NSMutableArray *)departmentID{
    
    
    
}

-(void)PositionViewClickCompleteBtn:(PositionView *)subView{
    for (PositionView *pV in _VCArr) {
        
        [pV removeFromSuperview];
        
    }
}

@end
