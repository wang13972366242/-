//
//  UserBean.m
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserBean.h"
#import "USER_STAT_ID.h"
#import <CommonCrypto/CommonDigest.h>
#import "CommonFunctions.h"
#import "NSString+MD5String.h"
@implementation UserBean



-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.m_szUsername forKey:@"m_szUsername"];
    [aCoder encodeObject:self.m_szPassword forKey:@"m_szPassword"];
    
    [aCoder encodeObject:self.m_objDeviceID forKey:@"m_objDeviceID"];
  
    
}

-(instancetype)initWith:(NSString*)szUserBeanJsonString{

    if (self = [super init]) {
        
        NSDictionary *dic = (NSDictionary *)[CommonFunctions functionsFromJsonStringToObject:szUserBeanJsonString];
        NSArray *arr = [dic allKeys];
        for (NSString *str in arr) {
            if (str) {
                [self getShuxing:str dic:dic];
            }
        }
    }
    return self;
}


-(void)getShuxing:(NSString *)str dic:(NSDictionary*)dic{
    if ([str isEqualToString:@"UniqueAccount"]) {
        _m_szUsername = dic[@"UniqueAccount"];
    }else if ([str isEqualToString:@"Password"]){
        _m_szPassword = dic[@"Password"];
    }else if ([str isEqualToString:@"CurrentLoginDeviceID"]){
        _m_objDeviceID = dic[@"CurrentLoginDeviceID"];
    }
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.m_szUsername = [aDecoder decodeObjectForKey:@"m_szUsername"];
        self.m_szPassword = [aDecoder decodeObjectForKey:@"m_szPassword"];
        self.m_objDeviceID = [aDecoder decodeObjectForKey:@"m_objDeviceID"];
  }
    return self;
}


-(instancetype)initWithszUsername:(NSString *)szUsername szPassword:(NSString *)szPassword objDeviceID:(DeviceUniqueID*)objDeviceID{
  
    if (self = [super init]) {
        self.m_szUsername = szUsername;
        self.m_objDeviceID = objDeviceID;
        self.m_szPassword = [self MD5AddTrim:szPassword];
    }
    return self;
}
-(instancetype)initWithPasswod:(NSString *)passWord{

    
    if (self = [super init]) {
        
        
        self.m_szPassword = [self MD5AddTrim:passWord];
    }
    return self;

}

/**
 * 设置用户密码 <br>- 将明文串转化为HASH STRING后存储在对象中
 * @param password - 明文字符串
 * @throws OrganizedException  - 密码格式不合法，抛出异常；
 */

-(NSString *)MD5AddTrim:(NSString*)szPassword{
    
    //清除空格
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [szPassword stringByTrimmingCharactersInSet:set];
    //MD5
    NSString *encrypted = [NSString md5String:trimedString];
    return encrypted;
}

-(NSString *)MD5AddCStringTrim:(NSString*)szPassword{

    //清除空格
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [szPassword stringByTrimmingCharactersInSet:set];
    //MD5
    const char *password=[trimedString UTF8String];
     char mdc[16];
    CC_MD5(password,(CC_LONG)strlen(password),(unsigned char*)mdc);
  NSString *encrypted = [[NSString alloc] initWithCString:(const char*)mdc encoding:NSASCIIStringEncoding];
    return encrypted;
}

-(void)setM_szUsername:(NSString *)m_szUsername{

    [m_szUsername lowercaseString];
    _m_szUsername = m_szUsername;

}
-(BOOL)isValid{
    NSArray *arr= @[_m_szUsername,_m_szPassword];
    if(![CommonFunctions functionsIsArrayValid:arr] || _m_objDeviceID == nil || ![_m_objDeviceID isValid]){
        return false;
    }
    return true;
    
}




-(NSString *)toString{
    @try {
        NSDictionary *dic = [self toJson];
        NSString *str = [CommonFunctions functionsFromObjectToJsonString:dic];

        return str;
    } @catch (NSException *exception) {
        NSLog(@"NSException(Name:ARGUMENT_CONVERTION_ERROR -- reason:%@)",exception);
    } @finally {
    }
    
}

-(NSDictionary *)toJson{
    if (![self isValid]) {
        NSString *szMore = @"Convert to JsonObject Error:lack of UserBean Information";
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:szMore];
    }
    NSArray *arr =[USER_STAT_ID getUserBeanMemberStatList];
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    for(NSNumber *num in arr){
        int i = [num  intValue];
        NSString *szValue = [self getCurrentMemberStatValue:i];
        
        if([CommonFunctions functionsIsStringValid:szValue])
        {
            NSString *str = [UserBean getNewUserBan:i];
            [muDic addEntriesFromDictionary:@{str:szValue}];
            NSLog(@"str = %@,szValue = %@",str,szValue);
        }
    }
    
    return muDic;
}

-(NSString *)getCurrentMemberStatValue:(USE_STAT_ID)statid{
    NSString *szResult = nil;
    switch (statid) {
        case Password:
            szResult = _m_szPassword;
            break;
        case UniqueAccount:
            szResult = _m_szUsername;
            break;
        case CurrentLoginDeviceID:
        {
            DeviceUniqueID *d = _m_objDeviceID;
            if( d!= nil){
                szResult = [d toString];
            }
            break;
        }
        default:
            break;
    }
    return szResult;
}


+(NSString *)getNewUserBan:(int)i{
    if (i == 0) {
       return  @"LoginName";
    }else if (i == 1){
    
        return  @"LoginPassword";
    }else{
    
        return @"DeviceID";
    }

}
@end
