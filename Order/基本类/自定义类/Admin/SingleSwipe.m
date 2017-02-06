//
//  SingleSwipe.m
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SingleSwipe.h"

@implementation SingleSwipe


-(NSMutableArray<SingleSwipeRule *> *)m_liSingleSwipRules{
    if (_m_liSingleSwipRules == nil) {
        _m_liSingleSwipRules =[NSMutableArray array];
    }
    return _m_liSingleSwipRules;
}
/**
 * 单次刷卡配置数据对象
 * @param szDescription 刷卡配置名字
 * @param rules 有效性检测的RULE的数组
 * @throws OrganizedException  参数有误；
 */
-(instancetype)initSingleSwipeWithDescription:(NSString *)szDescription songleSules:(NSArray<SingleSwipeRule *> *)rules{
    
    if (self = [super init]) {
        _m_szSwipeDescription = szDescription;
        if(rules != nil) _m_liSingleSwipRules = (NSMutableArray *)rules;
    }
  

    if ([self isValid]) {
        return self;
    }else{
        return  nil;
    }
}

-(instancetype)initSingleSwipWithJsonString:(NSString *)szJsonString{
    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:szJsonString];
    return  [self initSingleSwipeWithDic:dic];

}

-(instancetype)initSingleSwipeWithDic:(NSDictionary *)object{

    if (object == nil || object.count == 0) {
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_WRONGARGUMENT" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
    
    if (self = [super init]) {
        NSArray<NSString *> *keys =  [object allKeys];
        
        for(NSString *szKey in keys){
            if ([szKey isEqualToString:@"SWIPENAME"]) {
               _m_szSwipeDescription = object[szKey];
            }else if ([szKey isEqualToString:@"SRULE"]){
                NSArray *array = object[szKey];
                if(array != nil && array.count > 0){
//                    for(Object objecttmp in array){
//                        if(objecttmp != null){
//                            SingleSwipeRule *rule = new SingleSwipeRule(objecttmp.toString());
//                            m_liSingleSwipRules.add(rule);
//                        }
//                    }
                }
            
            
            }else if ([szKey isEqualToString:@"DATATYPE"]){
                _m_SwipeDataType =[FunctionUserSwipePublic SWIPEDATATYPEEnum:object[szKey]] ;
                
            }else if ([szKey isEqualToString:@"PARENT"]){
                
                _m_szParentPairSwipeName = object[szKey];
                
            }
        }
      
       
    }
    
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
}




/**
 * 当前的打卡配置中是否有有效性检验的规则设置；
 * @return true-有规则配置；false-无限制条件；
 */
-(BOOL)hasRule{
    if(_m_liSingleSwipRules == nil || _m_liSingleSwipRules.count == 0) return false;
    return true;
}


-(SingleSwipeRule *)_getRule:(BOOL)bBefore{
    if(![self hasRule]) return nil;
    for(SingleSwipeRule *rule in  _m_liSingleSwipRules){
        if(rule.m_etimeCompareRule == (bBefore ? BEFORE : AFTER)){
            return rule;
        }
    }
    return nil;
}

-(void)_setRule:(BOOL)bBefore timeStr:(NSString *)szTimeString{
    SingleSwipeRule *currentRule = [self _getRule:bBefore];
   
    TimeCompare timeCompare = bBefore ? BEFORE:AFTER;
    if(currentRule == nil){
        currentRule = [[SingleSwipeRule alloc]initWithSingleSwipRule:timeCompare sztimeFormatString:szTimeString];
        [self.m_liSingleSwipRules addObject:currentRule];
        
    }else{
        NSCalendar *clrTime = @"";
//        NSCalendar *clrTime = CommonFunctions.timeStringToCalendar(szTimeString);
        currentRule.m_timeSlot =clrTime;
    }
}

-(void)_removeRule:(BOOL) bBefore{
    SingleSwipeRule *rule = [self _getRule:bBefore ];
    if(rule != nil){
        [_m_liSingleSwipRules removeObject:rule];
        
    }
}

/**
 * 设置打卡有效性检测规则 - 打卡时间需早于设置的时间点才有效；
 * <pre>
 * 1. 如果规则之前不存在，则按照参数创建一条限制规则；
 * 2. 如果规则存在，则按指定参数修改；
 * </pre>
 * @param szTimeString - 符合条件的时间规则，24小时制，如"9:00,9:45:34,18:00,18:30:25"等；秒针指数可以带也可不带；
 * @throws OrganizedException - 非符合条件的时间字符串，无法解析成calendar则抛出异常；
 */

-(void)setBeforeRule:(NSString *) szTimeString{
    [self _setRule:true timeStr:szTimeString];
}


/**
 * 获取大于时间规则的具体时间的字符串格式；
 * @return 大于时间规则的具体时间的字符串格式；
 */
-(NSString *)getBeforeRuleTime{
    SingleSwipeRule *getRule =  [self _getRule:true];
    
    return getRule == nil ? nil : getRule.getTimeSlot;
}

/**
 * 获取之后时间规则的具体时间的字符串格式；
 * @return 之后时间规则的具体时间的字符串格式；
 */
-(NSString *)getAfterRuleTime{
    SingleSwipeRule *getRule = [self _getRule:false];
    return getRule == nil ? nil : getRule.getTimeSlot;
}

/**
 * 设置打卡有效性检测规则 - 打卡时间需晚于设置的时间点才有效；
 * <pre>
 * 1. 如果规则之前不存在，则按照参数创建一条限制规则；
 * 2. 如果规则存在，则按指定参数修改；
 * </pre>
 * @param szTimeString - 符合条件的时间规则，24小时制，如"9:00,9:45:34,18:00,18:30:25"等；秒针指数可以带也可不带；
 * @throws OrganizedException - 非符合条件的时间字符串，无法解析成calendar则抛出异常；
 */
-(void)setAfterRule:(NSString  *)szTimeString{
    [self _setRule:false timeStr:szTimeString];
    
}

/**
 * 删除After限制规则
 */
-(void)removeAfterRule{
    [self _removeRule:false];
}

/**
 * 删除before限制规则；
 */
-(void)removeBeforeRule{
    [self _removeRule:true];
}

/**
 * 删除所有规则
 */
-(void)clearRule{
    if([self hasRule]){
        [_m_liSingleSwipRules removeAllObjects];
    }
}

/**
 * 判断用户刷卡时间点是否为有效时间点；
 * @param clr - 刷卡的时间点
 * @return true - 有效；　false - 无效；
 * @throws OrganizedException clr为空；
 */
-(BOOL)checkRuleOnUserSwipeTime:(NSCalendar *) clr{
    
    if([self hasRule]){
        for(SingleSwipeRule *rule in _m_liSingleSwipRules){
            if([rule isRuleCheckPass:@[clr]]) continue;
            else return false;
        }
    }
    return true;
}

/**
 * 对象是否有效
 * <br> - 名字必须合法
 * <br> - 如果有RULE，则RULE必须有效；
 * @return true - 对象有效；false - 非法对象；
 *
 */

-(BOOL)isValid{
    
    if(![FunctionUserSwipePublic _isValidSwipeName:@[_m_szSwipeDescription]] ){
        return false;
    }
    if((_m_SwipeDataType != SINGLE && _m_szParentPairSwipeName == nil ) ||
       (_m_SwipeDataType == SINGLE && _m_szParentPairSwipeName != nil)){
        return false;
    }
    
    if(_m_liSingleSwipRules != nil ){
        for(SingleSwipeRule *rule in _m_liSingleSwipRules){
            if(![rule isValid]) return false;
        }
    }
    return true;
}


//-(UserSwipe *)_onUserSwipe:(UserBean *)userBean type:(SWIPENODETYPE)type swipName:(NSString *)szSwipeNodeName{
//    SWIPEDATATYPE dataType = _m_SwipeDataType;
//    NSString *szUserSwipeName = dataType == @"SINGLE" ? getName():_m_szParentPairSwipeName;
//    UserSwipe *swipedata = new UserSwipe(userBean, type, szSwipeNodeName, dataType,szUserSwipeName, Calendar.getInstance());
//    if(swipedata.isValid()){
//        return swipedata;
//    }
//    throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_USERDATACHECKVALIDFAIL);
//}


-(NSString *)toString{
    
    if(![self isValid]) return nil;
    NSDictionary *object = [self toJsonObject];
    if(object == nil) return nil;
    NSString *str = [CommonFunctions functionsFromObjectToJsonString:object];
    return str;
}

//==============================私有函数==============================
-(NSDictionary *)toJsonObject{
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    if([CommonFunctions functionsIsStringValid:_m_szSwipeDescription]){
        [object setObject:_m_szSwipeDescription forKey:@"SWIPENAME"];
        
    }
    if(_m_liSingleSwipRules != nil && _m_liSingleSwipRules.count > 0){
        NSMutableArray *array = [NSMutableArray array];
        for(SingleSwipeRule *rule in _m_liSingleSwipRules){
            [array addObject:[rule toString]];
            
        }
        [object setObject:array forKey:@"SRULE"];

    }
    
    if(!_m_SwipeDataType ){
        NSString *str = [FunctionUserSwipePublic SWIPEDATATYPEString:_m_SwipeDataType];
        
        [object setObject:str forKey:@"DATATYPE"];
    }
    if([CommonFunctions functionsIsStringValid:_m_szParentPairSwipeName]){
        [object setObject:_m_szParentPairSwipeName forKey:@"PARENT"];
    }
    if(object.count == 0) return nil;
    return object;
}



-(UserSwipe *)_onUserSwipe:(UserBean *)userBean type:(SWIPENODETYPE)type swipName:(NSString *) szSwipeNodeName{
    
    
    NSString *szUserSwipeName = _m_SwipeDataType == SINGLE ? NSStringFromClass([self class]):_m_szParentPairSwipeName;
    UserSwipe *swipedata = [[UserSwipe alloc]initUserSwipeWithUserBean:userBean swipType:type NodeName:szSwipeNodeName datatype:_m_SwipeDataType swipeName:szUserSwipeName cld:[NSCalendar currentCalendar]];
    
    if([swipedata isValid]){
        return swipedata;
    }
    return nil;
}



@end
