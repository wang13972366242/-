//
//  WQMeManagerCell.m
//  Order
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQMeManagerCell.h"

@implementation WQMeManagerCell

-(instancetype)memanamgerCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame{
    WQMeManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQMeManagerCell alloc] initWithFrame:frame];
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
    
    _contentLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self.bgImageView addSubview:_contentLabel];
}

-(void)layoutSubviews{
    CGFloat btnX = 15.0f;
    CGFloat btnW = self.width - 2 *btnX;
    CGFloat btnY = 5.0f;
    CGFloat btnH = self.height - 2*btnY;
    
    _bgImageView.frame = CGRectMake(btnX, btnY, btnW, btnH);
    _contentLabel.frame = CGRectMake(10, btnY, btnW -10, btnH);}


-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    
    return label;
}
@end
