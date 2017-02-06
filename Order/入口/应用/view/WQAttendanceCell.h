//
//  WQAttendanceCell.h
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQAttendanceCell : UITableViewCell
-(instancetype)attendanceCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;

/** btn*/
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *bgImageView;



@end
