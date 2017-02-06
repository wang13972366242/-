//
//  PositionView.h
//  Digui
//
//  Created by wang on 16/7/10.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PositionView;
@class RightTableView;
@class LeftTableView;

@protocol PositionViewDelegate <NSObject>


- (void)PositionViewClickCompleteBtn:(PositionView *)subView;

- (void)PositionViewClickBacek:(PositionView *)subView;

@end

@interface PositionView : UIView
@property(nonatomic,strong) NSMutableArray *departmentID;
/** 标题*/
@property(nonatomic,strong) UILabel *titleLabel;
/** 代理*/
@property(nonatomic,weak) id<PositionViewDelegate> delagte;

/** 右边tableview*/
@property(nonatomic,strong) RightTableView *rightcontentV;
/** 左边tableview*/
@property(nonatomic,strong) LeftTableView *leftcontentV;
/** 是否是第一个*/
@property(nonatomic,assign) BOOL isFirst;
@property(nonatomic,strong) NSString *titlStr;
/**
 *  左边返回按钮
 */
@property(strong,nonatomic) UIButton *backBtn;
/** 右边返回按钮*/
@property(nonatomic,strong) UIButton *rihgtBtn;

@end
