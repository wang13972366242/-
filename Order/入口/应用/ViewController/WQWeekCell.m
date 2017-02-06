//
//  WQWeekCell.m
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQWeekCell.h"

@implementation WQWeekCell

-(instancetype)weekCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame{
    WQWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQWeekCell alloc] initWithFrame:frame];
    }
    return cell;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews{
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.bgImageView.image = [UIImage imageNamed:@"chat_btn_recording_n"];
    [self.contentView addSubview:self.bgImageView];
    
    
    _weekLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    _numberLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    _timeLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self.bgImageView addSubview:_weekLabel];
    [self.bgImageView addSubview:_numberLabel];
    [self.bgImageView addSubview:_timeLabel];
}

-(void)layoutSubviews{
    CGFloat btnX = 15.0f;
    CGFloat btnW = self.width - 2 *btnX;
    CGFloat btnY = 5.0f;
    CGFloat btnH = self.height - 2*btnY;
    
    _bgImageView.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    CGFloat labelH = btnH  /4.0;
    CGFloat  labelJ = btnH /16;
    _weekLabel.frame = CGRectMake(10, labelJ, _bgImageView.width-10, labelH);
     _numberLabel.frame = CGRectMake(10, 2 *labelJ+labelH, _bgImageView.width-10, labelH);
    _timeLabel.frame = CGRectMake(10, 3 *labelJ +2*labelH, _bgImageView.width- 10, labelH);
    
    
}


-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    
    return label;
}
@end
