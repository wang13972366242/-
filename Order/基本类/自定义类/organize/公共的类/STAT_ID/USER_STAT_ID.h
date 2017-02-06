//
//  USER_STAT_ID.h
//  organizeClass
//
//  Created by wang on 16/9/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * 用户属性枚举类
 *<br><pre style="color:blue">
 *用户帐号			UniqueAccount,
 *用户密码			Password,
 *用户姓名			RealName,
 *用户手机号			Mobile,
 *用户座机号			LandLine,
 *用户邮件地址			Email,
 *用户联系方式验证标志			ValidContact,
 *用户性别			Sex,
 *用户工号			EmployeeNumber,
 *用户所属部门			Department,
 *用户职位			JobTitle,
 *用户生日			Birthday,
 *用户工作地址			OfficeAddress,
 *用户家庭住址			HomeAddress,
 *用户个人说明			Summary,
 *用户是否为管理员			AdminType,
 *管理员标记的用户备注			AdminSummary,
 *当前的登录状态			CurrentLoginStatus,
 *激活的时间			ActivationTime,
 *注册的时间			RegistrationTime,
 *上次登录的时间			LastLoginTime,
 *当前登录的设备ID			CurrentLoginDeviceID,
 *历史登录设备ID			HistoryLoginDeviceID,
 *用户被禁用的功能ID列表			ExceptionFunctionList,
 *用户统计信息			StatisticsInfo,
 *用户所属的公司ID			MyCompanyID,
 *保密属性			MySalt;
 *</pre>
 */

typedef enum USE_STAT_ID {
   	UniqueAccount,
    Password,
    RealName,
    mobile,
    LandLine,
    email,
    ValidContac,
    sex,
    EmployeeNumber,
    Department,
    JobTitle,
    Birthday,
    OfficeAddress,
    HomeAddress,
    summary,
    AdminType,
    AdminSummary,
    //	CurrentLoginStatus,  	--- obsoleted
    //	ActivationTime, 		--- obsoleted
    RegistrationTime,
    LastLoginTime,
    CurrentLoginDeviceID,
    //	HistoryLoginDeviceID, 	--- obsoleted
    ExceptionFunctionList,
    //	StatisticsInfo,			--- obsoleted
    MyCompanyID,
    AdminOfFunction, //新增
    MySalt,
}USE_STAT_ID;




@interface USER_STAT_ID : NSObject
/**
 * 获取USERBEAN占用的属性
 * @return 属性数组
 */
+(NSArray *)getUserBeanMemberStatList;

/**
 * 获取OrganizedMember对象占用的属性
 * @return 属性数组
 */
+(NSArray *)getClientMemberStatList;
/**
 * 获取Unique属性的数组；
 * @return  属性数组
 */
-(NSArray *)getDBUniqueItemList;

+(USE_STAT_ID)getEnumFormInt:(int )i;


+(NSString *)getKeyNameForCompanyStatID:(USE_STAT_ID)ID;

/**
 *  放回USE_STAT_ID
 */
+(USE_STAT_ID)getEnumFormStr:(NSString *)str;

+(NSArray *)getAdminCanQueryStats;
@end
