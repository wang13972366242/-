//
//  SingleSwipe.h
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "SingleSwipeRule.h"
#import "UserSwipe.h"
@interface SingleSwipe : BaseArgumentList

/** 打卡描述*/
@property(nonatomic,strong) NSString *m_szSwipeDescription;

/** 单次打卡规则*/
@property(nonatomic,strong) NSMutableArray<SingleSwipeRule *> *m_liSingleSwipRules;

/** SWIPEDATATYPE*/
@property(nonatomic,assign) SWIPEDATATYPE m_SwipeDataType;

/** ParentPairSwipeName*/
@property(nonatomic,strong) NSString *m_szParentPairSwipeName;


-(BOOL)isValid;


/**
 * 单次刷卡配置数据对象
 */
-(instancetype)initSingleSwipeWithDescription:(NSString *)szDescription songleSules:(NSArray<SingleSwipeRule *> *)rules;

-(instancetype)initSingleSwipWithJsonString:(NSString *)szJsonString;

-(BOOL)hasRule;


-(SingleSwipeRule *)_getRule:(BOOL)bBefore;


-(void)_setRule:(BOOL)bBefore timeStr:(NSString *)szTimeString;

-(void)_removeRule:(BOOL) bBefore;

/**
 * 设置打卡有效性检测规则 - 打卡时间需早于设置的时间点才有效；
 */

-(void)setBeforeRule:(NSString *) szTimeString;


/**
 * 获取大于时间规则的具体时间的字符串格式；
 * @return 大于时间规则的具体时间的字符串格式；
 */
-(NSString *)getBeforeRuleTime;

/**
 * 获取之后时间规则的具体时间的字符串格式；
 */
-(NSString *)getAfterRuleTime;


/**
 * 设置打卡有效性检测规则 - 打卡时间需晚于设置的时间点才有效
 */
-(void)setAfterRule:(NSString  *)szTimeString;

/**
 * 删除After限制规则
 */
-(void)removeAfterRule;


/**
 * 删除before限制规则；
 */
-(void)removeBeforeRule;

-(NSString *)toString;


/**
 * 删除所有规则
 */
-(void)clearRule;

/**
 * 判断用户刷卡时间点是否为有效时间点；
 */
-(BOOL)checkRuleOnUserSwipeTime:(NSDate *) clr;

-(UserSwipe *)_onUserSwipe:(UserBean *)userBean type:(SWIPENODETYPE)type swipName:(NSString *) szSwipeNodeName;
@end
