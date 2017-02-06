//
//  BaseOperation.m
//  Admint
//
//  Created by wang on 2016/11/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseOperation.h"

@implementation BaseOperation
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.m_szOperatorAccount forKey:@"m_szOperatorAccount"];
    
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.m_szOperatorAccount = [aDecoder decodeObjectForKey:@"m_szOperatorAccount"];
    }
    return self;
}
/**
 * 此处在构造对象时，不进行isValid的成员变量检查；
 * <br>因为protected的构造，不可直接调用对象；
 * <br>如有需要，在集成类的构造上进行isValid的检测；
 * @param szAccount	操作者的账号；
 */
-(instancetype)initWithszAccount:(NSString *)szAccount{
    if (self = [super init]) {
        _m_szOperatorAccount = szAccount;
    }

    return self;
}


-(instancetype)initWithJsonString:(NSString *)jsonString{
    
    if (self = [super initWithJson:jsonString]) {
          NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:jsonString];
        [self accordingDictionaryToObject:dic];
    }
    
    return self;
}



/**
 * 此处在构造对象时，不进行isValid的成员变量检查；
 * <br>因为protected的构造，不可直接调用对象；
 * <br>如有需要，在集成类的构造上进行isValid的检测；
 * @param object 携带参数的JSONObject;
 * @throws OrganizedException JSONObect无效，抛出异常；
 */

-(void)accordingDictionaryToObject:(NSDictionary *)object
{
    if ([[object allKeys] containsObject:@"OPTACCOUNT"]) {
        _m_szOperatorAccount = object[@"OPTACCOUNT"];
    }else{
        CodeException *Ce =[[CodeException alloc]initWithName:@"BASEOPERATION_WRONGARGUMENT" reason:@"OrganizedManagementRequest - no MANAGEMENT_TYPE in source" userInfo:nil];
        [Ce raise];
        
    }

}
-(instancetype)initWithDic:(NSDictionary *) object{
    if (self = [super initWithDictionary:object keysets:nil]) {
        if ([[object allKeys] containsObject:@"OPTACCOUNT"]) {
            _m_szOperatorAccount = object[@"OPTACCOUNT"];
        }else{
            CodeException *Ce =[[CodeException alloc]initWithName:@"BASEOPERATION_WRONGARGUMENT" reason:@"OrganizedManagementRequest - no MANAGEMENT_TYPE in source" userInfo:nil];
            [Ce raise];
        
        }
    }
    return self;
}


/**
 * 判断对象是否有效；
 */

-(BOOL)isValid{
    
    if(![super isValid]) return false;
    if(![CommonFunctions functionsIsStringValid:_m_szOperatorAccount]) {
        return false;
    }
    return true;
}

/**
 * baseOperation转换为jsonobject
 * @return JSONObject
 */
-(NSMutableDictionary *)  toJsonObject{
    NSMutableDictionary *object = (NSMutableDictionary *)[super toJsonObject];
    [object addEntriesFromDictionary:@{@"OPTACCOUNT":_m_szOperatorAccount}];
    if (object.count == 0) {
        return nil;
    }
    return object;
}




@end
