//
//  ScanDepartmentCell.h
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanDepartmentCell;
@protocol ScanDepartmentCellDelagate <NSObject>
-(void)scanDepartmentButtonAction:(ScanDepartmentCell *)cell;

@end

@interface ScanDepartmentCell : UITableViewCell
/*子类化 1.   2个label  第一个显示部门  第二个 如果有职位显示"点击查看职位" 如果没有"暂无职位"
        2.右边一个按钮
*/
/** 主题Label*/
@property(nonatomic,strong) UILabel *themeLabel;
/** 详细Label*/
@property(nonatomic,strong) UILabel *detailLabel;
/** 右边一个按钮*/
@property(nonatomic,strong) UIButton *rightBtn;
/** ID*/
@property(nonatomic,strong) NSMutableArray *ID;
/** 滑动视图*/
@property(nonatomic,strong) UIScrollView *scrollView;
/** 是否被点击*/

/** 代理*/
@property(nonatomic,weak)  id<ScanDepartmentCellDelagate> btnDeleate;
-(instancetype)ScanDepartmentCell:(UITableView *)tableView WithIdentifier:(NSString *)ID ;

@end
