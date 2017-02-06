//
//  UserOperationByGlobalAdmin.m
//  Admint
//
//  Created by wang on 2016/11/17.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperationByGlobalAdmin.h"

@implementation UserOperationByGlobalAdmin

-(instancetype)initWithEnum:(ADMINMNG_USER_OPERATION)operationByAdmin account:(NSString *)szUserAccount list:(NSDictionary *)argList{
    if (self = [super initWithcreatUserOperationWithOperation:[UserOperationByGlobalAdmin getStringForEnum:operationByAdmin] account:szUserAccount dic:argList]) {
        
    }
    return self;

}


/**
 *  服务器用来恢复对象时使用；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @param szJsonString 符合对象格式的json字符串；
 * @throws JSONException 字符串不可解析为JSONObject时，抛出异常；
 * @throws OrganizedException 字符串为不可解析成本类对象的JSONObject时，抛出异常；
 */
//-(instancetype)initWithJsonString:(NSString *)szJsonString{
//    if (self = [super initWithJsonString:szJsonString]) {
//        
//    }
//    return self;
//}

/**
 * 在操作为：CHANGE_USER_OPERATION.CHANGE_ADMIN_SUMMARY 的情况下，获取用户新的admin summary；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @return null - if操作类型不匹配或者Summary为空；
 */
//-(NSString *) getUserAdminSummary{
//    if ([self getUserOperationByAdmin] !=CHANGE_ADMIN_SUMMARY ) {
//        return  nil;
//    }
//    NSString *admiStr = [USER_STAT_ID getKeyNameForCompanyStatID:AdminSummary];
//    return [self __getArgumentValue:admiStr];
//}


-(ADMINMNG_USER_OPERATION)getUserOperationByAdmin{
    @try {
        return [UserOperationByGlobalAdmin getEnumForStr:self.m_eOperation];

    } @catch (NSException *exception) {
        return 1000000;
    }
}


/**
 * 在操作为：CHANGE_USER_OPERATION.CHANGE_EMPLOYEE_NUMBER 的情况下，获取用户新的工号；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 
 */
//-(NSString *)getUserEmployeeNumber{
//    if([self getUserOperationByAdmin] != CHANGE_EMPLOYEE_NUMBER) return nil;
//    return  [self __getUserStatValue:EmployeeNumber];
//    
//}

//-(NSString *)getUserDepartment{
//     return  [self __getUserStatValue:Department];
//}

/**
 * 在操作为：CHANGE_USER_OPERATION.CHANGE_JOBTITLE 的情况下，获取用户的新职位；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @return 取到的用户职位名字
 */
//-(NSString *)getUserJobTitle{
//    return  [self __getUserStatValue:JobTitle];
//}


/**
 * 在操作为：CHANGE_USER_OPERATION.CHANGE_OFFICE_ADDRESS 的情况下，获取用户新的OFFICE地址；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @return null - if操作类型不匹配或者地址为空；
 */
//-(NSString *)getUserOfficeAddress{
//      return  [self __getUserStatValue:OfficeAddress];
//}
//
//

/**
 * 在操作为：CHANGE_USER_OPERATION.ASSIGN_FUNCTIONADMIN or RESIGN_FUNCTIONADMIN 的情况下，获取用户的admin function id；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @return null - if操作类型不匹配或者admin function id 不匹配；
 */
//-(FunctionID) getUserAdminFunctionID{
//    
//    @try {
//        
//        FUNCTIONID ID = [USER_STAT_ID  ]
//    } @catch (NSException *exception) {
//        
//    }
//    
//    try{
//        FUNCTIONID id = FUNCTIONID.valueOf(__getArgumentValue(USER_SERVER_STAT.AdminOfFunction));
//        return id;
//    }catch(Exception e){
//        return null;
//    }
//}





-(BOOL)isValid{
    if(![super isValid]) return false;
    if(![self __hasArgument]){ //不属于可以不带参数的操作类型,但实际却没有参数时，返回false;
       NSArray *arrArgCanBeEmpty = [UserOperationByGlobalAdmin getRequestArgumentCanBeEmptyList];
        ADMINMNG_USER_OPERATION userOperation = [self  getUserOperationByAdmin];
        NSString *str = [UserOperationByGlobalAdmin getStringForEnum:userOperation];
        if (![arrArgCanBeEmpty containsObject:str]) {
            return  false;
        }
    }
    return true;
}



//==================静态函数=============

