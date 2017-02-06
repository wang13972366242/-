//
//  CompanyInfoChangeVC.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CompanyInfoChangeVC.h"
#import "CompanyCell.h"
#import "UIViewExt.h"
#import "ScanDepartment.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface CompanyInfoChangeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scorllview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
/** UItableviw*/
@property(nonatomic,strong) UITableView *tableView;
/** UITextView*/
@property(nonatomic,strong) UITextView *textView;
/** 查看按钮*/
@property(nonatomic,strong) UIButton *scanBtn;
/** 修改按钮*/
@property(nonatomic,strong) UIButton *changeBtn;
/** 基本信息数组 */
@property(nonatomic,strong) NSArray *baseArr;
@end

@implementation CompanyInfoChangeVC



+(CompanyInfoChangeVC*)infoChangeVC{
    return  [[UIStoryboard storyboardWithName:@"CompanyInfoChangeVC" bundle:nil] instantiateInitialViewController];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    self.title = @"公司信息修改";
    _baseArr = @[@"名称:",@"地址:",@"电话:",@"邮箱:",@"类型:",@"公司描述:",@"查看职位架构:",@"修改职位架构:"];
      _scrollViewHeight.constant = _baseArr.count *50 +100;
    //1.创建tableview
    [self _configurationTableView];
    
}

-(void)_configurationTableView{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, _baseArr.count *50 +50) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.scorllview addSubview:self.tableView];
    //注册
    [self.tableView registerClass:[CompanyCell class] forCellReuseIdentifier:companyCell];

    
}

static NSString *companyCell = @"CompanyCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return   _baseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CompanyCell *cell = [[CompanyCell alloc]init];
    [cell companyCell:tableView WithIdentifier:companyCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _baseArr[indexPath.row];
    cell.contentLabel.text = @"2134232321435";

    //描述
    if ([_baseArr[indexPath.row] isEqualToString:@"公司描述:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_textView == nil) {
            _textView = [[UITextView alloc]initWithFrame:CGRectMake(80+6, 6, KScreenWidth - 10 -5 -cell.contentLabel.width, 100-12)];
            [cell.contentView addSubview:_textView];
        }else{
        [cell.contentView addSubview:_textView];
        
        }
    }
    //查看按钮
    if ([_baseArr[indexPath.row] isEqualToString:@"查看职位架构:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_scanBtn == nil) {
            _scanBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(100+6+10, 6, 150, 50-12) title:@"查看职位架构" titleColor:[UIColor blackColor]];
            [_scanBtn addTarget:self action:@selector(sacnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scanBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
            [cell.contentView addSubview:_scanBtn];
        }else{
        [cell.contentView addSubview:_scanBtn];
        }
    }
    
    //修改按钮
    if ([_baseArr[indexPath.row] isEqualToString:@"修改职位架构:"]) {
        [cell.contentLabel removeFromSuperview];
        if (_changeBtn == nil) {
            _changeBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(100+6+10, 6, 150, 50-12) title:@"修改职位架构" titleColor:[UIColor blackColor]];
             [_changeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
             [_changeBtn setBackgroundImage:[UIImage imageNamed:@"chat_btn_recording_h"] forState:UIControlStateNormal];
            [cell.contentView addSubview:_changeBtn];
        }else{
            [cell.contentView addSubview:_changeBtn];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 单元阁自适应高度
    if (indexPath.row == 5) {
        return 100;
    }else{
    return 50;
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

#pragma mark - 查看和修改按钮
-(void)sacnAction:(UIButton *)sender{

    ScanDepartment * scanD = [[ScanDepartment alloc]init];
    [self.navigationController pushViewController: scanD animated:YES];

}
-(void)changeAction:(UIButton *)sender{
    
    
    
}

-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.frame = frame;
    return  btn;
}


@end
