//
//  WQFirstTableViewCell.h
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQFirstTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UIImageView *BGView;
@property (strong, nonatomic)  UILabel *label;
/** 数据化*/
@property(nonatomic,strong) NSString *labelStr;
+(instancetype)firstTableViewCell:(UITableView *)tableView WithIdentifier:(NSString *)ID;
@end
