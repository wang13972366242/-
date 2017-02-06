//
//  SelectedView.h
//  copyWritePick
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectedView;
@protocol SelectedViewDelegate <NSObject>

- (void)clickCollection: (SelectedView *)selecetView didSelected: (NSString *)fieldText;

@end

@interface SelectedView : UIView

/** 代理*/
@property(nonatomic,assign) id<SelectedViewDelegate> selectedDelegate;
/** 传递过来的数据*/
@property(nonatomic,strong) NSArray *numberArr;
@end
