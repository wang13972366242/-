//
//  SexView.m
//  SexButton
//
//  Created by wang on 16/7/24.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//


#import "SexView.h"
@interface SexView()
/** sexLabel*/
@property(nonatomic,strong) UILabel *sexLabel;
/** menBtn*/
@property(nonatomic,strong) UIButton *menBtn;
/** womenBtn*/
@property(nonatomic,strong) UIButton *womenBtn;
/** 选择按钮*/
@property(nonatomic,strong) UIButton *selectBtn;
@end


@implementation SexView

/**
 *  初始化方法创建2个按钮 和一个"性别label"
     1.性别label  x = 0  y = 0  H = self.width W =50
     2.性别menBtn x = 65  y = 0  H = self.width W = (frame.size.width - 55)/2
 2.性别womenBtn x = 115  y = 0  H = self.width W =50 W = (frame.size.width - 55)/2

 *
 */

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self subviews:frame];
    }

    return self;
}

-(void)subviews:(CGRect)frame{
    CGFloat h = frame.size.height;
    CGFloat labelWidth = 50.0;
   //1.创建label
  self.sexLabel =  [self creatLabelWithFrame:CGRectMake(0, 0, labelWidth, h) textAlignment:NSTextAlignmentRight font:[UIFont boldSystemFontOfSize:17.0f] textColor:[UIColor blackColor] text:@"性别:"];

    [self addSubview:self.sexLabel];
   //2.男性按钮
    CGFloat menBtnX = 55.0;
    CGFloat menBtnW = (frame.size.width - 55)/2;
    self.menBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(menBtnX, 0, menBtnW, h) image:[UIImage imageNamed:@"Male"]];
    self.menBtn.enabled = NO;
    [self.menBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.menBtn];
    //3.女性按钮
    CGFloat womenBtnX = menBtnW +menBtnX;
    self.womenBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectMake(womenBtnX, 0, menBtnW, h) image:[UIImage imageNamed:@"me_girlSex"]];
    [self.womenBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.womenBtn.enabled = NO;
    [self addSubview:self.womenBtn];
    //4.选择图片按钮
    self.selectBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectZero image:[UIImage imageNamed:@"PNVoteCheck"]];
    [self addSubview:self.selectBtn];
    
}
//按钮的方法
-(void)selectedAction:(UIButton *)sender{
    
    
    CGFloat seletedW = sender.frame.size.height/4;
     [UIView animateWithDuration:0.35 animations:^{
         self.selectBtn.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y, seletedW, seletedW);
     }];
    if (sender.frame.origin.x  == 55.0) {
        [_delegate sexViewBack:self sexStr:@"男"];
    }else{
    [_delegate sexViewBack:self sexStr:@"女"];
    
    }

}

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}

-(void)selectShouldClick:(BOOL)isUse{
    
    self.menBtn.enabled = isUse;
    self.womenBtn.enabled =isUse;

}
-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame image:(UIImage *)image{
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setImage:image forState:UIControlStateNormal];
    btn.frame = frame;
    return  btn;
}

@end
