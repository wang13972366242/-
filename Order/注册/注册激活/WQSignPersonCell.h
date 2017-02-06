//
//  WQSignPersonCell.h
//  Order
//
//  Created by wang on 16/7/22.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQSignPersonCell : UITableViewCell
/** 数组*/
@property(nonatomic,strong) NSString *titt;

/** label*/
@property(nonatomic,strong) UILabel *label;
/** tF*/
@property(nonatomic,strong) UITextField *textF;
@property(nonatomic,strong) UIButton *btn;

-(instancetype)signPersonCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
