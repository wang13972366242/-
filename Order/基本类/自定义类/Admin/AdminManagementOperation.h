//
//  AdminManagementOperation.h
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperation.h"

@interface AdminManagementOperation : UserOperation

typedef enum MANAGEMENT_OPERATION {
    OPERATE_ON_USER = 1,
    QUERY_USER_LIST,
    QUERY_COMPANY_STATS,
    OPERATE_ON_COMPANY,
    QUERY_COMPANY_STATISTICS, //保留 - 尚未实现
    QUERY_MEMBER_STATISTICS, //保
}MANAGEMENT_OPERATION;
/**
 * 管理员查询操作用户信息/公司信息对象；
 * @version 0.56
 * <pre>
 * ReleaseNotes:
 * 1.更改了MANAGEMENT_TYPE to MANAGEMENT_OPERATION
 * </pre>
 * @version 0.55
 * <pre>
 * ReleaseNotes:
 * 1.从JAR版本0.55开始支持；
 *
 * </pre>
 * @author Sophie_WS
 */

/** 枚举*/
@property(nonatomic,assign) MANAGEMENT_OPERATION m_enumManagement;

-(instancetype)initWithAcccount:(NSString *)szAdminAccount ENUM:(MANAGEMENT_OPERATION)operation;
/**
 * 从整数转换为MANAGEMENT_TYPE;
 */

-(instancetype)initWithJsonString:(NSString *)jsonString;

+(MANAGEMENT_OPERATION)fromManagementTypeInt:(int) iStatID;
/**
 * 判断对象是否有效；
 */

-(BOOL)isValid;



/**
 *
 * 管理员查询用户列表操作<br>
 */
+(AdminManagementOperation *)getInstanceOfAdminQueryUserListOperation:(NSString *)szAdminAccount dic:(NSDictionary *) mpQueryCondition;

/**
 * 管理员修改指定用户的信息
 */

+(AdminManagementOperation *) getInstanceOfAdminHandleUserOperation:(NSString *) szAdminAccount userArr:(NSArray *)userOperations;

/**
 * 管理员修改公司的信息；
 
 */
+(AdminManagementOperation *) getInstanceOfAdminChangeCompanyStatsOperation:(NSString *) szAdminAccount dic:(NSDictionary *)mpChangeKeyValuePairs;

-(NSString *) toString;
@end
