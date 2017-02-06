//
//  CompanyCell.h
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UITableViewCell
/** 显示label*/
@property(nonatomic,strong) UILabel *titleLabel;
/** 显示内容label*/
@property(nonatomic,strong) UILabel *contentLabel;
-(instancetype)companyCell:(UITableView *)tableView WithIdentifier:(NSString *)ID;
@end
