//
//  SelectedDepartPosition.h
//  SelectDepartmentPosition
//
//  Created by wang on 16/7/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectedDepartPosition;
@protocol SelectedDepartPositionDelegate <NSObject>

-(void )selectDepartment:(NSString *)departmentName;
-(void )selectPosition:(NSString *)positionName;

@end

@interface SelectedDepartPosition : UIView

/** label*/
@property(nonatomic,strong) UILabel *label;
/** isDepartment*/
@property(nonatomic,assign) BOOL isDepartment;
/** 数组*/
@property(nonatomic,strong) NSMutableArray *data;
/** 代理*/
@property(nonatomic,weak) id<SelectedDepartPositionDelegate> delegate;
@end
