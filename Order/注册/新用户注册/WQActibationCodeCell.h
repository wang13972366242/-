//
//  WQActibationCodeCell.h
//  Order
//
//  Created by wang on 16/8/13.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQActibationCodeCell : UITableViewCell

/** 是否勾选*/

/** 按钮*/
@property(nonatomic,strong) UIButton *selsectBtn;
/** contentLabel*/
@property(nonatomic,strong) UILabel *contentLabel;
-(instancetype)actibationCodeCell:(UITableView *)tableView WithIdentifier:(NSString *)ID;
@end
