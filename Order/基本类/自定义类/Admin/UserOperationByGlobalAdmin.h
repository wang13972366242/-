//
//  UserOperationByGlobalAdmin.h
//  Admint
//
//  Created by wang on 2016/11/17.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperation.h"

@interface UserOperationByGlobalAdmin : UserOperation

/**
 * 全局管理员可执行的对其他用户的操作（也包括自己）；
 * @version 0.56
 * <pre>
 * ReleaseNotes:
 * 1. 从JAR版本0.56开始支持；
 * 2. 具体的用户操作对象；
 * 3. 客户端应调用静态函数创建对象：
 * </pre>
 * @author Shuang
 *
 */

typedef enum ADMINMNG_USER_OPERATION{
    CHANGE_EMPLOYEE_NUMBER,
    CHANGE_DEPARTMENT_JOBTITLE,
    CHANGE_OFFICE_ADDRESS,
    ASSIGN_GLOBAL_ADMIN,
    RESIGN_GLOBAL_ADMIN,
    CHANGE_ADMIN_SUMMARY,
    ASSIGN_FUNCTIONADMIN,
    RESIGN_FUNCTIONADMIN,
    MOVE_OUT_COMPANY,
    QUERY_USER_CLIENT,
    QUERY_USER_ADMINDETAILS,
}ADMINMNG_USER_OPERATION;

-(instancetype)initWithEnum:(ADMINMNG_USER_OPERATION)operationByAdmin account:(NSString *)szUserAccount list:(NSDictionary *)argList;
//-(instancetype)initWithJsonString:(NSString *)szJsonString;


-(BOOL)isValid;
/**
 * 管理员修改用户的工号
 * @param szUserAccount - 待操作的用户账号
 * @param szNewEmployeeNumber - 新的员工工号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfChangeEmployeeNumberOperation:(NSString *)szUserAccount EmployeeNumber:(NSString *) szNewEmployeeNumber;

/**
 * 管理员修改用户的部门职位
 */
+(UserOperationByGlobalAdmin*) getInstanceOfChangeJobTitleOperation:(NSString *)szUserAccount department:(NSString *)szDepartment jobTitle:(NSString *)szJobTitle;

/**
 * 管理员修改用户的办公地址
 */
+(UserOperationByGlobalAdmin *) getInstanceOfChangeOfficeAddressOperation:(NSString *) szUserAccount address:(NSString *)szOfficeAddress;


/**
 * 管理员指定用户为全局管理员
 */
+(UserOperationByGlobalAdmin *) getInstanceOfAssignGlobalAdminOperation:(NSString *)szUserAccount;

/**
 * 管理员取消用户为全局管理员

 */
+(UserOperationByGlobalAdmin *) getInstanceOfResignGlobalAdminOperation:(NSString *)szUserAccount;

/**
 * 管理员修改用户的管理备注
 */
+(UserOperationByGlobalAdmin *) getInstanceOfChangeAdminSummaryOperation:(NSString *) szUserAccount  summary:(NSString *)szAdminSummary;

/**
 * 管理员指定用户为某功能的管理员
 */
+(UserOperationByGlobalAdmin *)getInstanceOfAssignFunctionAdminOperation:(NSString *)szUserAccount functionID:( FunctionID) ID;



/**
 * 管理员取消用户的某功能的管理员身份
 */

+(UserOperationByGlobalAdmin *) getInstanceOfResignFunctionAdminOperation:(NSString *)szUserAccount functionID:(FunctionID) ID;


/**
 * 管理员将用户移出公司
 */
+(UserOperationByGlobalAdmin *) getInstanceOfMoveOutCompanyOperation:(NSString *) szOperatorAccount;

/**
 * 管理员根据用户的账号查询某个用户的客户端对象；（OrganizedMember对象）
 */
+(UserOperationByGlobalAdmin *) getInstanceOfQueryUserClientInfoOperation:(NSString *)szOperatorAccount;

/**
 * 管理员根据用户账号，查询用户的服务器特性属性（客户端对象中不包含的属性）
 *  szOperatorAccount- 待操作的用户账号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；（如账号不合法）
 */

+(UserOperationByGlobalAdmin *) getInstanceOfQueryUserAdminDetailsOperation:(NSString *)szOperatorAccount;


+(NSString *)getStringForEnum:(ADMINMNG_USER_OPERATION)operation;

+(ADMINMNG_USER_OPERATION )getEnumForStr:(NSString *)operation;
@end

