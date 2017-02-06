//
//  FunctionUserAttendanceConfig.h
//  Order
//
//  Created by wang on 2016/12/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "FunctionUserSwipe.h"
#import "FunctionLeaveAndDutyShift.h"
@interface FunctionUserAttendanceConfig : BaseArgumentList

/** FunctionUserSwipe*/
@property(nonatomic,strong) FunctionUserSwipe *m_objUserSwipeConfig;

/** FunctionLeaveAndDutyShift*/
@property(nonatomic,strong) FunctionLeaveAndDutyShift *m_objLeaveAndDutyShiftConfig;



/**
 * 构造函数 - 客户端在功能管理员创建或者修改配置时应使用的构造函数
 */

-(instancetype)initWithFunctionUserSwipe:(FunctionUserSwipe *)objUserSwipeConfig leaveAndDutyShift:(FunctionLeaveAndDutyShift *)objLeaveAndDutyShiftConfig;

-(instancetype)initFunctionUserAttendanceConfigWith:(NSString *)szJsonString;

-(NSString *)toString;

-(BOOL)isValid;
@end
