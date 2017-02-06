//
//  FunctionLeaveAndDutyShift.m
//  Order
//
//  Created by wang on 2016/12/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "FunctionLeaveAndDutyShift.h"



@implementation FunctionLeaveAndDutyShift

-(NSMutableArray<NSString *> *)m_supportedLeaveType{
    if (_m_supportedLeaveType) {
        _m_supportedLeaveType = [NSMutableArray array];
    }
    return _m_supportedLeaveType;
}


/**
 * 请假调休相关的配置
 * <br>构造函数 - 从JSON格式的STRING转化为
 * @param szJsonString 正确格式的JSON string;
 * @throws OrganizedException 参数错误；
 */

-(instancetype)initFunctionLeaveAndDutyShiftWithJsonString:(NSString *)szJsonString{

    if (self = [super init]) {
        NSDictionary *list = [CommonFunctions functionsFromJsonStringToObject:szJsonString];
        if(list == nil || list.count == 0){
        
            CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_LEAVEORSHIFT_WRONGARGUMENT" reason:@"nil" userInfo:nil];
            [Ce raise];
        }
        for (NSString *str  in list) {
            [self.m_supportedLeaveType addObject:str];
        }
    }
    return self;

}


/**
 * 请假调休的配置对象构造函数
 * @param arrType - 支持的请假调休类型；
 */

-(instancetype)initFunctionLeaveAndDutyShiftWithLeaveorshift:(NSArray *)arrType{

    if (self = [super init]) {
        [self addLeaveType:arrType];
    }
    return self;

}

/**
 * 添加对请假或调休种类的支持
 * <br> 若需添加的类别已经支持，或者参数列表为空，则不执行任何操作；
 * @param arrTypes  需添加的请假种类
 */

-(void)addLeaveType:(NSArray *)arrTypes{
    if(arrTypes == nil || arrTypes.count == 0) return;
    for(NSString  *type  in arrTypes){
        if(![_m_supportedLeaveType containsObject:type]){
            [_m_supportedLeaveType addObject:type];
        }
    }
}



/**
 * 删除对某个或某些请假类型的支持
 * <br> 若需删除的类别本来就不支持，或者参数列表为空，则不执行任何操作；
 * @param arrTypes - 需删除的请假类型
 */

-(void)removeLeaveType:(NSArray *)arrTypes{
    if(arrTypes == nil || arrTypes.count == 0) return;
    for(NSString *type in arrTypes){
        if([_m_supportedLeaveType containsObject:type]){
            [_m_supportedLeaveType removeObject:type];
        }
    }
}

-(BOOL)isValid{
    if (self.m_supportedLeaveType.count == 0) {
        return  false;
    }
    
    return true;
}

-(NSString *) toString{
    if(![self isValid]) return nil;
    NSString *str = [FunctionLeaveAndDutyShift arrayToString:_m_supportedLeaveType];
    return  str;
}


/**
 * 把合法的LEAVEORSHIFT_TYPE静态数组转化为JSONArrayString
 * <br>忽略数组中的null项
 * @param arrLeaveOrShiftType LEAVEORSHIFT_TYPE静态数组
 * @return 如果参数为空，返回null; 否则返回JSONArray格式的字符串；
 */
+(NSString *)arrayToString:(NSArray *)arrLeaveOrShiftType{
    if(arrLeaveOrShiftType == nil || arrLeaveOrShiftType.count == 0) return nil;
    NSMutableArray *array = [NSMutableArray array];
    for(NSString *type in arrLeaveOrShiftType){
        if(type == nil) continue; //忽略为空的成员；
        [array  addObject:type];
    }
    if(array.count == 0) return nil;
    return [CommonFunctions functionsFromObjectToJsonString:array];
}

@end
