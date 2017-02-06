//
//  SonTableViewCell.h
//  Digui
//
//  Created by wang on 16/7/4.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SonBtn.h"

@interface SonTableViewCell : UITableViewCell

/** 内容*/
@property(nonatomic,strong) UILabel *contentLabel;

/** +按钮*/
@property(nonatomic,strong) SonBtn *contentBtn;

/**  是否右边*/
@property(nonatomic,assign) BOOL isRight;
-(instancetype)SonTableViewCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
