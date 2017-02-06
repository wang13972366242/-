//
//  RightTableView.m
//  SaveDataPositionVC
//
//  Created by wang on 16/8/6.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "RightTableView.h"
#import "JobTitleStructure.h"
#import "SonTableViewCell.h"



@implementation RightTableView

-(NSMutableArray *)leverArr{
    
    if (_leverArr == nil) {
        _leverArr = [NSMutableArray array];
    }
    return _leverArr;
}

-(NSMutableArray *)departmentID{
    
    if (_departmentID == nil) {
        _departmentID = [NSMutableArray array];
    }
    return _departmentID;
}

-(NSMutableArray *)data{
    
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
    
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        _jobManager = [JobTitleStructure sharedJobTitleStructure];
        
        self.dataSource = self;
        self.delegate =  self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        
        //设置cell的高度
        self.rowHeight = 60;
        
        //隐藏滑动条
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

static NSString *SonCell= @"SonCell";


#pragma mark ---UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SonTableViewCell *cell = [[SonTableViewCell alloc]init];
    [cell SonTableViewCell:tableView WithIdentifier:SonCell initWithFrame:CGRectMake(0, 0,self.bounds.size.width , self.bounds.size.height)];
    cell.isRight =YES;
    cell.contentLabel.text = _data[indexPath.row];
//        [cell.contentBtn setTitle:_leverArr[indexPath.row] forState:UIControlStateNormal];
    if ([_leverArr[indexPath.row] isKindOfClass:[NSNumber class]]) {
        NSString *str = [NSString stringWithFormat:@"%@",_leverArr[indexPath.row]];
        [cell.contentBtn setTitle:str forState:UIControlStateNormal];
    }
   
    if (_isFirst == YES) {
        [cell.contentBtn.departmentID   addObject:@(indexPath.row)];
    }{
        NSMutableArray *ID = [NSMutableArray array];
        ID = [self.departmentID mutableCopy];
        [ID addObject:@(indexPath.row)];
        cell.contentBtn.departmentID  = ID;
    }
    if (cell.contentBtn.departmentID.count < 10) {
  
     
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

//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}




#pragma mark 编辑按钮
- (void)setEditing:(BOOL)editing animated:(BOOL)animated

{
    
    [super setEditing:editing animated:animated];
    
    [self setEditing:!self.editing animated:YES];
    
}



#pragma mark 设置可以进行编辑

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    return YES;
}





/**
 
 *  tableView:editActionsForRowAtIndexPath:     //设置滑动删除时显示多个按钮
 
 *  UITableViewRowAction                        //通过此类创建按钮
 
 *  1. 我们在使用一些应用的时候，在滑动一些联系人的某一行的时候，会出现删除、置顶、更多等等的按钮，在iOS8之前，我们都需要自己去实现。But，到了iOS8，系统已经写好了，只需要一个代理方法和一个类就搞定了
 
 *  2. iOS8的<UITableViewDelegate>协议多了一个方法，返回值是数组的tableView:editActionsForRowAtIndexPath:方法，我们可以在方法内部写好几个按钮，然后放到数组中返回，那些按钮的类就是UITableViewRowAction
 
 *  3. 在UITableViewRowAction类，我们可以设置按钮的样式、显示的文字、背景色、和按钮的事件（事件在Block中实现）
 
 *  4. 在代理方法中，我们可以创建多个按钮放到数组中返回，最先放入数组的按钮显示在最右侧，最后放入的显示在最左侧
 
 *  5. 注意：如果我们自己设定了一个或多个按钮，系统自带的删除按钮就消失了...
 
 */




#warning iOS8 -

#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        RightTableView *leftV = (RightTableView *)tableView;
        // 添加一个删除按钮
        SonTableViewCell *cell = [leftV cellForRowAtIndexPath:indexPath];
        // 1. 更新数据
        [self.data removeObjectAtIndex:indexPath.row];
        [self.leverArr removeObjectAtIndex:indexPath.row];
        
        
        if (_isFirst == YES) {
            [_jobManager removeJobTitle:cell.contentLabel.text];
        }else{
            [_jobManager removeJobTitle:cell.contentLabel.text departName:_titlStr];

        }
        
        // 2. 更新UI
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    return@[deleteRowAction];
}


- (UIViewController *)respondForController {
    
    UIResponder *next = self.nextResponder;
    
    // 只要响应者链上，还有下一级响应者，就一直查找
    do {
        // 判断获取的响应者对象是否是 视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            //
            // 返回查找到的视图控制器
            return (UIViewController *)next;;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    
    return nil;
}


@end
