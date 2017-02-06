//
//  AdminManagementOperation.m
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "AdminManagementOperation.h"
#import "UserOperation.h"
#import "USER_STAT_ID.h"
#import "COMPANY_STAT_ID.h"
@implementation AdminManagementOperation


-(instancetype)initWithAcccount:(NSString *)szAdminAccount ENUM:(MANAGEMENT_OPERATION)operation{
    if (self = [super initWithszAccount:szAdminAccount]) {
        _m_enumManagement = operation;
        
    }
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
    
}

/**
 * 从整数转换为MANAGEMENT_TYPE;
 * @param iStatID MANAGEMENT_TYPE的整数形式；
 * @return MANAGEMENT_TYPE
 * @throws OrganizedException 无效的输入整数
 */

+(MANAGEMENT_OPERATION)fromManagementTypeInt:(int) iStatID{
    if(iStatID < 1 || iStatID > 6){
        CodeException *Ce =[[CodeException alloc]initWithName:@"MANAGEMENTTYPE_FROMINT_OUTOFRANGE" reason:@"nil" userInfo:nil];
        [Ce raise];
        
    }
    return [AdminManagementOperation getManagementEum:iStatID];
}


-(instancetype)initWithJsonString:(NSString *)jsonString{
    
    if (self = [super initWithJsonString:jsonString]) {
        NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:jsonString];
        [self accordingDictionaryToObject:dic];
    }
    return  self;
    
}

-(void)accordingDictionaryToObject:(NSDictionary *)object
{
    if ([[object allKeys] containsObject:@"MNGTYPE"]) {
        
        NSNumber *number = object[@"MNGTYPE"];
        MANAGEMENT_OPERATION operation = [AdminManagementOperation getManagementEum:[number intValue]];
        _m_enumManagement = operation;
        
    }else{
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_OPERATION_WRONGARGUMENT" reason:@"OrganizedManagementRequest - no MANAGEMENT_TYPE in source" userInfo:nil];
        [Ce raise];
        
    }
    
}

/**
 *
 * 管理员查询用户列表操作<br>
 * 管理员根据指定用户条件查询对应的用户列表；
 * <br> 用户最终会获得服务器返回的符合条件的用户列表，或者null(无符合条件的);
 * @param szAdminAccount - 当前登录的管理员帐号
 * @param mpQueryCondition - 查询条件，用户属性-值对应的pair. 可使用条件参考：{@linkplain USER_STAT_ID#getAdminCanQueryStats()};
 * @return AdminManagementOperation对象，以供发送给服务器查询；如果组装对象是无效对象，则返回null;
 * @throws OrganizedException - 参数错误，或者查询条件非法，跳出异常；
 *
 */
+(AdminManagementOperation *)getInstanceOfAdminQueryUserListOperation:(NSString *)szAdminAccount dic:(NSDictionary *) mpQueryCondition{
    AdminManagementOperation *operation = [[AdminManagementOperation alloc]initWithAcccount:szAdminAccount ENUM:QUERY_USER_LIST];
    [operation _addUserListQueryCondition:mpQueryCondition];
    
    
    return operation;
}
/**
 * 管理员修改指定用户的信息
 * @param szAdminAccount  - 当前登录的管理员帐号
 * @param userOperations  - 需要对对象进行的操作集合
 * @return 组装好的AdminManagementOperation - 如果组装失败，有无效参数，抛出异常；
 * @throws OrganizedException 参数有误抛出异常；
 */

+(AdminManagementOperation *) getInstanceOfAdminHandleUserOperation:(NSString *) szAdminAccount userArr:(NSArray *)userOperations{
    AdminManagementOperation *operation = [[AdminManagementOperation alloc]initWithAcccount:szAdminAccount ENUM:OPERATE_ON_USER];
    [operation addAdminUserOperationArray:userOperations];
    
    return operation;
}


/**
 * <font style="color:red">暂未完成 </font>
 *
 * @param szAdminAccount  - 当前登录的管理员帐号
 * @return 组装好的AdminManagementOperation - 如果组装失败，有无效参数，抛出异常；
 * @throws OrganizedException  参数有误抛出异常；
 */

+(AdminManagementOperation *) getInstanceOfAdminHandleCompanyOperation:(NSString *)szAdminAccount {
    //TODO
    //		AdminManagementOperation operation = new AdminManagementOperation(szAdminAccount,MANAGEMENT_OPERATION.OPERATE_ON_COMPANY);
    //		operation.addAdminUserOperationArray(userOperations);
    //		return operation;
    return nil;
}



