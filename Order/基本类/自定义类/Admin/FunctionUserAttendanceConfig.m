//
//  FunctionUserAttendanceConfig.m
//  Order
//
//  Created by wang on 2016/12/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "FunctionUserAttendanceConfig.h"

@implementation FunctionUserAttendanceConfig



/**
 * 构造函数 - 客户端在功能管理员创建或者修改配置时应使用的构造函数
 * @param objUserSwipeConfig - 打卡配置文件的对象；
 * @param objLeaveAndDutyShiftConfig - 请假调休配置文件的对象；
 * @throws OrganizedException - 给定的子功能配置文件对象为null或者有无效或不完整的配置文件，抛出异常；
 */

-(instancetype)initWithFunctionUserSwipe:(FunctionUserSwipe *)objUserSwipeConfig leaveAndDutyShift:(FunctionLeaveAndDutyShift *)objLeaveAndDutyShiftConfig{

    if (self = [super init]) {
        _m_objLeaveAndDutyShiftConfig = objLeaveAndDutyShiftConfig;
        _m_objUserSwipeConfig = objUserSwipeConfig;
 
    }
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
}


/**
 * 构造函数 - 服务器使用；
 *
 * @param szJsonString 整个考勤功能的配置文件的json格式的字符串
 * @throws OrganizedException 参数有误返回异常；
 */

-(instancetype)initFunctionUserAttendanceConfigWith:(NSString *)szJsonString{
    if (self = [super init]) {
        NSDictionary *object = [CommonFunctions functionsFromJsonStringToObject:szJsonString];
        NSString *szKeyUserSwipeConfig = NSStringFromClass([FunctionUserSwipe class]);
        
        NSString *szKeyLeaveConfig = NSStringFromClass([FunctionLeaveAndDutyShift class]);
        
        if([[object allKeys] containsObject:szKeyUserSwipeConfig] && [[object allKeys] containsObject:szKeyLeaveConfig] && [object allKeys] .count == 2){
            _m_objLeaveAndDutyShiftConfig = [[FunctionLeaveAndDutyShift alloc]initFunctionLeaveAndDutyShiftWithJsonString:object[szKeyLeaveConfig ]];
           
            _m_objUserSwipeConfig = [[FunctionUserSwipe alloc]initFunctionUserSwipeWithJsonString:szKeyUserSwipeConfig];
            
    }
    }
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
    

}
-(NSString *)getFunctionConfigString{
    return [self toString];
}


-(NSDictionary *)toJsonObject{
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    
    if(_m_objLeaveAndDutyShiftConfig != nil){
        [object setObject:[_m_objLeaveAndDutyShiftConfig toString] forKey:NSStringFromClass([FunctionLeaveAndDutyShift class])];

    }
    if(_m_objUserSwipeConfig != nil){
        [object setObject:[_m_objUserSwipeConfig toString]forKey:NSStringFromClass([FunctionUserSwipe class])];
        
    }
    return object;
}


-(NSString *)toString{
    NSDictionary *dic = [self toJsonObject];
    NSString *str = [CommonFunctions functionsFromObjectToJsonString:dic];
    return str;
}




-(BOOL)isValid{
    if(_m_objUserSwipeConfig == nil || _m_objLeaveAndDutyShiftConfig == nil || ![_m_objLeaveAndDutyShiftConfig isValid] || ![_m_objUserSwipeConfig isValid]){
        return false;
    }
    return true;
}


@end
