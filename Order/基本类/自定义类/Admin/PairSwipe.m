//
//  PairSwipe.m
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "PairSwipe.h"

@implementation PairSwipe

-(NSMutableArray<DoubleSwipeRule *> *)m_liDoubleSwipRules{

    if (_m_liDoubleSwipRules == nil) {
        _m_liDoubleSwipRules = [NSMutableArray  array];
    }
    return _m_liDoubleSwipRules;
}


/**
 * 根据两次单打卡配置，合并成一个打卡对，打卡对中，LAST SINGLE SWIPE中定义的时间需晚于第一个；
 * @param singleConfigFirst - 打卡对的第一个
 * @param singleConfigSecond - 打卡对的第二个
 * @throws OrganizedException - 参数非法抛出异常；
 */
-(instancetype)initPairSwipeWithFirstS:(SingleSwipe*)singleConfigFirst sencodS:(SingleSwipe *)singleConfigSecond{
    if (self = [super init]) {
        _m_fisrtSwipe =singleConfigFirst;
        _m_lastSwipe = singleConfigSecond;
        if ([_m_fisrtSwipe isValid] &&[_m_lastSwipe isValid]) {
            _m_fisrtSwipe.m_SwipeDataType =DOUBLEFIRST;
            _m_fisrtSwipe.m_szParentPairSwipeName = [self getVirtualName];
            
            _m_lastSwipe.m_SwipeDataType =DOUBLELAST;
            _m_lastSwipe.m_szParentPairSwipeName = [self getVirtualName];
        }
        
    }
    return self;
}

/**
 * 创建一个 两次刷卡 对象，根据刷卡名字创建。
 * <br>默认两次刷卡都没有限制条件；
 * @param szFirstSwipeName - 第一次刷卡名字 （如，上下班卡，则对应此参数为：上班）；
 * @param szLastSwipeName - 最后一次刷卡的名字 （如，上下班卡，则对应此参数为：下班）；
 * @throws OrganizedException - 名字不合法抛出异常；
 *
 */

-(instancetype)initpairSwipeWithFirstName:(NSString *)szFirstSwipeName lastSwipName:(NSString *)szLastSwipeName{

    SingleSwipe *firstSwipe = [[SingleSwipe alloc]initSingleSwipeWithDescription:szFirstSwipeName songleSules:nil];
    
    SingleSwipe *sencodSwipe = [[SingleSwipe alloc]initSingleSwipeWithDescription:szLastSwipeName songleSules:nil];
    return  [self initPairSwipeWithFirstS:firstSwipe sencodS:sencodSwipe];

}



-(instancetype)initPairSwipWithJson:(NSString *)josnString{

    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:josnString];
    return  [self initPairSwipWihWithDic:dic];
}


-(instancetype)initPairSwipWihWithDic:(NSDictionary *)object{
    if (self = [super init]) {
        if(object == nil || object.count == 0){
            return nil;
        }
        NSArray<NSString *> *keys = [object allKeys];
        
        for(NSString *szKey in keys){
            if ([szKey isEqualToString:@"FIRSGSW"]) {
                _m_fisrtSwipe = [[SingleSwipe alloc]initSingleSwipWithJsonString:object[szKey]];
            }else if ([szKey isEqualToString:@"LSTSGSW"]){
             _m_lastSwipe = [[SingleSwipe alloc]initSingleSwipWithJsonString:object[szKey]];
            }else if ([szKey isEqualToString:@"DRULE"]){
                NSArray *array = object[szKey];
                if(array != nil && array.count > 0){
//                    for(Object objecttmp : array){
//                        if(objecttmp != null){
//                            DoubleSwipeRule rule = new DoubleSwipeRule(objecttmp.toString());
//                            m_liDoubleSwipRules.add(rule);
                        }
                    }

            }
            
    }

        return self;
}


/**
 * 返回刷卡对中的第一条的名字
 * @return 刷卡对中的第一条的名字 ;如果该对象不存在，则返回null;
 */
-(NSString *)getFirstSwipeName{
    return _m_fisrtSwipe == nil ? nil : _m_fisrtSwipe.m_szSwipeDescription;
}


/**
 * 返回刷卡对中的第二条的名字
 * @return 刷卡对中的第二条的名字； 如果该对象不存在，则返回null;
 */
-(NSString *)getLastSwipeName{
    return _m_lastSwipe == nil ? nil : _m_lastSwipe.m_szSwipeDescription;
}

-(SingleSwipe *)findMemberSwipeByName:(NSString *)szName{
    
    if(![FunctionUserSwipePublic _isValidSwipeName:@[szName]] ){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_WRONGARGUMENT" reason:@"Not a valid Swipe Name" userInfo:nil];
        [Ce raise];
    }

    if ([szName isEqualToString:[self getFirstSwipeName]]) {
        return  _m_fisrtSwipe;
    }else if([szName isEqualToString:[self getLastSwipeName]]){
        return _m_lastSwipe;
    
    }
    return nil;
    
    
}


-(BOOL)hasRule{
    if(_m_liDoubleSwipRules == nil || _m_liDoubleSwipRules.count == 0){
        return false;
    }
    return true;
}

-(void)clearRule{
    if([self hasRule]){
        [_m_liDoubleSwipRules removeAllObjects];
    }
}


-(DoubleSwipeRule *)_getRule:(BOOL)bMax{
    if(![self hasRule]) return nil;
    for(DoubleSwipeRule *rule in _m_liDoubleSwipRules){
        if(rule.m_limitType == (bMax ? MAX : MIN)){
            return rule;
        }
    }
    return nil;
}



