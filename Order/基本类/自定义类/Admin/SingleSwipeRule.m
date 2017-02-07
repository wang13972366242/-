//
//  SingleSwipeRule.m
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SingleSwipeRule.h"

@implementation SingleSwipeRule

-(TimeValidArea)m_eTimeValid{
    
    if (!_m_eTimeValid) {
        return _m_eTimeValid = TIMEONLY;
    }else{
        return  _m_eTimeValid;
    }
}


-(instancetype)initWithSwipRuleTimeArea:(TimeValidArea)tmvld timeCompare:(TimeCompare)tmCmp  cld:(NSDate*)clr{
    if (self = [super init]) {
        _m_eTimeValid = tmvld;
        _m_etimeCompareRule = tmCmp;
        _m_timeSlot = clr;
    }
    
    if ([self isValid]) {
        return self;
    }else{
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_WRONGARGUMENT" reason:@"nil" userInfo:nil];
        [Ce raise];
        return nil;
    }
    
}


/**
 * 创建一个每日的单次打卡规则（仅时间有效）
 * @param tmCmp 此参数决定了：对于给定的时间点，规则是在其前面打卡有效，还是在其后面打卡有效
 * @param szTimeFormatString  符合时间格式的数据，如"09:00:00, 08:35, 21:45:03”, 等
 * @throws OrganizedException - 参数格式出错，抛出异常
 */

-(instancetype)initWithSingleSwipRule:(TimeCompare)tmCmp sztimeFormatString:(NSString *)szTimeFormatString{
#warning -mark  时间
    return  [self initWithSwipRuleTimeArea:TIMEONLY timeCompare:tmCmp cld:nil];
    
    
}

-(instancetype)initSingleSipeWithJsonString:(NSString *)jsonStr{
    
    NSMutableDictionary *dic = (NSMutableDictionary *)[CommonFunctions functionsFromJsonStringToObject:jsonStr];
    return  [self initSingleSwipeDic:dic];
    
}

-(instancetype)initSingleSwipeDic:(NSMutableDictionary *)object{
    if (object == nil || object.count == 0 ||![[object allKeys] containsObject:@"TMVLD"]) {
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_SINGLESWIPERULE_INVALID" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
#pragma -mark ----------------------------------------------------------------------------------------------------------------------------------------------------
    if (self = [super init]) {
        NSString *str  = object[@"TMVLD"];
        _m_eTimeValid = [FunctionUserSwipePublic TimeValidAreaEnum:str];
        [object removeObjectForKey:@"TMVLD"];
        @try {
            NSString *szKey = [object allKeys][0];
            _m_etimeCompareRule = [FunctionUserSwipePublic TimeCompareEnum:szKey];
            switch (_m_eTimeValid) {
                case TIMEONLY:
//                    _m_timeSlot = [CommonFunctions timeStringToCalendar:object[szKey);
                    break;
                case DATETIME:
                    
//                    _m_timeSlot = [CommonFunctions dateTimeStringToCalendar:];
                    break;
                default:
                    break;
            }

        } @catch (NSException *exception) {
            
        }
      
 
        
    }
    return self;
}

//public SingleSwipeRule(JSONObject object) throws OrganizedException{
//    if(object == null || object.length() == 0 || !object.has("TMVLD") || object.length() != 2){
//        throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_SINGLESWIPERULE_INVALID);
//    }
//
//    m_eTimeValid = object.getEnum(TimeValidArea.class, "TMVLD");
//    object.remove("TMVLD");
//    try{
//        String szKey = JSONObject.getNames(object)[0];
//        m_etimeCompareRule = TimeCompare.valueOf(szKey);
//        switch (m_eTimeValid) {
//            case TIMEONLY:
//                m_timeSlot = CommonFunctions.timeStringToCalendar(object.getString(szKey));
//                break;
//            case DATETIME:
//                m_timeSlot = CommonFunctions.dateTimeStringToCalendar(object.getString(szKey));
//                break;
//            default:
//        }
//    }catch(Exception e){
//        throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_SINGLESWIPERULE_INVALID);
//    }
//    checkValid(this);
//}
//


-(BOOL)isValid{
    if(!self.m_etimeCompareRule  ||!_m_timeSlot  || !self.m_eTimeValid ) return false;
    else return true;
}

-(NSString *)toString{
    if(![self isValid]) return nil;
    NSDictionary *object = [self toJsonObject];
    if(object != nil) return [CommonFunctions functionsFromObjectToJsonString:object];
    return nil;
    
    
}


-(NSMutableDictionary *)toJsonObject{
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    if(_m_eTimeValid ){
        NSString *timeBalid = [FunctionUserSwipePublic TimeValidAreaString:_m_eTimeValid];
        [object addEntriesFromDictionary:@{@"TMVLD":timeBalid}];
        
    }
    
    if(self.m_etimeCompareRule &&  self.m_timeSlot != nil ){
        switch (_m_eTimeValid) {
            case TIMEONLY:
                //                NSString *ruleString = [FunctionUserSwipePublic TimeCompareString:_m_etimeCompareRule];
#warning  -mark 错误
                [object addEntriesFromDictionary:@{[FunctionUserSwipePublic TimeCompareString:_m_etimeCompareRule]:[CommonFunctions calendarToTimeString:_m_timeSlot]}];
                
                break;
            case DATETIME:
                
                [object addEntriesFromDictionary:@{[FunctionUserSwipePublic TimeCompareString:_m_etimeCompareRule]:[CommonFunctions calendarToDateTimeString:_m_timeSlot]}];
                
                break;
            default:
                break;
        }
        
    }
    return object;
}


-(NSString *)getTimeSlot{
    switch (_m_eTimeValid) {
        case TIMEONLY:
            return[CommonFunctions calendarToTimeString:_m_timeSlot];
        case DATETIME:
            return [CommonFunctions calendarToDateTimeString:_m_timeSlot];
            
        default:
            return nil;
    }
}

-(BOOL)isRuleConflict:(CheckRule * )rule1 {
    if (![rule1 isMemberOfClass:[self class]]) {
        return false;
    }
    SingleSwipeRule *singleRule = (SingleSwipeRule *)rule1;
    if (_m_eTimeValid != singleRule.m_etimeCompareRule || _m_etimeCompareRule ==singleRule.m_etimeCompareRule) {
        return true;
    }
  
    NSDate *clrtmp = [self _adjustArgumentPerTimeValid:singleRule.m_timeSlot];
    if(_m_etimeCompareRule == BEFORE){
//        if(clrtmp.after(m_timeSlot)) return true;
    }else{
//        if(clrtmp.before(m_timeSlot)) return true;
    }
    return false;
}

-(NSDate *)_adjustArgumentPerTimeValid:(NSDate *)clinput{
    if(clinput == nil) return nil;
    
    return nil;
}

@end
