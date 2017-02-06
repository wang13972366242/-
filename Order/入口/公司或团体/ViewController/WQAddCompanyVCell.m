//
//  WQAddCompanyVCell.m
//  Order
//
//  Created by wang on 2016/11/4.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAddCompanyVCell.h"

@implementation WQAddCompanyVCell

-(instancetype)signPersonCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame{
    WQAddCompanyVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQAddCompanyVCell alloc] initWithFrame:frame];
    }
    return cell;
}

- (instancetype)init{
    if (self = [super init]) {
        [self _configurationSubviews];
    }
    return self;
}

-(void)_configurationSubviews{
    //label“地址” 高度  30  宽度 60
    
    
    self.label = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentRight font:[UIFont boldSystemFontOfSize:14.0f] textColor:[UIColor blackColor] text:nil];
    [self.contentView addSubview:self.label];
    
    
    //输入框  高度  30  宽度   KScreenWidth -60 - 10 - 44 -10
    
    _textF=  [[UITextField alloc]initWithFrame:CGRectZero];
    _textF.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.contentView addSubview:_textF];
    
   
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(5, 5,80, self.height);
    
        _textF.frame = CGRectMake(self.label.right, 5, KScreenWidth - self.label.width -20, 30);
    
    
    
}

-(void)setTitt:(NSString *)titt{
    
    if (_titt != titt) {
        _titt = titt;
    }
    
    self.label.text = _titt;
    
}



-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}


@end
