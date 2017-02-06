//
//  WQAddressView.h
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WQAddressView;
@protocol AddressViewDelegate <NSObject>

-(void)addressViewCreatSelf:(WQAddressView *)addressView addBtn:(UIButton *)addBtn;

@end

@interface WQAddressView : UIView<UITextFieldDelegate>

/** 地址label*/
@property(nonatomic,strong) UILabel *addressLabel;
/** 输入框*/
@property(nonatomic,strong) UITextField *textTF;
/** *label*/
@property(nonatomic,strong) UILabel *starLabel;
/** +按钮*/
@property(nonatomic,strong) UIButton *addBtn;
/** 代理*/
@property(nonatomic,weak) id<AddressViewDelegate> delegate;

@end