/**
 * 管理员修改用户的工号
 * @param szUserAccount - 待操作的用户账号
 * @param szNewEmployeeNumber - 新的员工工号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfChangeEmployeeNumberOperation:(NSString *)szUserAccount EmployeeNumber:(NSString *) szNewEmployeeNumber{

    NSMutableDictionary * mpArgList = [NSMutableDictionary dictionary];
    [mpArgList addEntriesFromDictionary:@{@"EmployeeNumber":szNewEmployeeNumber}];
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:CHANGE_EMPLOYEE_NUMBER account:szUserAccount list:mpArgList];
    return operationUser;
}


/**
 * 管理员修改用户的部门职位
 * @param szUserAccount - 待操作的用户账号
 * @param szDepartment - 新的员工职位所属的部门
 * @param szJobTitle -  - 新的员工职位
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin*) getInstanceOfChangeJobTitleOperation:(NSString *)szUserAccount department:(NSString *)szDepartment jobTitle:(NSString *)szJobTitle{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szDepartment]){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_CHANGEUSERSTAT_WRONGARGUMENT" reason:@"" userInfo:nil];
        [Ce raise];
    }
    
    NSMutableDictionary * mpArgList = [NSMutableDictionary dictionary];
    [mpArgList addEntriesFromDictionary:@{@"Department":szDepartment}];
     [mpArgList addEntriesFromDictionary:@{@"JobTitle":szJobTitle}];
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:CHANGE_DEPARTMENT_JOBTITLE account:szUserAccount list:mpArgList];
    return operationUser;
}

/**
 * 管理员修改用户的办公地址
 * @param szUserAccount - 待操作的用户账号
 * @param szOfficeAddress - 员工新的办公地址
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfChangeOfficeAddressOperation:(NSString *) szUserAccount address:(NSString *)szOfficeAddress{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szOfficeAddress]){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_CHANGEUSERSTAT_WRONGARGUMENT" reason:@"" userInfo:nil];
        [Ce raise];
    }
    
    NSMutableDictionary * mpArgList = [NSMutableDictionary dictionary];
    [mpArgList addEntriesFromDictionary:@{@"OfficeAddress":szOfficeAddress}];
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:CHANGE_OFFICE_ADDRESS account:szUserAccount list:mpArgList];
    return operationUser;

}



/**
 * 管理员指定用户为全局管理员
 * @param szUserAccount - 待操作的用户账号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfAssignGlobalAdminOperation:(NSString *)szUserAccount{
       UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:ASSIGN_GLOBAL_ADMIN account:szUserAccount list:nil];

    return operationUser;
}

/**
 * 管理员取消用户为全局管理员
 * @param szUserAccount - 待操作的用户账号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfResignGlobalAdminOperation:(NSString *)szUserAccount{
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:RESIGN_GLOBAL_ADMIN account:szUserAccount list:nil];

    return operationUser;
}


/**
 * 管理员修改用户的管理备注
 * @param szUserAccount - 待操作的用户账号
 * @param szAdminSummary - 员工新的管理备注
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfChangeAdminSummaryOperation:(NSString *) szUserAccount  summary:(NSString *)szAdminSummary{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szAdminSummary]){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_CHANGEUSERSTAT_WRONGARGUMENT" reason:@"" userInfo:nil];
        [Ce raise];
    }
    NSMutableDictionary * mpArgList = [NSMutableDictionary dictionary];
    [mpArgList addEntriesFromDictionary:@{@"AdminSummary":szAdminSummary}];
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:CHANGE_ADMIN_SUMMARY account:szUserAccount list:mpArgList];
    return operationUser;
}



/**
 * 管理员指定用户为某功能的管理员
 * @param szUserAccount - 待操作的用户账号
 * @param ID - 员工指定为此功能的管理员
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *)getInstanceOfAssignFunctionAdminOperation:(NSString *)szUserAccount functionID:( FunctionID) ID{
    if(!ID ){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_CHANGEUSERSTAT_WRONGARGUMENT" reason:@"功能不存在" userInfo:nil];
        [Ce raise];

    }
    NSMutableDictionary * mpArgList = [NSMutableDictionary dictionary];
    NSString *functionStr = [CompanyFunction getStringFormEnum:ID];
    [mpArgList addEntriesFromDictionary:@{@"AdminOfFunction":functionStr}];
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:ASSIGN_FUNCTIONADMIN account:szUserAccount list:mpArgList];
    return operationUser;
}



/**
 * 管理员取消用户的某功能的管理员身份
 * @param szUserAccount - 待操作的用户账号
 * @param ID - 员工指定为取消此功能的管理员身份
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；
 */

+(UserOperationByGlobalAdmin *) getInstanceOfResignFunctionAdminOperation:(NSString *)szUserAccount functionID:(FunctionID) ID{
    if(!ID ){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_CHANGEUSERSTAT_WRONGARGUMENT" reason:@"功能不存在" userInfo:nil];
        [Ce raise];
    }
    
    NSMutableDictionary * mpArgList = [NSMutableDictionary dictionary];
    NSString *functionStr = [CompanyFunction getStringFormEnum:ID];
    [mpArgList addEntriesFromDictionary:@{@"AdminOfFunction":functionStr}];
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:RESIGN_FUNCTIONADMIN account:szUserAccount list:mpArgList];
    return operationUser;
}

