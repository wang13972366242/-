//
//  ScanDepartmentCell.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ScanDepartmentCell.h"
#import "UIViewExt.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation ScanDepartmentCell

-(instancetype)ScanDepartmentCell:(UITableView *)tableView WithIdentifier:(NSString *)ID {
    ScanDepartmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ScanDepartmentCell alloc] init];
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
    _scrollView = [[UIScrollView  alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:_scrollView];
    _themeLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:14.0] textColor:[UIColor blackColor] text:nil];
    [_scrollView addSubview:_themeLabel];
    /** 详细Label*/
    _detailLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12.0f] textColor:[UIColor blackColor] text:nil];
    [_scrollView addSubview:_detailLabel];
    /** 右边一个按钮*/
    _rightBtn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectZero title:nil titleColor:nil];
    [_rightBtn addTarget:self action:@selector(pushActin:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setImage:[UIImage imageNamed:@"shang_arrow0001"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_rightBtn];
    
}


-(void)setID:(NSMutableArray *)ID{

    _ID =ID;
    [self setNeedsLayout];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat themeLabelH = 25.f;
    CGFloat themeLabelW = self.bounds.size.width - 60;
    CGFloat  themeLabelX = 0.f +20 *self.ID.count;
    CGFloat  themeLabelY = 5.f;
    self.themeLabel.frame = CGRectMake(themeLabelX, themeLabelY,themeLabelW, themeLabelH);
    
    CGFloat  detailLabelY = 30.f;
    self.detailLabel.frame = CGRectMake(themeLabelX,detailLabelY, themeLabelW, themeLabelH -5);
    
    CGFloat rightBtnX = self.bounds.size.width - 55;
    CGFloat rightBtnW = 44;
    CGFloat rightBtnY = (self.bounds.size.height -44)/2;
    self.rightBtn.frame = CGRectMake(rightBtnX, rightBtnY, rightBtnW ,rightBtnW);
}

-(void)pushActin:(UIButton *)sender{
    
    [_btnDeleate scanDepartmentButtonAction:self];
}

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}
-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.frame = frame;
    return  btn;
}


@end
