//
//  ScanPositionCell.h
//  CompanyInfoChange
//
//  Created by wang on 16/8/12.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanPositionCell : UITableViewCell
/*
 子类化  左边是职位名称 ，右边是 职位级别
 */
/** 职位名称*/
@property(nonatomic,strong) UILabel *nameLabel;
/** 职位级别*/
@property(nonatomic,strong) UILabel *levelLabel;
-(instancetype)ScanPositionCell:(UITableView *)tableView WithIdentifier:(NSString *)ID;
@end
