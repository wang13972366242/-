//
//  FunctionLeaveAndDutyShift.h
//  Order
//
//  Created by wang on 2016/12/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"

/**
 * 请假或调休的类别
 * <pre>
 * {@linkplain #CASUAL_LEAVE} 事假
 * {@linkplain #ANNUAL_LEAVE} 年假
 * {@linkplain #SICK_LEAVE} 病假
 * {@linkplain #MARRIAGE_LEAVE} 婚假
 * {@linkplain #BEREAVEMENT_LEAVE} 丧假
 * {@linkplain #OFFDUTY_SHIFT} 调休
 * </pre>
 * @author Sophie_WS
 *
 */


typedef enum {
    SUBMITTED,
    APPROVED,
    REJECTED,
}REQUEST_STATUS;

@interface FunctionLeaveAndDutyShift : BaseArgumentList

/** ArrayList<LEAVEORSHIFT_TYPE>*/
@property(nonatomic,strong) NSMutableArray<NSString *> *m_supportedLeaveType;


/**
 * 请假调休相关的配置
 */

-(instancetype)initFunctionLeaveAndDutyShiftWithJsonString:(NSString *)szJsonString;


/**
 * 请假调休的配置对象构造函数
 */

-(instancetype)initFunctionLeaveAndDutyShiftWithLeaveorshift:(NSArray *)arrType;
/**
 * 添加对请假或调休种类的支持
 */

-(void)addLeaveType:(NSArray *)arrTypes;


/**
 * 删除对某个或某些请假类型的支持
 */

-(void)removeLeaveType:(NSArray *)arrTypes;

-(NSString *) toString;
@end
