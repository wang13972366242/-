//
//  DoubleSwipeRule.m
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "DoubleSwipeRule.h"

@implementation DoubleSwipeRule

-(instancetype)initDoubleRuleWithTimeLimit:(TimeIntervalLimit)eLimitType hours:(CGFloat)fHours {
    if (self = [super init]) {
        _m_limitType = eLimitType;
        _m_fHours = fHours;
    }
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
}


/**
 * 从JSON格式的字符串恢复成对象；
 * @param szJsonString 符合格式的jsonString
 * @throws JSONException 如果参数格式不正确，不符合JSON格式，则抛出异常；
 * @throws OrganizedException 如果JSON串不符合对象的JSON形式，则抛出异常；
 */

-(instancetype)initWithDoubleRuleJosn:(NSString *)jsonString{
    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:jsonString];
    return [self initWithDoubleRuleDic:dic];
}


-(instancetype)initWithDoubleRuleDic:(NSDictionary *)object{

    if(object == nil || object.count == 0 || object.count != 1){
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_NOTVALIDJSONSTRING" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
    if (self = [super init]) {
        @try {
    
            NSString *szKey = [object allKeys][0];

            _m_limitType = [FunctionUserSwipePublic TimeIntervalLimitEnum:szKey];
            
            _m_fHours =  [object[szKey] floatValue]/100.0f; //恢复float
        } @catch (NSException *exception) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_NOTVALIDJSONSTRING" reason:@"nil" userInfo:nil];
            [Ce raise];
        }
    }
    
    if ([self isValid]) {
        return self;
    }else{
        return  nil;
    }
    

}

-(BOOL)isRuleCheckPass:(NSArray<NSCalendar *> *)clrlist{
    if(clrlist == nil || clrlist.count != 2 || clrlist[0] == nil || clrlist[1] == nil ||  ![self isValid]){
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_WRONGARGUMENT" reason:@"nil" userInfo:nil];
        [Ce raise];
        
    }
    NSCalendar *clrFirst = clrlist[0];
    NSCalendar *clrLast = clrlist[1];
    
#warning -mark  时间
//    TimeDifference timeDifference = new TimeDifference(clrLast, clrFirst);
//    float fHoursDiff = timeDifference.toHours();
//    if(fHoursDiff <= 0) return false; // 表示LAST在FIRST前面；
    CGFloat fHoursDiff;
    switch (_m_limitType) {
        case MAX:
            return fHoursDiff <= _m_fHours ? true:false;
        case MIN:
            return fHoursDiff >= _m_fHours ? true:false;
        default:
            break;
    }
    return false;
}


-(BOOL)isRuleConflict:(CheckRule *)rule1 {
    if (![rule1 isMemberOfClass:[self class]]) {
        return false;
    }
    DoubleSwipeRule *doibleRule = (DoubleSwipeRule *)rule1;
  

 
    if(self.m_limitType == doibleRule.m_limitType) return true;
    
    if((_m_limitType == MIN && _m_fHours >= doibleRule.m_fHours) ||
       (_m_limitType == MAX && _m_fHours <= doibleRule.m_fHours)){
        return true;
    }
    return false;
}


-(NSString *)toString{
    if(![self isValid]) return nil;
    NSDictionary *object = [self toJsonObject];
    if(object != nil) return [CommonFunctions functionsFromObjectToJsonString:object];
    return nil;
}

-(NSDictionary *)toJsonObject{
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    if(_m_limitType  && _m_fHours > 0 && _m_fHours <= MAXHOUR){
        NSString *limitStr = [FunctionUserSwipePublic TimeIntervalLimitString:_m_limitType];
        NSString *hourStr = [NSString stringWithFormat:@"%d",(int)(_m_fHours *100)];
        [object addEntriesFromDictionary:@{limitStr:hourStr}];
    
    }
    return object;
}


-(BOOL)isValid{
    if(!_m_limitType || _m_fHours <= 0 ||_m_fHours > MAXHOUR){
        return false;
    }
    return true;
}



@end