/**
 * 管理员将用户移出公司
 * @param szOperatorAccount - 待操作的用户账号
 * @throws OrganizedException 参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfMoveOutCompanyOperation:(NSString *) szOperatorAccount{
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:MOVE_OUT_COMPANY account:szOperatorAccount list:nil];
    return operationUser;
}


/**
 * 管理员根据用户的账号查询某个用户的客户端对象；（OrganizedMember对象）
 *  szOperatorAccoun- 待操作的用户账号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException  参数校验出错跳出异常；
 */
+(UserOperationByGlobalAdmin *) getInstanceOfQueryUserClientInfoOperation:(NSString *)szOperatorAccount{
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:QUERY_USER_CLIENT account:szOperatorAccount list:nil];
    return operationUser;
 
}

/**
 * 管理员根据用户账号，查询用户的服务器特性属性（客户端对象中不包含的属性）
 *  szOperatorAccount- 待操作的用户账号
 * @return UserOperationByGlobalAdmin
 * @throws OrganizedException 参数校验出错跳出异常；（如账号不合法）
 */

+(UserOperationByGlobalAdmin *) getInstanceOfQueryUserAdminDetailsOperation:(NSString *)szOperatorAccount{
    
    UserOperationByGlobalAdmin  *operationUser = [[UserOperationByGlobalAdmin alloc]initWithEnum:QUERY_USER_ADMINDETAILS account:szOperatorAccount list:nil];
    return operationUser;

}


+(NSArray *)getRequestArgumentCanBeEmptyList{
    
    return @[@"ASSIGN_GLOBAL_ADMIN",@"RESIGN_GLOBAL_ADMIN",@"MOVE_OUT_COMPANY",@"QUERY_USER_CLIENT",@"QUERY_USER_ADMINDETAILS"];

}

+(ADMINMNG_USER_OPERATION )getEnumForStr:(NSString *)operation{
    if ([operation isEqualToString:@"CHANGE_EMPLOYEE_NUMBER"]) {
        return  CHANGE_EMPLOYEE_NUMBER;
    }else if ([operation isEqualToString:@"CHANGE_DEPARTMENT_JOBTITLE"]){
    return  CHANGE_DEPARTMENT_JOBTITLE;
    
    }else if ([operation isEqualToString:@"CHANGE_OFFICE_ADDRESS"]){
        return  CHANGE_OFFICE_ADDRESS;
    }else if ([operation isEqualToString:@"ASSIGN_GLOBAL_ADMIN"]){
        return  ASSIGN_GLOBAL_ADMIN;
    }else if ([operation isEqualToString:@"RESIGN_GLOBAL_ADMIN"]){
        return  RESIGN_GLOBAL_ADMIN;
    }else if ([operation isEqualToString:@"CHANGE_ADMIN_SUMMARY"]){
        return  CHANGE_ADMIN_SUMMARY;
    }else if ([operation isEqualToString:@"ASSIGN_FUNCTIONADMIN"]){
        return  ASSIGN_FUNCTIONADMIN;
    }else if ([operation isEqualToString:@"RESIGN_FUNCTIONADMIN"]){
        return  RESIGN_FUNCTIONADMIN;
    }else if ([operation isEqualToString:@"MOVE_OUT_COMPANY"]){
        return  MOVE_OUT_COMPANY;
    }else if ([operation isEqualToString:@"QUERY_USER_CLIENT"]){
        return  QUERY_USER_CLIENT;
    }else if ([operation isEqualToString:@"QUERY_USER_ADMINDETAILS"]){
        return QUERY_USER_ADMINDETAILS ;
    }

    return 1000000;
}

+(NSString *)getStringForEnum:(ADMINMNG_USER_OPERATION)operation{
    switch (operation) {
        case CHANGE_EMPLOYEE_NUMBER:
           return  @"CHANGE_EMPLOYEE_NUMBER";
            break;
        case CHANGE_DEPARTMENT_JOBTITLE:
            return  @"CHANGE_DEPARTMENT_JOBTITLE";
            break;
        case CHANGE_OFFICE_ADDRESS:
            return  @"CHANGE_OFFICE_ADDRESS";
            break;
        case ASSIGN_GLOBAL_ADMIN:
            return  @"ASSIGN_GLOBAL_ADMIN";
            break;
        case RESIGN_GLOBAL_ADMIN:
            return  @"RESIGN_GLOBAL_ADMIN";
            break;
        case CHANGE_ADMIN_SUMMARY:
            return  @"CHANGE_ADMIN_SUMMARY";
            break;
        case ASSIGN_FUNCTIONADMIN:
            return  @"ASSIGN_FUNCTIONADMIN";
            break;
        case RESIGN_FUNCTIONADMIN:
            return  @"RESIGN_FUNCTIONADMIN";
            break;
        case MOVE_OUT_COMPANY:
            return  @"MOVE_OUT_COMPANY";
            break;
        case QUERY_USER_CLIENT:
            return  @"QUERY_USER_CLIENT";
            break;
        case QUERY_USER_ADMINDETAILS:
            return  @"QUERY_USER_ADMINDETAILS";
            break;
        default:
            break;
    }


}

@end
