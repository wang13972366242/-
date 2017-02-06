//
//  USER_STAT_ID.m
//  organizeClass
//
//  Created by wang on 16/9/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "USER_STAT_ID.h"
#import "CommonFunctions.h"
@implementation USER_STAT_ID

/**
 * 获取USERBEAN占用的属性
 * @return 属性数组
 */
+(NSArray *)getUserBeanMemberStatList{
   
  
    return @[@(UniqueAccount),@(Password),@(CurrentLoginDeviceID)];

}

/**
 * 获取OrganizedMember对象占用的属性
 * @return 属性数组
 */
+(NSArray *)getClientMemberStatList{
    return @[@(UniqueAccount),@(mobile),@(LandLine),@(email),@(ValidContac),@(RealName),@(sex),@(EmployeeNumber),@(Department),@(JobTitle),@(Birthday),@(OfficeAddress),@(HomeAddress),@(summary)];

}

/**
 * 获取Unique属性的数组；
 * @return  属性数组
 */
-(NSArray *)getDBUniqueItemList{

    return @[@(UniqueAccount),@(email),@(mobile)];
}




+(NSString *)getKeyNameForCompanyStatID:(USE_STAT_ID)ID{
    switch (ID) {
        case UniqueAccount:return @"UniqueAccount";
        case Password:return @"Password";
        case RealName:return @"RealName";
        case mobile:return @"Mobile";
        case LandLine: return @"LandLine";
        case email: return @"Email";
        case ValidContac: return @"ValidContact";
        case sex: return @"Sex";
        case EmployeeNumber: return @"EmployeeNumber";
        case Department: return @"Department";
        case JobTitle: return @"JobTitle";
        case Birthday: return @"Birthday";
        case OfficeAddress: return @"OfficeAddress";
        case HomeAddress: return @"HomeAddress";
        case summary: return @"Summary";
        case AdminType: return @"AdminType";
        case AdminSummary: return @"AdminSummary";
        case RegistrationTime: return @"RegistrationTime";
        case LastLoginTime: return @"LastLoginTime";
        case CurrentLoginDeviceID: return @"CurrentLoginDeviceID";
        case ExceptionFunctionList: return @"ExceptionFunctionList";
        case MyCompanyID: return @"MyCompanyID";
        case AdminOfFunction: return @"AdminOfFunction";
        case MySalt: return @"MySalt";
        default:
            return nil;
    }
}
/**
 *  放回USE_STAT_ID
 *
 *  @param 枚举对应的字符串
 */
+(USE_STAT_ID)getEnumFormStr:(NSString *)str{
    
    if ([CommonFunctions functionsIsStringValidAfterTrim:str]) {
        if ([str isEqualToString:@"UniqueAccount"]) {
            return UniqueAccount;
        }else if ([str isEqualToString:@"Password"]){
            return Password;
        }else if ([str isEqualToString:@"RealName"]){
            return RealName;
        }else if ([str isEqualToString:@"Mobile"]){
            return mobile;
        }else if ([str isEqualToString:@"LandLine"]){
            return LandLine;
        }else if ([str isEqualToString:@"Email"]){
            return email;
        }else if ([str isEqualToString:@"ValidContact"]){
            return ValidContac;
        }else if ([str isEqualToString:@"Sex"]){
            return sex;
        }else if ([str isEqualToString:@"EmployeeNumber"]){
            return EmployeeNumber;
        }else if ([str isEqualToString:@"Department"]){
            return Department;
        }else if ([str isEqualToString:@"JobTitle"]){
            return JobTitle;
        }else if ([str isEqualToString:@"Birthday"]){
            return Birthday;
        }else if ([str isEqualToString:@"OfficeAddress"]){
            return OfficeAddress;
        }else if ([str isEqualToString:@"HomeAddress"]){
            return HomeAddress;
        }else if ([str isEqualToString:@"Summary"]){
            return summary;
        }else if ([str isEqualToString:@"AdminType"]){
            return AdminType;
        }else if ([str isEqualToString:@"AdminSummary"]){
            return AdminSummary;
        }else if ([str isEqualToString:@"RegistrationTime"]){
            return RegistrationTime;
        }else if ([str isEqualToString:@"LastLoginTime"]){
            return LastLoginTime;
        }else if ([str isEqualToString:@"CurrentLoginDeviceID"]){
            return CurrentLoginDeviceID;
        }else if ([str isEqualToString:@"ExceptionFunctionList"]){
            return ExceptionFunctionList;
        }else if ([str isEqualToString:@"MyCompanyID"]){
            return MyCompanyID;
        }else if ([str isEqualToString:@"AdminOfFunction"]){
            return AdminOfFunction;
        }else {
        
            return MySalt;
        }

    }
    return  1000;
}



+(USE_STAT_ID)getEnumFormInt:(int )i{
    
    switch (i) {
        case 0:return UniqueAccount;
        case 1:return Password;

        case 2:return RealName;
        
        case 3:return mobile;
        
        case 4:return LandLine;
        
        case 5:return email;
        
        case 6:return ValidContac;
        
        case 7:return sex;
        
        case 8:return EmployeeNumber;
            
        case 9:return Department;
        
        case 10:return JobTitle;
        
        case 11:return Birthday;
        
        case 12:return OfficeAddress;
        
        case 13:return HomeAddress;
        
        case 14:return summary;
        
        case 15:return AdminType;
        
        case 16:return AdminSummary;
        
        case 19:return RegistrationTime;
        
        case 20:return LastLoginTime;
        
        case 21:return CurrentLoginDeviceID;
        
        case 23:return ExceptionFunctionList;
        
        case 24:return AdminOfFunction;
        
        case 25:return MyCompanyID;
        
        case 26:return MySalt;
        default:
        return 100000;
    };
}
/**
 * 返回管理员可以查询用户列表时使用的，条件的KEY的全集；
 * <br>查询时使用的key必须是该全集的子集或全集本身；
 * <pre>
 *USER_STAT_ID.UniqueAccount,
 *USER_STAT_ID.RealName,
 *USER_STAT_ID.EmployeeNumber,
 *USER_STAT_ID.Department,
 *USER_STAT_ID.JobTitle,
 *USER_STAT_ID.OfficeAddress,
 *USER_STAT_ID.AdminType,
 *USER_STAT_ID.AdminOfFunction, //指定管理员
 * </pre>
 * @return USER_STAT_ID[]数组
 */

+(NSArray *)getAdminCanQueryStats{
    return @[@"UniqueAccount",@"Mobile",@"Email",@"RealName",@"EmployeeNumber",@"Department",@"JobTitle",@"OfficeAddress",@"AdminType",@"AdminOfFunction"];

}




@end
