//
//  ScanDepartmentV.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ScanDepartmentV.h"
#import "PositionManager.h"
#import "ScanDepartmentCell.h"
#import "Department.h"
#import "Position.h"
#import "ScanDepartmentModel.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

#define selfWight   self.bounds.size.width
#define selfHeight  self.bounds.size.height
@interface ScanDepartmentV ()<UITableViewDataSource,UITableViewDelegate,ScanDepartmentCellDelagate>
/** tableview*/
@property(nonatomic,strong) UITableView *tableView;
/** PositionManager*/
@property(nonatomic,strong) PositionManager *manager;
/** tableView数据的数组*/
@property(nonatomic,strong) NSMutableArray *data;

@end

@implementation ScanDepartmentV

-(NSMutableArray *)data{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _manager = [PositionManager sharePositionManager];
        [self _configurationSubviews:frame];
        //加载基本数据 循环遍历数组选出ID数组个数为1的ID
        _manager = [self unarchverCustomClassFileName:NSStringFromClass([PositionManager class])];
        for (Department *d in _manager.departmentArr) {
            if (d.ID.count == 1) {
                NSString *detailStr = @"1213";
                NSDictionary *dic= @{@"ID":d.ID,@"themmeStr":d.name,@"detailStr":detailStr};
                ScanDepartmentModel *model = [[ScanDepartmentModel alloc]initWithDic:dic];
                [self.data addObject:model];
            }
        }
        
    }
    return self;
}

/**
 *  配置子视图
 * 1.创建一个"职位列表" listLabel
 * 2.创建一个"公司直属职位"positionLabel
 * 3.创建 "职位名称"label "级别"levelLabel
 * 4.创建tableVie
 */
-(void)_configurationSubviews:(CGRect)frame{
    
    //1.创建一个"职位列表"label
    CGFloat listLabelH = 20.0;
    UILabel *listLabel = [self creatLabelWithFrame:CGRectMake(0, 5, selfWight, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:14.0] textColor:[UIColor blueColor] text:@"部门列表"];
    [self addSubview:listLabel];
    //2.创建一个"公司直属职位"positionLabel
    CGFloat positionLabelY = 30.0f;
    UILabel *positionLabel = [self creatLabelWithFrame:CGRectMake(0, positionLabelY, selfWight, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor greenColor] text:@"公司直属部门"];
    [self addSubview:positionLabel];
    //3.创建 "职位名称"namelabel "级别"levelLabel
    CGFloat namelabelY = 60.0f;
    UILabel *namelabel = [self creatLabelWithFrame:CGRectMake(0, namelabelY, selfWight, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor orangeColor] text:@"部门名称"];
    [self addSubview:namelabel];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, selfWight,selfHeight - 90) style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate =  self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //设置cell的高度
    self.tableView.rowHeight = 60;
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
}

static NSString *scanDepartmentCell= @"scanDepartmentCell";


#pragma mark ---UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScanDepartmentCell *cell = [[ScanDepartmentCell alloc]init];
    [cell ScanDepartmentCell:tableView WithIdentifier:scanDepartmentCell];
    ScanDepartmentModel *model = _data[indexPath.row];
    cell.btnDeleate = self;
    cell.ID = model.ID;
    cell.themeLabel.text = model.themmeStr;
    cell.detailLabel.text = model.detailStr;
    if (model.isOpen == NO) {
        [cell.rightBtn setImage:[UIImage imageNamed:@"xia_arrow0001"] forState:UIControlStateNormal];
    }else{
     [cell.rightBtn setImage:[UIImage imageNamed:@"shang_arrow0001"] forState:UIControlStateNormal];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

/**
 *  点击按钮返回的方法
 *    1.如果不是打开状态
  (2) 插入对应的数据(ID )
    2.如果是打开状态
  (2) 删除对应的ID
 *
 */
-(void)scanDepartmentButtonAction:(ScanDepartmentCell *)cell{
    
    NSIndexPath *indexPath = [self.tableView  indexPathForCell:cell];
     ScanDepartmentModel *model = _data[indexPath.row];
    if (model.isOpen == YES) {
          model.isOpen = !model.isOpen;
    //插入数据
        for (Department *d in _manager.departmentArr) {
            NSMutableArray *arr = [NSMutableArray array];
            arr = [d.ID mutableCopy];
            [arr removeLastObject];
            if ([cell.ID isEqualToArray:arr]) {
            NSString *detailStr = @"23123";
            NSDictionary *dic= @{@"ID":d.ID,@"themmeStr":d.name,@"detailStr":detailStr};
            ScanDepartmentModel *model = [[ScanDepartmentModel alloc]initWithDic:dic];
            [self.data insertObject:model atIndex:indexPath.row+1];
                 }
        }
    }else{
        model.isOpen = !model.isOpen;
        NSMutableArray *da = [NSMutableArray array];
        da = [self.data mutableCopy];
        for (Department *d in self.data) {
            NSMutableArray *arr = [NSMutableArray array];
            arr = [d.ID mutableCopy];
            [arr removeLastObject];
            if ([cell.ID isEqualToArray:arr]) {
                [da removeObject:d];
            }
        }
        self.data = da;
    }
    [self.tableView reloadData];
}

/**
 *  点击方法
 *  点击单元 发通知 传递ID过去
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //通知
    Department *d = _data[indexPath.row];
    NSDictionary *dic = @{@"ID":d.ID};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"positionAddData" object:self userInfo:dic];
}

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
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
