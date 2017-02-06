//
//  WQTMeChangeCell.m
//  Order
//
//  Created by wang on 16/7/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQTMeChangeCell.h"
#import "WQVeritViewController.h"
#import "WQVeritEmailController.h"
@interface WQTMeChangeCell()<UITextFieldDelegate,veritIphoneDelegate,veritEmailDelegate>

@end
@implementation WQTMeChangeCell

-(instancetype)meChangeCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame{
    WQTMeChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQTMeChangeCell alloc] initWithFrame:frame];
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
    
     
    self.bgImageV = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_bgImageV];
    self.titleImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    self.bgImageV.userInteractionEnabled = YES;
    [self.bgImageV addSubview:self.titleImg];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = Color(17, 17, 17, 1);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.bgImageV addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.textColor = Color(123, 123, 123, 1);
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.font = [UIFont systemFontOfSize:17];
    self.contentLabel.numberOfLines = 0;
    [self.bgImageV addSubview:self.contentLabel];

    self.contentTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.bgImageV addSubview:self.contentTextField];
    self.contentTextField.textColor = [UIColor blueColor];
    self.contentTextField.hidden = YES;
    
    self.contentTextField.delegate = self;
    
    self.verifBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _verifBtn.frame = CGRectZero;
    [_verifBtn addTarget:self action:@selector(veriAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageV addSubview:self.verifBtn];
    
}

- (void)setAllowEdit:(BOOL)allowEdit
{
    
    _allowEdit = allowEdit;
    _contentLabel.hidden = allowEdit;
    _contentTextField.hidden = !allowEdit;
    if (allowEdit == YES) {
        _contentTextField.text = _contentLabel.text;
     
    } else {
        
    }
    [self setNeedsLayout];
}
-(void)setIsVerif:(BOOL)isVerif{
    //如果允许验证  按钮可以被点击   //如果不允许验证 按钮不能被点击
    _isVerif = isVerif;
    
    if (isVerif == YES) {
        self.verifBtn.enabled = YES;
        [self.verifBtn setBackgroundImage:[UIImage imageNamed:@"work_image_security_icon"] forState:UIControlStateNormal];
    }else{
        self.verifBtn.enabled = NO;
    }
    


}
-(void)layoutSubviews{

    [super layoutSubviews];
    CGRect selfRect = self.frame;
    _bgImageV.frame = CGRectMake(5, 5, selfRect.size.width  - 10, selfRect.size.height -10);

    CGFloat titleImgX = 5.0f;
    CGFloat titleImgY = 5.0f;
    CGFloat titleImgW = _bgImageV.frame.size.height - 2*titleImgY;
    
    _titleImg.frame = CGRectMake(titleImgX, titleImgY, titleImgW, titleImgW);
    CGFloat  verifBtnY = 10;
    CGFloat  verifBtnW = _bgImageV.frame.size.height - 2*verifBtnY;
    CGFloat  verifBtnX = _bgImageV.frame.size.width -verifBtnW -20;
    
    _verifBtn.frame = CGRectMake(verifBtnX, verifBtnY, verifBtnW, verifBtnW);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGRect rect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.width, 9999)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributes
                                                     context:nil];
    
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.titleImg.frame)+5, titleImgY,rect.size.width, titleImgW);
    

    CGRect textRect = CGRectMake(self.titleLabel.right+10, titleImgY, KScreenWidth - CGRectGetMinX(self.titleLabel.frame)-20-10-3, titleImgW);
    if (_allowEdit) {
        self.contentTextField.frame = textRect;
        self.contentLabel.frame = CGRectZero;
    } else {
        self.contentTextField.frame = CGRectZero;
        self.contentLabel.frame = textRect;
    }
  
}

/**
 *  验证按钮
 *  点击验证按钮 判断 如果self.titleLabel  == “电话” 1.弹出电话验证的界面
 *                  如果self.titleLabel  == “邮箱” 1.弹出邮箱验证的界面
 */
-(void)veriAction:(UIButton *)sender{
   
    if ([self.titleLabel.text isEqualToString:@"电话"]) {
        WQVeritViewController *veriVC = [WQVeritViewController shareStortyMobile];
        veriVC.delagate = self;
    [[self respondForController].navigationController pushViewController:veriVC animated:YES];
    }else if ([self.titleLabel.text isEqualToString:@"邮箱"]){
    
        WQVeritEmailController *emailVC = [WQVeritEmailController shareStortyEmial];
        emailVC.delagate = self;
        [[self respondForController].navigationController pushViewController:emailVC animated:YES];
    
    }
    
}

#pragma mark - 邮箱手机验证
-(void)veritEmailControllerClickSureBtn:(NSString *)Email{
    if ([self.titleLabel.text isEqualToString:@"邮箱"]) {
        self.contentLabel.text = Email;
        
    }else{
        self.contentLabel.text = nil;
    
    }
    

}
-(void)veritViewControllerClickSureBtn:(NSString *)number{
    if ([self.titleLabel.text isEqualToString:@"电话"]) {
        self.contentLabel.text = number;
        
    }else{
        self.contentLabel.text = nil;
        
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(WQTMeChangeCell:didEndEdit:)]) {
        [self.delegate WQTMeChangeCell:self didEndEdit:textField.text];
    }
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
