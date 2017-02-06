//
//  UserCompanyBase.m
//  organizeClass
//
//  Created by wang on 16/9/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserCompanyBase.h"
#import "ValidContact.h"

#import "CommonFunctions.h"

@implementation UserCompanyBase
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    /** 公司名字*/
    [aCoder encodeObject:self.m_szName forKey:@"m_szName"];
    /** 公司电话*/
    [aCoder encodeObject:self.m_szMobile forKey:@"m_szMobile"];
    /** 公司邮箱*/
    [aCoder encodeObject:self.m_szEmail forKey:@"m_szEmail"];

}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        /** 公司名字*/
        self.m_szName = [aDecoder decodeObjectForKey:@"m_szName"];
        /** 公司电话*/
        self.m_szMobile = [aDecoder decodeObjectForKey:@"m_szMobile"];
        /** 公司邮箱*/
        self.m_szEmail = [aDecoder decodeObjectForKey:@"m_szEmail"];
    
    }
    return self;
}
//构造函数
/**
 * 根据公司的必要信息进行公司对象构造
 * @param szName	- 公司名字
 * @param szMobile 	- 公司关联手机号
 * @param szEmail	- 公司邮件地址
 * @param vldcontact	- 公司信息的验证情形
 * @throws OrganizedException	- 参数无效时，弹出异常
 */

-(instancetype)initWithszName:(NSString *)szName szMobile:(NSString *)szMobile szEmail:(NSString*)szEmail validContact:(validContact)vat{
    if (self = [super init]) {
    [self setBaseCompanyStatValue:Name ID:szName];
     [self setBaseCompanyStatValue:Mobile ID:szMobile];
     [self setBaseCompanyStatValue:Email ID:szEmail];
        self.m_ValidContact = vat;
    }
    return self;
}
+(instancetype)test{
    UserCompanyBase *user = [[UserCompanyBase alloc]init];
    user.m_szName = @"1231211211";
    user.m_szEmail = @"a13397101342@163.com";
    user.m_szMobile = @"13982398323";
    NSString *str = [NSString stringWithFormat:@"%d",CONTACT_EMAIL];
    [user setBaseCompanyStatValue:validcontac ID:str];
    
    return user;
}
-(instancetype)initWith:(NSString *)szUserbase{
    if (self = [super init]) {
        
    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:szUserbase];
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
    

    if ([str isEqualToString:@"Name"]) {
        _m_szName = dic[@"Name"];
    }else if ([str isEqualToString:@"Mobile"]){
        _m_szMobile = dic[@"Mobile"];
    }else if ([str isEqualToString:@"Email"]){
        _m_szEmail = dic[@"Email"];
    }else if ([str isEqualToString:@"Validcontact"]){
        _m_ValidContact =  [ValidContact getEnumFormStr:dic[@"Validcontact"]];
    }
  
}


/**
 * 设置公司的绑定移动电话号码
 * @param szMobile - 移动电话号码
 * @param bIsValidated - 是否经过验证
 * @throws OrganizedException  号码格式有误则跳出异常；
 */
-(void)baseSetCompanyMobile:(NSString *)szMobile bIsValidated:(BOOL)bIsValidated{
    [self setBaseCompanyStatValue:Mobile ID:szMobile];
    if(bIsValidated){
        _m_ValidContact = [ValidContact addMobileContact:_m_ValidContact];
    }else{
        _m_ValidContact = [ValidContact deleteMobileContact:_m_ValidContact];
    }
}

/**
 * 设置公司的绑定电子邮件地址
 * @param szemail - 电子邮件地址
 * @param bIsValidated - 是否经过验证
 * @throws OrganizedException  邮件地址格式有误则跳出异常；
 */
-(void)baseSetCompanyEmail:(NSString *)szEmail bIsValidated:(BOOL)bIsValidated{
    [self setBaseCompanyStatValue
     :Email ID:szEmail];
    if(bIsValidated){
        _m_ValidContact = [ValidContact addEmailContact:_m_ValidContact];
    }else{
        _m_ValidContact = [ValidContact deleteEmailContact:_m_ValidContact];
    }
}

-(instancetype)initWithJsonString:(NSString*)szUserBeanJsonString{
    
    if (self = [super init]) {
        
        NSDictionary *dic = (NSDictionary *)[CommonFunctions functionsFromJsonStringToObject:szUserBeanJsonString];
        NSArray *arr = [dic allKeys];
        for (NSString *str in arr) {
            if (str) {
                [self getCompanyBase:str dic:dic];
            }
        }
    }
    return self;
}


-(void)getCompanyBase:(NSString *)str dic:(NSDictionary*)dic{
    
    if ([str isEqualToString:@"Name"]) {
        _m_szName = dic[@"Name"];
    }else if ([str isEqualToString:@"Mobile"]){
        _m_szMobile = dic[@"Mobile"];
    }else if ([str isEqualToString:@"Email"]){
        _m_szEmail = dic[@"Email"];
    }else if ([str isEqualToString:@"ValidContact"]){
        
       _m_ValidContact = [dic[@"ValidContact"] intValue];
                 
    }
    
}
/**
 * 设置公司的验证情况信息
 * @param vldctat - 验证情况信息
 * @throws OrganizedException - 无效的验证情况下抛出异常
 */
