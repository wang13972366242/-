//
//  WQWeekCell.h
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQWeekCell : UITableViewCell

/** 星期labl*/
@property(nonatomic,strong) UILabel *weekLabel;
@property(nonatomic,strong) UILabel *numberLabel;
@property(nonatomic,strong) UILabel *timeLabel;
/** UIImageView*/
@property(nonatomic,strong) UIImageView *bgImageView;


-(instancetype)weekCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
