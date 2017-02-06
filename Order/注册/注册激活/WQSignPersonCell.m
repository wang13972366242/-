//
//  WQSignPersonCell.m
//  Order
//
//  Created by wang on 16/7/22.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQSignPersonCell.h"
#import "CommonFunctions.h"
@implementation WQSignPersonCell

-(instancetype)signPersonCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame{
    WQSignPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQSignPersonCell alloc] initWithFrame:frame];
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
    
    _btn = [self creatButtonWithUIButtonType:UIButtonTypeCustom frame:CGRectZero title:nil titleColor:[UIColor blackColor]];
    _btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
  
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    

    
    self.label.frame = CGRectMake(5, 5,80, self.height);
    
    if ([self.titt isEqualToString:@"电话:"] ||[self.titt isEqualToString:@"邮箱:"]) {
        _textF.frame = CGRectMake(self.label.right, 5, KScreenWidth - self.label.width -20-80, 30);
        _btn.frame  = CGRectMake(_textF.right+5, 5, 70, 30);
        
    }else{
    _textF.frame = CGRectMake(self.label.right, 5, KScreenWidth - self.label.width -20, 30);
    }
    
    
}

-(void)setTitt:(NSString *)titt{

    if (_titt != titt) {
        _titt = titt;
    }
    self.label.text = titt;
    if ([self.titt isEqualToString:@"电话:"] ) {
        
        _btn.tag = 110;
    }else if ([self.titt isEqualToString:@"邮箱:"]){
        _btn.tag = 100;
    
    
    }
    [_btn setTitle:@"获取激活码" forState:UIControlStateNormal];
    
  
   
    [self setNeedsLayout];
    
}


-(void)btnAction:(UIButton *)sender{
    if (_btn.tag == 110) {
        [self mobileAction:sender];
    }else if (_btn.tag == 100){
        [self emailAFnet:sender];
    }


}

-(void)emailAFnet:(UIButton *)btn{

    if (![CommonFunctions functionsIsValidEmail:_textF.text]) {
        [self alertControllerShowWithTheme:@"邮箱格式错误" suretitle:@"确认"];
        return;
    }
    NSDictionary *dic = [OrganizedClientMessage IsBeingUsedcheckType:COMPANY_EMAIL pamar:_textF.text uniqueID:nil];
    if (dic == nil) {
        [self alertControllerShowWithTheme:@"无效邮箱" suretitle:@"确认"];
    }else {
        [CommonFunctions functionsOpenCountdown:btn time:90];
        [BWNetWorkToll AFNetCheck:dic verWay:COMPANY_EMAIL viewController:[self respondForController] emialOrMobile:_textF.text];
    }
    
    
    
}

-(void)mobileAction:(UIButton *)btn{
    
    if (![CommonFunctions functionsIsMobile:_textF.text]) {
        [self alertControllerShowWithTheme:@"手机格式错误" suretitle:@"确认"];
        return;
    }
    
    NSDictionary *dic = [OrganizedClientMessage IsBeingUsedcheckType:COMPANY_MOBILE pamar:_textF.text uniqueID:nil];
    if (dic == nil) {
        [self alertControllerShowWithTheme:@"无效手机" suretitle:@"确认"];
    }else {
        [CommonFunctions functionsOpenCountdown:btn time:90];
        
        [BWNetWorkToll AFNetCheck:dic verWay:COMPANY_MOBILE viewController:[self  respondForController] emialOrMobile:_textF.text];
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
-(UIButton *)creatButtonWithUIButtonType:(UIButtonType)UIButtonType frame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    btn.frame = frame;
    return  btn;
}

#pragma mark -UIAlertController
-(void)alertControllerShowWithTheme:(NSString *)themeTitle suretitle:(NSString *)suretitle{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:themeTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[self respondForController].navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [alertC addAction:sureAction];
    [[self respondForController].navigationController presentViewController:alertC animated:YES completion:nil];
    
}

- (UIViewController *)respondForController {
    
    UIResponder *next = self.nextResponder;
    
    // 只要响应者链上，还有下一级响应者，就一直查找
    do {
        // 判断获取的响应者对象是否是 视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            //
            // 返回查找到的视图控制器
            return (UIViewController *)next;;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    
    return nil;
}

@end
