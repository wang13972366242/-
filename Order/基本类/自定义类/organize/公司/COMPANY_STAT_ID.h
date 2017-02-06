//
//  COMPANY_STAT_ID.h
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 公司属性枚举类
 *<br><pre style="color:blue">
 *公司姓名			Name,
 *用户手机号			Mobile,
 *用户邮件地址			Email,
 *用户联系方式验证标志			Validcontact,
 *用户座机号			Staticphone,
 *用户工作地址			Address,
 *公司类别			Type,
 *公司描述			Summary,
 *公司职位框架			JobTitlestructure,
 *公司功能列表			Funtionlist,
 *公司的激活码			Activationcode,
 *公司激活时间			Activationtime,
 *公司内部唯一码			UniqueID,
 *公司历史激活码			HistoryActivationcode,
 *公司历史购买信息			HistoryBillinginfo,
 *公司最大人数			MaxMember;
 *</pre>
 **/

typedef enum {
    Name,
    Mobile,
    Email,
    validcontac,
    Staticphone,
    Address,
    Type,
    Summary,
    JobTitlestructure,
    Functionlist,
    Activationcode,
    Activationtime,
    uniqueID,
    //	HistoryActivationcode,
    CurrentPurchaseinfo,
    MaxMember,
    
}COMPANy_STAT_ID;


@interface COMPANY_STAT_ID : NSObject


/**
 * 返回公司基础信息的属性列表
 * @return 属性数组
 */
+(NSArray *)getBaseCompanyStatList;

/**
 * 返回公司客户端完整信息的属性列表
 * @return 属性数组
 */
+(NSArray *)getClientCompanyStatList;

/**
 * 获取Unique属性的数组；
 * @return  属性数组
 */
-(NSArray *)getDBUniqueItemList;
+(COMPANy_STAT_ID)getEnumFormStr:(NSString *)str;
/**获取对应枚举的String*/
+(COMPANy_STAT_ID )getEnumForCompanyStatID:(int)ID;
+(NSString *)getKeyNameForCompanyStatID:(COMPANy_STAT_ID)ID;

+(NSArray *)getAdminCanSetCompanyStats;
@end
