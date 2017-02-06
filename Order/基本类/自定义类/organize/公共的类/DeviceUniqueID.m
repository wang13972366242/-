//
//  DeviceUniqueID.m
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "DeviceUniqueID.h"

#import "CommonFunctions.h"

@interface DeviceUniqueID ()


@end
@implementation DeviceUniqueID


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.m_szOS forKey:@"m_szOS"];
    [aCoder encodeObject:self.m_szIP forKey:@"m_szIP"];
    
    [aCoder encodeObject:self.m_szMacAddress forKey:@"m_szMacAddress"];
    [aCoder encodeObject:self.m_szHostName forKey:@"m_szHostName"];
    
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.m_szOS = [aDecoder decodeObjectForKey:@"m_szOS"];
        self.m_szIP = [aDecoder decodeObjectForKey:@"m_szIP"];
        self.m_szMacAddress = [aDecoder decodeObjectForKey:@"m_szMacAddress"];
        self.m_szHostName = [aDecoder decodeObjectForKey:@"m_szHostName"];
    }
    return self;
}
/**
 * 构造函数
 * @param szIP  - 公共IP地址
 * @param szMac - 网卡的MAC地址
 * @param szOS  - 所使用的设备的操作系统信息
 * @param szHostName	- 所使用设备的主机名；电脑端-主机名；手机 pad-设备唯一识别码；
 * @throws OrganizedException - 无效参数时，抛出异常
 */
-(instancetype)initWithIP:(NSString *)szIP szMac:(NSString *)szMac szOS:(NSString *)szOS szHostName:(NSString *)szHostName{
    if (self = [super init]) {
//    if ([self isValid] == NO) {
//        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERRORARGUMENT_CONVERTION_ERROR" reason:@"DeviceUniqueID init Error: not a valid DeviceUniqueID"];
//            
//        }
    _m_szOS = [self trimAndLowStringWith:szOS];
    _m_szIP = [self trimAndLowStringWith:szIP];
    _m_szMacAddress = [self trimAndLowStringWith:szMac];
    _m_szHostName = [self trimAndLowStringWith:szHostName];
    }
    
    return self;

}



/**
 * 从JSONString解析时的构造函数
 * @param szJsonString	- 符合格式的jsonstring
 * @throws JSONException	- 非有效的JSON String
 * @throws OrganizedException - 非有效的DeviceUniqueID Json string;
 */

-(instancetype)initDeviceWithJson:(NSString *)json{
    if (self = [super init]) {
        NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:json];
        _m_szIP =  dic[@"IP"];
        _m_szOS =  dic[@"OS"];
        _m_szHostName =  dic[@"HOSTNAME"];
        _m_szMacAddress =  dic[@"MAC"];
    }
    return self;
}


/**
 * 设置对象中的设备OS-操作系统信息
 * @param szOS	- 操作系统信息
 * @throws OrganizedException - 参数为空或者无效
 */

-(void)setM_szOS:(NSString *)m_szOS{
    if (![CommonFunctions functionsIsStringValid:m_szOS]) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_SET_ERROR" reason:@"SetDeviceOS:参数无效"];
    }
    _m_szOS = [self trimAndLowStringWith:m_szOS];
}

/**
 * 设置对象中的设备IP信息
 * @param szIP  IP地址信息
 * @throws OrganizedException - 参数为空或者无效
 */
-(void)setM_szIP:(NSString *)m_szIP{
    if (![CommonFunctions functionsIsStringValid:m_szIP]) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_SET_ERROR" reason:@"SetDeviceIP:参数无效"];
    }
    _m_szIP = [self trimAndLowStringWith:m_szIP];

}
-(void)setM_szHostName:(NSString *)m_szHostName{

    if (![CommonFunctions functionsIsStringValid:m_szHostName]) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_SET_ERROR" reason:@"SetDeviceHostName:参数无效"];
    }
    _m_szHostName = [self trimAndLowStringWith:m_szHostName];
}

-(void)setM_szMacAddress:(NSString *)m_szMacAddress{
    if (![CommonFunctions functionsIsStringValid:m_szMacAddress]) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_SET_ERROR" reason:@"SetDeviceMacAddress:参数无效"];
    }
    _m_szMacAddress = [self trimAndLowStringWith:m_szMacAddress];
}
/**
 * 测试用函数 - 格式化显示DeviceuniqueID的内容信息
 * @return 格式化显示DeviceuniqueID的NSDictionary
 */

-(NSDictionary *)testObjectString{

    if (![self isValid]) {
        return nil;
    }
    return @{@"OS":_m_szOS,@"OS":_m_szOS,@"OS":_m_szOS,@"OS":_m_szOS};
}

/**
 * 判断DeviceUniqueID对象内容是否有效
 * @return 内容有效-TRUE, 无效- FALSE;
 */
-(BOOL)isValid{
    NSArray *tobevalidate = @[_m_szOS,_m_szIP,_m_szHostName,_m_szMacAddress];
    if([CommonFunctions functionsIsArrayValid:tobevalidate]){
        return true;
    }
    return false;
}

-(NSString *)trimAndLowStringWith:(NSString *)str{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
    [trimedString lowercaseString];
    return trimedString;
}


-(NSString *)toString{
    @try {
        NSDictionary *dic = [self toJson];
        return [CommonFunctions functionsFromObjectToJsonString:dic];
    } @catch (NSException *exception) {
        NSLog(@"NSException(Name:ARGUMENT_CONVERTION_ERROR -- reason:%@)",exception);
    } @finally {
    }
    
}

-(NSDictionary *)toJson{
    if (![self isValid]) {
        NSString *szMore = @"DeviceUniqueID convertion Error: not a valid DeviceUniqueID";
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:szMore];
    }
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    
    [muDic addEntriesFromDictionary:@{@"IP":_m_szIP}];
    [muDic addEntriesFromDictionary:@{@"OS":_m_szOS}];
    [muDic addEntriesFromDictionary:@{@"MAC":_m_szMacAddress}];
    [muDic addEntriesFromDictionary:@{@"HOSTNAME":_m_szHostName}];
    
    
    
    return muDic;
}
@end
