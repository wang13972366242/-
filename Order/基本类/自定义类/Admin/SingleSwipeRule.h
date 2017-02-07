
//
//  SingleSwipeRule.h
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CheckRule.h"

@interface SingleSwipeRule : CheckRule

/** 时间的有效范围*/
@property(nonatomic,assign) TimeValidArea m_eTimeValid;
/**时间对比*/
@property(nonatomic,assign)TimeCompare  m_etimeCompareRule;
/** 日期*/
@property(nonatomic,strong) NSDate *m_timeSlot;


-(instancetype)initWithSwipRuleTimeArea:(TimeValidArea)tmvld timeCompare:(TimeCompare)tmCmp  cld:(NSDate*)clr;

/**
 * 创建一个每日的单次打卡规则（仅时间有效）
 */

-(instancetype)initWithSingleSwipRule:(TimeCompare)tmCmp sztimeFormatString:(NSString *)szTimeFormatString;


-(BOOL)isValid;
-(NSString *)toString;

-(NSString *)getTimeSlot;
@end