-(void)_setRule:(BOOL)bMax fhour:(CGFloat)fHour{
    //判断跟另一个时间设置是否冲突
    DoubleSwipeRule *otherRule = [self _getRule:!bMax];
    if(otherRule != nil){
        if((bMax && otherRule.m_fHours >= fHour) || (!bMax && otherRule.m_fHours <= fHour)){
            CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_HOURRULEVALUECONFLICT" reason:@"" userInfo:nil];
            [Ce raise];
        }
    }
    DoubleSwipeRule *currentRule = [self _getRule:bMax];
    TimeIntervalLimit limitshould = bMax ? MAX :MIN;
    if(currentRule == nil){
        currentRule =  [[DoubleSwipeRule alloc]initDoubleRuleWithTimeLimit:limitshould hours:fHour];
        [_m_liDoubleSwipRules addObject:currentRule];
        
    }else{
        currentRule.m_fHours = fHour;
        
    }			
}

-(void)_removeRule:(BOOL)bMax{
    DoubleSwipeRule *rule = [self _getRule:bMax];
    if(rule != nil){
        [_m_liDoubleSwipRules removeObject:rule];
    }
}

-(void)removeMaxRule{
    [self _removeRule:true];
    
}
-(void)removeMinRule{

    [self _removeRule:false];
}



/**
 * 设置最大时间限制规则
 * <pre>
 * 1. 如果规则之前不存在，则按照参数创建一条最大时间限制规则；
 * 2. 如果规则存在，则按参数修改；
 * </pre>
 * @param fHourMax - 最大时间限制
 * @throws OrganizedException 参数无效或者冲突抛出异常；
 */

-(void)setMaxRule:(CGFloat)fHourMax{
    [self _setRule:true fhour:fHourMax];
    
}


/**
 * 获取成对打卡的最大时间间隔小时数
 * @return 成对打卡的最大时间间隔小时数
 */


-(CGFloat)getMaxRuleHour{
    DoubleSwipeRule *getRule = [self _getRule:true];
    return getRule == nil ? 0:getRule.m_fHours;
}

/**
 * 获取成对打卡的最小时间间隔小时数
 * @return 成对打卡的最小时间间隔小时数
 */

-(CGFloat)getMinRuleHour{
    DoubleSwipeRule *getRule = [self _getRule:true];
    return getRule == nil ? 0:getRule.m_fHours;
}

/**
 * 设置最小时间限制规则
 * <pre>
 * 1. 如果规则之前不存在，则按照参数创建一条最小时间限制规则；
 * 2. 如果规则存在，则按参数修改；
 * </pre>
 * @param fHourMin - 打卡有效规则：最小时间间隔
 * @throws OrganizedException - 参数不符合规则抛出异常；
 */

-(void)setMinRule:(CGFloat) fHourMin{
    [self _setRule:false fhour:fHourMin];
}



-(NSString *)getVirtualName{
    if(_m_fisrtSwipe == nil || _m_lastSwipe == nil) return nil;
    return [CommonFunctions functionsJoinString:@":" arr:@[_m_fisrtSwipe.m_szSwipeDescription,_m_lastSwipe.m_szSwipeDescription]];
}


-(BOOL)isValid{
    if(_m_fisrtSwipe == nil || _m_lastSwipe == nil || ![_m_fisrtSwipe isValid] || ![_m_lastSwipe isValid]) return false;

    if([_m_fisrtSwipe.m_szSwipeDescription isEqualToString:_m_lastSwipe.m_szSwipeDescription]) return false;
    
    if(_m_liDoubleSwipRules != nil && _m_liDoubleSwipRules.count > 0){
        for(DoubleSwipeRule *dRule in _m_liDoubleSwipRules){
            if(![dRule isValid]){
                return false;
            }
        }
    }
    return true;
}

/**
 * 判断用户刷卡时间是否为有效时间；
 * @param clrFirst - 第一次打卡时间
 * @param clrLast - 最后一次打卡时间；
 * @return true-有效； false - 无效；
 * @throws OrganizedException 参数异常；
 */

-(BOOL)checkRuleOnUserSwipeTime:(NSDate *)clrFirst last:(NSDate *) clrLast{
    if (![self isValid]) {
        return false;
    }
    
    //先查单次打卡的规则：
    if([_m_fisrtSwipe checkRuleOnUserSwipeTime:clrFirst] == false) return false;
    if([_m_lastSwipe checkRuleOnUserSwipeTime:clrFirst] == false) return false;
    
    //查的是双次打卡专属的rule;
    if([self hasRule]){
        for(DoubleSwipeRule *rule in _m_liDoubleSwipRules){
            if([rule  isRuleCheckPass:@[clrFirst,clrLast]]) continue;
            else return false;
        }
    }
    return true;
}


-(NSString *) toString{
    if(![self isValid]) return nil;
    NSDictionary *object = [self toJsonObject];
    if(object != nil) return [CommonFunctions functionsFromObjectToJsonString:object];
        return nil;
}



-(NSDictionary *)toJsonObject{
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    if(_m_fisrtSwipe != nil){
        [object setObject:[_m_fisrtSwipe toString] forKey:@"FIRSGSW"];
        
    }
    if(_m_lastSwipe != nil){
        [object setObject:[_m_lastSwipe toString] forKey:@"LSTSGSW"];
        
    }
    if(_m_liDoubleSwipRules != nil && _m_liDoubleSwipRules.count > 0){
        NSMutableArray *array = [NSMutableArray array];
        for(DoubleSwipeRule *drule in _m_liDoubleSwipRules){
            [array addObject:[drule toString]];
            
        }
        [object setObject:array forKey:@"DRULE"];
        
    }
    if(object.count > 0) return object;
    return nil;
}


@end
