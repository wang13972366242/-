//
//  OrganizedParams.m
//  organizeClass
//
//  Created by wang on 16/9/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedParams.h"
#import "COMPANY_STAT_ID.h"
#import "BaseArgumentList.h"

static  NSString *CHECKTYPE = @"CheckType";
@implementation OrganizedParams
/**
 *  获得检查的key
 */
+(NSString *)paramsGetCheckParamKey{
    return CHECKTYPE;
}

//+(int)paramsGetCheckTypeInt:(CheckType)type{
// 
//
//}
+(NSString *)getStringFormEnum:(CheckType)ID{
    NSArray *arr=  [self getEnum];
    return  [arr objectAtIndex:ID-1];
}


+(NSArray *)getEnum{
 
    return @[@"COMPANY_EMAIL",@"COMPANY_MOBILE",@"USER_EMAIL",@"USER_MOBILE",@"ACCOUNT_NAME",@"EMPLOYEE_NUMBER"];
    
}
+(NSString *)getCheckTypeValueKey:(CheckType)type{
    return [OrganizedParams getStringFormEnum:type];
}


+(NSString*)getCompanyIDKeyforCheckTypeRequest{
    return @"UniqueID";
}


/**
 * DBColumns动态数组转换为String[]
 * <br>有去重功能；
 * @param argKeyList 数据库列对象的动态数组
 * @return 转化为字符串格式之后的数组；
 */

+(NSArray *)toStringKeySet:(NSArray *) argKeyList{
  		if(argKeyList == nil) return nil;
  		NSMutableArray * arrKeySet = [NSMutableArray array];
    
  		for(NSString *statID in argKeyList){
            
        
            if (![arrKeySet containsObject:statID]) {
                [arrKeySet addObject:statID ];
            }
        
        }
    return arrKeySet;

}


+(NSDictionary *)toStringKeyHash:(NSDictionary *) argKeyList{
  		if(argKeyList == nil) return nil;
  		NSMutableDictionary *strMpValues = [NSMutableDictionary dictionary];
  		for(NSString *statID in [argKeyList allKeys]){
            
            [strMpValues addEntriesFromDictionary:@{statID :argKeyList[statID]}];
        }
  		return strMpValues;
}






/**
 * 所有公司属性中，为unique的条目；
 * @return 公司属性集合
 */

+(NSArray *)getCompanyDBUniqueItemList{
    NSString *nameStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Name];
   NSString *MobileStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Mobile];
   NSString *EmailStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Email];
   NSString *UniqueIDStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:uniqueID];
   
    NSArray *UniqueStats = @[nameStr ,MobileStr,EmailStr,UniqueIDStr];
    
    return UniqueStats;
}

/**
 * 公共函数的toString,
 * @param objectTarget - 待操作ArgumentObject对象
 * @param jsonObject - 对象的JsonObject格式；
 
 */
//
//+(NSString *)toString:(BaseArgumentList *) objectTarget dic:(NSDictionary *) jsonObject{
//    if(objectTarget == nil || jsonObject == nil || jsonObject.count == 0 || ![objectTarget isValid ]) return nil;
//    return [CommonFunctions functionsFromObjectToJsonString:jsonObject];
//}
//
//+(NSString *)toString:(BaseArgumentList *) objectTarget arr:(NSArray *)jsonArray{
//    if(objectTarget == nil || jsonArray == nil || jsonArray.count== 0 || ![objectTarget  isValid ]) return nil;
//    return [CommonFunctions functionsFromObjectToJsonString:jsonArray];
//}


/**
 * 把字符串（数据库中的列名）转化为CompanyDBColumns
 * @param szCompanyStatStr - 字符串（数据库中的列名）
 * @return 有效的CompanyDBColumns 或者null,如果无法解析的情况下（如更新了代码，取消了部分column或者误调用等等情况）；
 */
+(NSString *)convertStringToCompanyDBColumns:(NSString *) szCompanyStatStr{
    if(szCompanyStatStr != nil){
        
    NSMutableArray *allMemberColunms = [NSMutableArray arrayWithArray:[OrganizedParams allUserClientStat]];
    
    for (NSString *serverStr in [OrganizedParams allUserServerStat]) {
        [allMemberColunms addObject:serverStr];
    }
       
    for (NSString *companyBase in [OrganizedParams allCompanyBase]) {
            [allMemberColunms addObject:companyBase];
    }
        
    for(NSString *colunm in allMemberColunms){
        if ([colunm isEqualToString:szCompanyStatStr]) {
            return colunm;
        }
        
    }
       
}
     return nil;
}
/**
 * 把字符串转回MemberDBColumns interface
 * @param szMemberStatStr 需转换的对象 ；
 * @return 转换成功，返回interface,否则，返回null;
 * @throws OrganizedException
 */

+(NSString *)convertStringToMemberDBColumns:(NSString *) szMemberStatStr{
    if(szMemberStatStr != nil){
    NSMutableArray *allMemberColunms = [NSMutableArray arrayWithArray:[OrganizedParams allUserClientStat]];
        
    for (NSString *serverStr in [OrganizedParams allUserServerStat]) {
            [allMemberColunms addObject:serverStr];
        }
        
        
        for(NSString *colunm in allMemberColunms){
        if ([colunm isEqualToString:szMemberStatStr]) {
            return colunm;
            }
      
    }
    }
    return nil;
}


+(NSArray *)allUserClientStat{
    return @[@"UniqueAccount",@"Mobile",@"Email",@"ValidContact",@"LandLine",@"RealName",@"EmployeeNumber",@"Department",@"JoUSER_SERVER_STATbTitle",@"OfficeAddress",@"HomeAddress",@"Summary",@"Sex",@"Birthday"];

}

+(NSArray *)allUserServerStat{
 return @[@"MyCompanyID",@"MySalt",@"Password",@"CurrentLoginDeviceID",@"LastLoginTime",@"AdminType",@"AdminSummary",@"ExceptionFunctionList",@"AdminOfFunction"];
}

+(NSArray *)allCompanyBase{
    return @[@"Name",@"Mobile",@"Email",@"Validcontact"];

}
+(NSArray *) getAdminQueryResultStats{
    
    return @[@"UniqueAccount",@"RealName",@"Department",@"JobTitle"];
    
}

@end
