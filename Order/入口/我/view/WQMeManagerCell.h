//
//  WQMeManagerCell.h
//  Order
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQMeManagerCell : UITableViewCell
/** 天*/
@property(nonatomic,strong) UILabel *contentLabel;
/** UIImageView*/
@property(nonatomic,strong) UIImageView *bgImageView;

-(instancetype)memanamgerCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
