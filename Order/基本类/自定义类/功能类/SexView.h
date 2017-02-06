//
//  SexView.h
//  SexButton
//
//  Created by wang on 16/7/24.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SexView;

@protocol SexViewDelegate <NSObject>

-(void )sexViewBack:(SexView *)sexV sexStr:(NSString *)sex;
@end

@interface SexView : UIView

-(void)selectShouldClick:(BOOL)isUse;

/** 代理*/
@property(nonatomic,weak) id<SexViewDelegate> delegate;
@end
