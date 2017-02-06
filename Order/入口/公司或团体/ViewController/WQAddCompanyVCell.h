//
//  WQAddCompanyVCell.h
//  Order
//
//  Created by wang on 2016/11/4.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQAddCompanyVCell : UITableViewCell
/** 数组*/
@property(nonatomic,strong) NSString *titt;

/** label*/
@property(nonatomic,strong) UILabel *label;
/** tF*/
@property(nonatomic,strong) UITextField *textF;


-(instancetype)signPersonCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
