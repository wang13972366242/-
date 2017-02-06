//
//  WQActibationCodeCell.m
//  Order
//
//  Created by wang on 16/8/13.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQActibationCodeCell.h"

@implementation WQActibationCodeCell
-(instancetype)actibationCodeCell:(UITableView *)tableView WithIdentifier:(NSString *)ID {
    WQActibationCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQActibationCodeCell alloc]init];
        
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
    self.selsectBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectZero title:nil titleColor:nil];
    [self.contentView addSubview:self.selsectBtn];
    self.contentLabel = [self creatLabelWithFrame:CGRectZero textAlignment:(NSTextAlignmentLeft) font:[UIFont boldSystemFontOfSize:16.0] textColor:[UIColor blackColor] text:nil];
    [self.contentView addSubview:self.contentLabel];
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];

    
    CGFloat  selsectBtnW =44;
    CGFloat  selsectBtnX =10;
    CGFloat selsectBtnY = (self.bounds.size.height - selsectBtnW)/2;
    self.selsectBtn.frame = CGRectMake(selsectBtnX, selsectBtnY,selsectBtnW, selsectBtnW);
    
    
    CGFloat contentLabelH = 30;
    CGFloat contentLabelY = (self.bounds.size.height - contentLabelH)/2;
    self.contentLabel.frame = CGRectMake(self.selsectBtn.right +10, contentLabelY,200, contentLabelH);
    
    
}

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}
-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];

    btn.frame = frame;
    return  btn;
}



@end