/**
 * 管理员修改公司的信息；
 * @param szAdminAccount - 当前登录的管理员帐号
 * @param mpChangeKeyValuePairs - 需要被修改的用户属性键值对；
 * @return - 如果组装失败，有无效参数，抛出异常；
 * @throws OrganizedException 参数有误抛出异常；
 */
+(AdminManagementOperation *) getInstanceOfAdminChangeCompanyStatsOperation:(NSString *) szAdminAccount dic:(NSDictionary *)mpChangeKeyValuePairs{
    NSArray *arrList = [COMPANY_STAT_ID getAdminCanSetCompanyStats];
    NSMutableArray *arrListIDCanBeUsed = [NSMutableArray arrayWithArray:arrList];
    if(mpChangeKeyValuePairs == nil ){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_OPERATION_WRONGARGUMENT" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
    AdminManagementOperation *operation = [[AdminManagementOperation alloc]initWithAcccount:szAdminAccount ENUM:OPERATE_ON_COMPANY];
    
    for(NSString *ID in [mpChangeKeyValuePairs allKeys]){
        if(![arrListIDCanBeUsed containsObject:ID]){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_OPERATION_WRONGARGUMENT" reason:@"nil" userInfo:nil];
            [Ce raise];
        }
        [operation __addArgumentPairKey:ID value:mpChangeKeyValuePairs[ID]];
    }
    if([operation isValid])	return operation;
    return nil;
}


+(MANAGEMENT_OPERATION)getManagementEum:(int)ID{
    switch (ID) {
        case 1:
            return  OPERATE_ON_USER;
            break;
        case 2:
            return QUERY_USER_LIST;
            break;
        case 3:
            return QUERY_COMPANY_STATS;
            break;
        case 4:
            return OPERATE_ON_COMPANY;
            break;
        case 5:
            return QUERY_COMPANY_STATISTICS;
            break;
        case 6:
            return QUERY_MEMBER_STATISTICS;
            break;
            
        default:
            break;
    }
    return 10000;
    
}






/**
 * 判断对象是否有效；
 */
-(BOOL)isValid{
    
    if(![super isValid]) return false;
    if (!_m_enumManagement) {
        return false;
    }else{
        return true;
    }
}





/**
 * 添加 管理员查询用户列表时的参数列表
 * <br> 这里不检测是否有null的值，比如自己所属公司的UNIQUEID可以为null；
 * @param statConditions - 添加条件的keyvalue pairs, 目前支持的多条件之间是and关系；
 * @throws OrganizedException 参数错误；
 
 */

-(void)_addUserListQueryCondition:(NSDictionary *)statConditions{
    NSArray *arrQueryStats = [USER_STAT_ID getAdminCanQueryStats];
    NSMutableArray *arrListIDCanBeUsed = [NSMutableArray arrayWithArray:arrQueryStats];
    
    if(statConditions == nil  ||[statConditions allKeys].count == 0){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_OPERATION_WRONGARGUMENT" reason:@"nil" userInfo:nil];
        [Ce raise];
        
    }
    
    for(NSString *ID in [statConditions allKeys]){
        if(![arrListIDCanBeUsed containsObject:ID]){
            
            CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_OPERATION_WRONGARGUMENT" reason:@"nil" userInfo:nil];
            [Ce raise];
        }
        [self __addArgumentPairKey:ID value:statConditions[ID]];
        
    }
    
}


/**
 * 添加管理员需要执行的操作的数组；
 * @param adminOperations 管理员操作数组；
 * @throws OrganizedException 参数错误，抛出异常；
 */
-(void)addAdminUserOperationArray:(NSArray *)adminOperations{
    NSString *szUserOperations = [UserOperation __arrayToStringOfUserChangeOperation:adminOperations];
    
    if(szUserOperations == nil){
        
        
        CodeException *Ce =[[CodeException alloc]initWithName:@" 添加管理员数据为空" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
    [self __addArgumentPairKey:@"ADMOPTUSER" value:szUserOperations];
}

-(NSString *) toString{
    
    if(![self isValid]) return nil;
    NSMutableDictionary *object = [self toJsonObject];
    if(object == nil || object.count == 0) return nil;
    return [CommonFunctions functionsFromObjectToJsonString:object];
}



//==========================================Private Method==============================


-(NSDictionary *)toJsonObject{
    NSMutableDictionary *object =[NSMutableDictionary dictionaryWithDictionary:[super toJsonObject]];
    if(object != nil && object.count != 0){
        [object addEntriesFromDictionary:@{@"MNGTYPE":@(_m_enumManagement) }];
    }else{
        return nil;
    }
    
    return object;
}



@end
