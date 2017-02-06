//
//  ScanDepartment.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ScanDepartment.h"
#import "ScanPositionV.h"
#import "ScanDepartmentV.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ScanDepartment ()
/** ScanPositionV*/
@property(nonatomic,strong) ScanPositionV *scanPV;
/** ScanDepartment*/
@property(nonatomic,strong) ScanDepartmentV *scanD;
@end

@implementation ScanDepartment

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前职位框架设定";
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self _configrationSubViews];
}

-(void)_configrationSubViews{
    
    _scanPV = [[ScanPositionV alloc]initWithFrame:CGRectMake( KScreenWidth/2,64, KScreenWidth/2, KScreenHeight - 64)];
    
    [self.view addSubview:_scanPV];
    
    _scanD = [[ScanDepartmentV alloc]initWithFrame:CGRectMake(0, 64,KScreenWidth/2, KScreenHeight - 64)];
    [self.view addSubview:_scanD];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
