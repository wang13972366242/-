//
//  DoubleSwipeRule.h
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CheckRule.h"

 static int		MAXHOUR = 24;
@interface DoubleSwipeRule : CheckRule

/** 时间限制*/
@property(nonatomic,assign) TimeIntervalLimit m_limitType;

@property(nonatomic,assign) CGFloat m_fHours;

-(instancetype)initDoubleRuleWithTimeLimit:(TimeIntervalLimit)eLimitType hours:(CGFloat)fHours ;


/**
 * 从JSON格式的字符串恢复成对象；
 */

-(instancetype)initWithDoubleRuleJosn:(NSString *)jsonString;
-(NSString *)toString;

-(BOOL)isRuleCheckPass:(NSArray<NSDate *> *)clrlist;

-(BOOL)isRuleConflict:(CheckRule *)rule1 ;

-(BOOL)isValid;
@end
