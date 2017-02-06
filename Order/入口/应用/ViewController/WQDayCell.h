//
//  WQDayCell.h
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQDayCell : UITableViewCell
/** 天*/
@property(nonatomic,strong) UILabel *contentLabel;
/** UIImageView*/
@property(nonatomic,strong) UIImageView *bgImageView;

-(instancetype)dayCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
