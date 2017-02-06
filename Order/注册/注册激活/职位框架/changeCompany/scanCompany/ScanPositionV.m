//
//  ScanPositionV.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ScanPositionV.h"
#import "ScanPositionCell.h"
#import "PositionManager.h"
#import "Position.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

#define selfWight   self.bounds.size.width
#define selfHeight  self.bounds.size.height
@interface ScanPositionV ()<UITableViewDelegate,UITableViewDataSource>

/** tableview*/
@property(nonatomic,strong) UITableView *tableView;
/** PositionManager*/
@property(nonatomic,strong) PositionManager *manager;
@property(nonatomic,strong)NSMutableArray *data;
@end

@implementation ScanPositionV

-(NSMutableArray *)data{
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _manager = [PositionManager sharePositionManager];
        _manager = [self unarchverCustomClassFileName:NSStringFromClass([PositionManager class])];
        [self _configurationSubviews:frame];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDetasoure:) name:@"positionAddData" object:nil];
    }
    return self;
}

-(void)addDetasoure:(NSNotification *)notification{
    [_data removeAllObjects];
    _data = nil;
    NSMutableArray *ID = [NSMutableArray array];
    ID = [notification.userInfo[@"ID"] mutableCopy];
    [ID removeLastObject];
    NSMutableArray *arr = [NSMutableArray array];
    for (Position *p in _manager.positiontArr) {
        arr = [p.ID mutableCopy];
        [arr removeLastObject];
        if ([arr isEqualToArray:ID]) {
            [self.data addObject:p];
        }
    }
    [self.tableView reloadData];

}
/**
 *  配置子视图
 * 1.创建一个"职位列表" listLabel
 *  2.创建一个"公司直属职位"positionLabel
 *  3.创建 "职位名称"label "级别"levelLabel
 *  4.创建tableVie
 */
-(void)_configurationSubviews:(CGRect)frame{
    
    //1.创建一个"职位列表"label
    CGFloat listLabelH = 20.0;
    UILabel *listLabel = [self creatLabelWithFrame:CGRectMake(0, 5, selfWight, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:14.0] textColor:[UIColor blueColor] text:@"职位列表"];
    [self addSubview:listLabel];
    //2.创建一个"公司直属职位"positionLabel
    CGFloat positionLabelY = 30.0f;
    UILabel *positionLabel = [self creatLabelWithFrame:CGRectMake(0, positionLabelY, selfWight, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor greenColor] text:@"公司直属职位"];
    [self addSubview:positionLabel];
    //3.创建 "职位名称"namelabel "级别"levelLabel
    CGFloat namelabelY = 60.0f;
    UILabel *namelabel = [self creatLabelWithFrame:CGRectMake(0, namelabelY, selfWight-60, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor orangeColor] text:@"职位名称"];
    [self addSubview:namelabel];
    
    UILabel *levelLabel = [self creatLabelWithFrame:CGRectMake(selfWight-60, namelabelY, 44, listLabelH) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor orangeColor] text:@"级别"];
    [self addSubview:levelLabel];
    
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

static NSString *scanPositionCell= @"scanPositionCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScanPositionCell *cell = [[ScanPositionCell alloc]init];
    [cell ScanPositionCell:tableView WithIdentifier:scanPositionCell];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    Position *p = _data[indexPath.row];
    cell.nameLabel.text = p.name;
    cell.levelLabel.text = p.level;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
