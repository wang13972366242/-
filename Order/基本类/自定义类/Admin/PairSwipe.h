//
//  PairSwipe.h
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "SingleSwipe.h"
#import "DoubleSwipeRule.h"
@interface PairSwipe : BaseArgumentList

/** SingleSwipe*/
@property(nonatomic,strong) SingleSwipe *m_fisrtSwipe;

@property(nonatomic,strong) SingleSwipe *m_lastSwipe;

/** */
@property(nonatomic,strong) NSMutableArray<DoubleSwipeRule *> *m_liDoubleSwipRules;

/**
 * 根据两次单打卡配置，合并成一个打卡对，打卡对中，LAST SINGLE SWIPE中定义的时间需晚于第一个；
 */
-(instancetype)initPairSwipeWithFirstS:(SingleSwipe*)singleConfigFirst sencodS:(SingleSwipe *)singleConfigSecond;

/**
 * 创建一个 两次刷卡 对象，根据刷卡名字创建。
 *
 */

-(instancetype)initpairSwipeWithFirstName:(NSString *)szFirstSwipeName lastSwipName:(NSString *)szLastSwipeName;

-(BOOL)isValid;

-(void)clearRule;


-(void)removeMaxRule;

-(void)removeMinRule;



-(CGFloat)getMaxRuleHour;
/**
 * 获取成对打卡的最小时间间隔小时
 */

-(CGFloat)getMinRuleHour;

-(DoubleSwipeRule *)_getRule:(BOOL)bMax;

-(NSString *) toString;

-(SingleSwipe *)findMemberSwipeByName:(NSString *)szName;
@end
