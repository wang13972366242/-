//
//  SelectedPicker.h
//  SaveDataPositionVC
//
//  Created by wang on 16/8/10.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectedPickerDelegate <NSObject>
//选择的那个部门
-(void)selectedPicker:(id)selecteID;


@end

@interface SelectedPicker : UIPickerView<UIPickerViewDelegate>
/** 数组*/
@property(nonatomic,strong) NSMutableArray *departmentArr;
/** 数组*/
@property(nonatomic,strong) NSMutableArray *lastLV;
/** ID*/
@property(nonatomic,strong) NSArray *ID;
/** isDepartment*/
@property(nonatomic,assign) BOOL isDepartment;
/** 代理*/
@property(nonatomic,assign)  id<SelectedPickerDelegate> selectDelegate;
@end