-(void)setM_ValidContact:(validContact)m_ValidContact{
    if (!m_ValidContact ) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"setCompanyValidContact-Invalid argument"];
    }
    _m_ValidContact =m_ValidContact;
    
}

/**
 * 判断公司邮件是否通过验证
 * @return 邮件地址已经验证-true, 未验证通过-false;
 */
-(BOOL)baseIsCompanyEmailVerified{
    if (_m_ValidContact !=CONTACT_MOBILE &&_m_ValidContact !=CONTACT_NONE  ) {
        return  true;
    }
    return false;
}

/**
 * 判断公司手机号是否通过验证
 * @return 手机号已经验证-true, 未验证通过-false;
 */
-(BOOL)baseIsCompanyMobileVerified{
    if (_m_ValidContact !=CONTACT_EMAIL &&_m_ValidContact !=CONTACT_NONE  ) {
        return  true;
    }
    return false;
}

/**
 * 判断公司对象是否为有效对象
 * @return 有效-true, 无效或信息不完整-false;
 */

-(BOOL)isValid{
    NSArray *arr= @[_m_szName,_m_szMobile,_m_szEmail];
    if (![CommonFunctions functionsIsArrayValid:arr]) {
        return false;
    }
//    if (![CommonFunctions functionsIsArrayValid:arr]||_m_ValidContact == CONTACT_NONE) {
//        return false;
//    }
    return true;
}

/**
 * 判断两个对象是否为同一个抽象公司
 * @param baseinput - 要比较的对象
 * @return - 同一个公司 -ture; 否则-FALSE;
 */
-(BOOL)baseCompanyEquals:(UserCompanyBase *)baseinput{
 
    if ([[self toString] isEqualToString:[baseinput toString]]) {
        return true;
        
    }
    return false;
}

/**
 * 设置公司的基本信息值
 * <br>由于公司属性对应值多为string,需要检验有效性，因此，集中进行核对后设置；
 * @param statid	- 公司属性
 * @param szValue	- 公司属性对应的值
 * @throws OrganizedException	- 设置无效值时弹出异常；
 */
-(void)setBaseCompanyStatValue:(COMPANy_STAT_ID)statid ID:(NSString *)szValue{
   
    
    if (szValue == nil) {
        
        [self invalidPamas];
    }
    switch (statid) {
        case Name:
        {
            [szValue lowercaseString];
//            if([CommonFunctions functionsIsValidUserName:szValue]){
//                self.m_szName = szValue;
//            }else{
//                [self invalidPamas];
//            }
                self.m_szName = szValue;
        }
            break;
        case Mobile:
            if([CommonFunctions functionsIsMobile:szValue]){
                _m_szMobile = szValue;
            }else{
                [self invalidPamas];
            }
            break;
        case Email://转小写。
            [szValue lowercaseString];
            if([CommonFunctions functionsIsValidEmail:szValue]){
                self.m_szEmail = szValue;
            }else{
                [self invalidPamas];
            }
            break;
        case validcontac:
            self.m_ValidContact = [szValue intValue];
            break;
        default:
            break;
    }
    
    
}
-(NSString *)toString{
    @try {
        NSDictionary *dic = [self toJson];
       NSString *str  = [CommonFunctions functionsFromObjectToJsonString:dic];
        return str;
    } @catch (NSException *exception) {
        NSLog(@"NSException(Name:ARGUMENT_CONVERTION_ERROR -- reason:%@)",exception);
    } @finally {
    }
    
}

-(NSMutableDictionary *)toJson{
    if (![self isValid]) {
    NSString *szMore = @"UserCompanyBase toJsonObject: lack of information";
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:szMore];
    }
    
    NSArray *arr =[COMPANY_STAT_ID getBaseCompanyStatList];
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    for(NSNumber *num in arr){
        int i = [num  intValue];
        NSString *szValue = [self getCompanyStatValue:i];
       
        if([CommonFunctions functionsIsStringValid:szValue])
        {
            NSString *str = [COMPANY_STAT_ID getKeyNameForCompanyStatID:i];
            [muDic addEntriesFromDictionary:@{str:szValue}];
        }
    }
    
    return muDic;
}
-(NSString *)getCompanyStatValue:(COMPANy_STAT_ID)statid{
    NSString *szValue = nil;
    switch (statid) {
        case Name:
            szValue = _m_szName;
            break;
        case Email:
            szValue = _m_szEmail;
            break;
        case Mobile:
            szValue = _m_szMobile;
            break;
        case validcontac://转小写。
            szValue = [ValidContact getStringFormEnum:_m_ValidContact];
            break;
        default:
            break;
    }	
    return szValue;
    
}
-(void)invalidPamas{
    NSString *reasonStr = @"CompanyBase?Set Error:Invalid";
    [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:reasonStr];
}

@end
