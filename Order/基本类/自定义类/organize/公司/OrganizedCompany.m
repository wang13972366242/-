//
//  OrganizedCompany.m
//  Order
//
//  Created by wang on 2016/10/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedCompany.h"


#import "CommonFunctions.h"
#import "COMPANY_STAT_ID.h"

@implementation OrganizedCompany
-(NSMutableArray *)m_vcAddressArr{
    
    if (_m_vcAddressArr == nil) {
        _m_vcAddressArr = [NSMutableArray array];
        
    }
    return _m_vcAddressArr;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    /** 地址数组*/
    [aCoder encodeObject:self.m_vcAddressArr forKey:@"m_vcAddressArr"];
    /** 座机*/
    [aCoder encodeObject:self.m_szStaticPhoneNumber forKey:@"m_szStaticPhoneNumber"];
    /** 公司类型*/
    [aCoder encodeObject:self.m_szCompanyType forKey:@"m_szCompanyType"];
    /** 公司描述*/
    [aCoder encodeObject:self.m_szCompanySummary forKey:@"m_szCompanySummary"];
    
    [aCoder encodeObject:self.m_JobTitleStructure forKey:@"m_JobTitleStructure"];
    
}
static OrganizedCompany *company = nil;

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        /** 地址数组*/
        self.m_vcAddressArr = [aDecoder decodeObjectForKey:@"m_vcAddressArr"];
        /** 座机*/
        self.m_szStaticPhoneNumber = [aDecoder decodeObjectForKey:@"m_szStaticPhoneNumber"];
        /** 公司类型*/
        self.m_szCompanyType = [aDecoder decodeObjectForKey:@"m_szCompanyType"];
        /** 公司描述*/
        self.m_szCompanySummary = [aDecoder decodeObjectForKey:@"m_szCompanySummary"];
        self.m_JobTitleStructure = [aDecoder decodeObjectForKey:@"m_JobTitleStructure"];
    }
    return self;
}

-(instancetype)initWithCompany:(UserCompanyBase *)baseinfo{
    OrganizedCompany *com;
    BOOL isComplete ;
    if (self = [super init]) {
     
        isComplete = [baseinfo isValid];
        com = [[OrganizedCompany alloc]init];
        com.m_szName =baseinfo.m_szName;
        com.m_szEmail = baseinfo.m_szEmail;
        com.m_szMobile = baseinfo.m_szMobile;
        
          com.m_ValidContact = CONTACT_MOBILE;   
        
       
    }
    
    
    if (isComplete == YES) {
        return com;
    }else{
        [CommonFunctions functionsthrowExcentptionWith:@"company" reason:@"baseinfo is not compete"];
        return nil;
    }
}

-(instancetype)initWithJsonString:(NSString*)szUserBeanJsonString{
    
    if (self = [super init]) {
        
        NSDictionary *dic = (NSDictionary *)[CommonFunctions functionsFromJsonStringToObject:szUserBeanJsonString];
        NSArray *arr = [dic allKeys];
        for (NSString *str in arr) {
            if (str) {
                [self getCompanyInfo:str dic:dic];
            }
        }
    }
    return self;
}


-(void)getCompanyInfo:(NSString *)str dic:(NSDictionary*)dic{
    
if ([CommonFunctions functionsIsStringValidAfterTrim:str]) {
    
    if ([str isEqualToString:@"Staticphone"]) {
        self.m_szStaticPhoneNumber = dic[str];
        
    }else if ([str isEqualToString:@"Address"]){
        NSString *str1  = dic[str];
        self.m_vcAddressArr = [NSMutableArray array];
        
        self.m_vcAddressArr = (NSMutableArray *)[CommonFunctions functionsStringToAddressArray:str1];
        if (self.m_vcAddressArr.count == 0) {
            [self.m_vcAddressArr addObject:str1];
        }
        
    }else if ([str isEqualToString:@"Type"]){
        self.m_szCompanyType = dic[str];
        
    }else if ([str isEqualToString:@"Summary"]){
        self.m_szCompanySummary = dic[str];
        
    }else if ([str isEqualToString:@"JobTitlestructure"]){
        NSString *json = dic[str];
        self.m_JobTitleStructure =  [[JobTitleStructure alloc]initWithJsonString:json];
        
#pragma -mark 职位错误;
        
    }
}
    
    
    
}
/**
 * 获取公司的全部地址，多个地址之间以\t隔开
 * @return 公司地址信息String
 */
