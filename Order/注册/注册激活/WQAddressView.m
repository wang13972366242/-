//
//  WQAddressView.m
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAddressView.h"

@implementation WQAddressView
/**
 *  初始化方法
 *  配置视图 (1)label “地址:”
 (2) 输入框
 (3)label “*”
 (4)按钮系统的+
 
 *
 */

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self _configurationSubviews:frame];
    }
    return self;
}


/**
 *  子视图   frame 视图 CGRectMake(, ,KScreenWidth,30)
 label“地址” 高度  30  宽度 60
 输入框  高度  30  宽度   KScreenWidth -60 - 10 - 44 -10
 label “*”  高度  30  宽度 10
 按钮系统的+  高度  30  宽度 44
 */

-(void)_configurationSubviews:(CGRect)frame{
    //label“地址” 高度  30  宽度 60
    CGFloat hight = 30.0f;
    CGFloat  nameLabelWidth = 75.0f;
    self.addressLabel = [self creatLabelWithFrame:CGRectMake(+5.0, 4.5, nameLabelWidth, 21) textAlignment:NSTextAlignmentRight font:[UIFont systemFontOfSize:16.0f] textColor:[UIColor blackColor] text:@"地址:"];
    [self addSubview:self.addressLabel];
    //label “*”  高度  21  宽度 10
    CGFloat starX =  nameLabelWidth+5.0f;
    CGFloat startWidth = 8.5f ;
    self.starLabel = [self creatLabelWithFrame:CGRectMake(starX, 0, startWidth, hight) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:17.0f] textColor:[UIColor redColor] text:@"*"];
    [self addSubview:self.starLabel];
    //输入框  高度  30  宽度   KScreenWidth -60 - 10 - 44 -10
    CGFloat textFWith =  KScreenWidth -nameLabelWidth-startWidth - 44 -10;
    _textTF=  [[UITextField alloc]initWithFrame:CGRectMake(starX+2+startWidth, 0, textFWith, hight)];
    _textTF.borderStyle = UITextBorderStyleRoundedRect;
    _textTF.delegate = self;
    [self addSubview:_textTF];
   
    //按钮系统的+  高度  30  宽度 44
    CGFloat btnX = starX+2+startWidth + textFWith;
    CGFloat btnW = 44.0f;
    self.addBtn =  [self creatButtonWithUIButtonType:UIButtonTypeContactAdd frame:CGRectMake(btnX, 0, btnW, hight) title:nil font:[UIFont boldSystemFontOfSize:28.f] titleColor:[UIColor blueColor] selector:@selector(addSelfAction:)];
    
    [self addSubview:self.addBtn];
}

/**
 *  +好按钮
 *   点击+按钮创建自己本身
 *
 */

-(void)addSelfAction:(UIButton *)sender{
    [_delegate addressViewCreatSelf:self addBtn:sender];
    
}
-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor selector:(SEL)selector{
    
    //3.切换按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font =font;
    btn.frame = frame;
    return  btn;
}
-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text =text;
    return label;
}


@end