-(NSString *)userCompanyAddressString{
    return   [CommonFunctions funstionAddressArrayToString:_m_vcAddressArr];
    
}
-(NSArray *)userCompanyAddressArray:(NSString *)str{
    
    return   [CommonFunctions functionsStringToAddressArray:str];
}

/**
 * 添加公司的地址信息
 * @param szNewAddress - 单个地址信息
 * @throws OrganizedException 地址无效，重复的情况下，跳出异常；
 */
-(void)companyaddAddress:(NSString *)addStr{
    if ([CommonFunctions functionsIsStringValidAfterTrim:addStr]) {
        [self.m_vcAddressArr addObject:addStr];
    }else{
        
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"OrganizedCompany:addCompanyAddress-invalid or duplicated address"];
    }
}

-(void)setCurrentMemberStatValueWithUSER_STAT_ID:(COMPANy_STAT_ID)statid ID:(NSString *)szValue{
    if(!statid  || szValue == nil){	//非本类对象属性，返回空
        return ;
    }
    if (szValue == nil) {
        
        [self invalidPamas];
    }
    switch (statid) {
        case Staticphone:
        {
            if([CommonFunctions functionsIsMobile:szValue]){
                self.m_szStaticPhoneNumber = szValue;
            }else{
                
                NSString *reasonStr = @"CompanyMember?Set Error:Invalid";
                [CommonFunctions functionsthrowExcentptionWith:@"USER_STATS_SETERROR" reason:reasonStr];
            }
        }
            break;
        case JobTitlestructure:
     
            break;
        case Type:
            _m_szCompanyType = szValue;
            break;
        case Summary:
            _m_szCompanySummary	= szValue;
            break;
        default:
            break;
    }
    
    
}


-(NSString *)toString{
    @try {
        NSDictionary *dic = [self toJson];
        return [CommonFunctions functionsFromObjectToJsonString:dic];
    } @catch (NSException *exception) {
        NSLog(@"NSException(Name:ARGUMENT_CONVERTION_ERROR -- reason:%@)",exception);
    }
    
}


-(NSDictionary *)toJson{
    if (![self isValid]) {
        NSString *szMore = @"OrganizedUserCompany toJsonObject: lack of company mondantory Information";
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:szMore];
    }
    
    NSMutableDictionary *object = [super toJson];
    NSArray *arr =[COMPANY_STAT_ID getClientCompanyStatList];
    
    for(NSNumber *num in arr){
        int i = [num  intValue];
        COMPANy_STAT_ID emum = [COMPANY_STAT_ID getEnumForCompanyStatID:i];
        NSString *szValue = [self getCompanyStatValue:emum];
        
        if([CommonFunctions functionsIsStringValid:szValue])
        {
            NSString *str = [COMPANY_STAT_ID getKeyNameForCompanyStatID:i];
            [object addEntriesFromDictionary:@{str:szValue}];
        }
    }
    
    return object;
}


-(NSString *)getCompanyStatValue:(COMPANy_STAT_ID)statid{
    
    NSString *szValue = [super getCompanyStatValue:statid];
   
    switch (statid) {
        case Staticphone:
            szValue = _m_szStaticPhoneNumber;
            break;
        case Address:
            szValue = [CommonFunctions funstionAddressArrayToString:_m_vcAddressArr];
            break;
        case JobTitlestructure:
            szValue = [_m_JobTitleStructure toString];
            break;
        case Type:
            szValue = _m_szCompanyType;
            break;
        case Summary:
            szValue = _m_szCompanySummary;
            break;
        default:
            break;
    }
    return szValue;
    
}


-(void)invalidPamas{
    
    NSString *reasonStr = @"CompanyMember?Set Error:Invalid";
    [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_SET_ERROR" reason:reasonStr];
    
}
@end
