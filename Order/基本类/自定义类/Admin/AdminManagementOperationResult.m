//
//  AdminManagementOperationResult.m
//  Admint
//
//  Created by wang on 2016/11/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "AdminManagementOperationResult.h"
#import "UserOperation.h"
#import "UserOperationResultForGlobalAdmin.h"

@implementation AdminManagementOperationResult


/**
 * 构造函数 - 从JSON格式恢复成类对象；
 * <br><font style="color:green">***客户端使用，用来解析服务器发送回的对象***</font>
 * @param szJsonString   - 对象的JSONObject.toString()格式
 * @throws JSONException - 非法和不可解析的JSON格式，抛出此异常
 * @throws OrganizedException - 非法和不可解析的对象格式，抛出异常；
 */
-(instancetype)initWithJsonString:(NSString *)szJsonString{

    if (self = [super initWithJson:szJsonString]) {
       NSDictionary *object = [CommonFunctions functionsFromJsonStringToObject:szJsonString];
        if ([[object allKeys] containsObject:@"MNGTYPE"]) {
            NSNumber *iTypeIntFormat = object[@"MNGTYPE"];
            
            _m_enumManagement = [AdminManagementOperation fromManagementTypeInt:[iTypeIntFormat intValue]];
            [self __removeArgumentPair:@"MNGTYPE"];
        }

    }
    return self;
}



-(instancetype)initWithDic:(NSDictionary *)object{
    if (self = [super initWithDictionary:object keysets:nil]) {
        if ([[object allKeys] containsObject:@"MNGTYPE"]) {
            NSNumber *iTypeIntFormat = object[@"MNGTYPE"];
            
            _m_enumManagement = [AdminManagementOperation fromManagementTypeInt:[iTypeIntFormat intValue]];
            [self __removeArgumentPair:@"MNGTYPE"];
        }
      

    }
    
    if ([self isValid]) {
    return self;
    }else{
        return nil;
    }
    
}


/**
 * 转jsonobject的方法；
 */

-(NSMutableDictionary *)toJsonObject{
    NSMutableDictionary *object =[NSMutableDictionary dictionaryWithDictionary:[super toJsonObject]];
    if(!_m_enumManagement ){
        [object addEntriesFromDictionary:@{@"MNGTYPE":@(_m_enumManagement)}];
        
    }
    if(object.count == 0) return nil;
    return object;
}


/**
 * 获取管理员修改单个用户的某个或者某些属性时的操作 结果参数：
 * <br><font style="color:blue">客户端调用，用来得到操作的结果对象数组</font>
 * @return 修改的属性列表为空时，返回null；查询的消息非MANAGEMENT_TYPE.OPERATE_ON_USER，返回null;
 * @throws OrganizedException 修改的键值对中包含null key 或者  value，或者非法的key，则抛出异常；
 */
-(NSArray *)getAdminUserOperationResultArray{
    if(_m_enumManagement != OPERATE_ON_USER || ![self __hasArgument]) return nil;
    NSString *szValue = [self __getArgumentValue:@"ADMOPTUSERRESULT"];
    NSArray *userOperationsList = [UserOperation __stringToArrayOfAdminOptUserOperationResult:szValue objclass:[UserOperationResultForGlobalAdmin class]];
    if (userOperationsList == nil ||userOperationsList.count == 0) {
        return  userOperationsList;
    }
    return nil;
//    return (userOperationsList == null || userOperationsList.isEmpty()) ? null : userOperationsList.toArray(new UserOperationResultForGlobalAdmin[0]);
}



/**
 * 添加管理员需要执行完毕的操作结果的数组；
 * @param adminOperationResults 管理员操作执行完毕的结果数组；
 * @throws OrganizedException 参数错误，抛出异常；
 */

-(void)addAdminUserOperationResultArray:(NSArray *) adminOperationResults{
    NSString *szUserOperations =[UserOperation __arrayToStringOfUserChangeOperation:adminOperationResults];
    if(szUserOperations == nil){
        
        CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_RESULT_WRONGARGUMENT" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
    [self __addArgumentPairKey:@"ADMOPTUSERRESULT" value:szUserOperations];

}


/**
 * 获取管理员查询用户列表回应中的： 多个用户的账号和查询属性结果；
 * <br> 返回结果为一个hashmap,其KEY为用户的账号；value为包含属性-值对的另一个hashmap;
 * @return 修改的属性列表为空时，返回null；查询的消息非MANAGEMENT_TYPE.QueryUserList，返回null;
 * @throws OrganizedException   修改的键值对中包含null key 或者  value，或者非法的key，则抛出异常；
 */
-(NSDictionary *) getQueryMemberListResult{
    if(_m_enumManagement != QUERY_USER_LIST || ![self __hasArgument]) return nil;
    NSMutableDictionary * mpUserAndChangeKeyValuePairs = [NSMutableDictionary dictionary];
    for(NSString *szUserAccount in [self __getArgumentKeySet]){
        NSString *szUserData = [self __getArgumentValue:szUserAccount];
        if(![CommonFunctions  functionsIsStringValid:  szUserAccount] &&![CommonFunctions  functionsIsStringValid:  szUserData]){
            
            CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_RESULT_WRONGARGUMENT" reason:@"nil" userInfo:nil];
            [Ce raise];

        }
        
        @try {
            NSMutableDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:szUserData];
            NSArray *results = [OrganizedParams getAdminQueryResultStats];
        NSMutableDictionary *userChangeStatList = (NSMutableDictionary *)[UserOperation userStatsKeyValueMapFromJSON:dic arrPermitList:results];
            
            [mpUserAndChangeKeyValuePairs addEntriesFromDictionary:@{szUserAccount:userChangeStatList}];
        } @catch (NSException *exception) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ADMIN_MANAGEMENT_RESULT_WRONGARGUMENT" reason:@"nil" userInfo:nil];
            [Ce raise];
        }
      
    }
    if(mpUserAndChangeKeyValuePairs.count == 0) return nil;
    return mpUserAndChangeKeyValuePairs;		
}

/**
 * 判断是否参数列表为空；
 * @return true - 参数列表为空；false - 不为空；
 */
-(BOOL)isArgumentListEmpty{
    return ![self  __hasArgument];
}
-(NSString *)toString{
    if(![self isValid]) return nil;
    NSMutableDictionary *object =[NSMutableDictionary dictionaryWithDictionary:[self toJsonObject]];
    if(object == nil || object.count == 0) return nil;
    return  [CommonFunctions functionsFromObjectToJsonString:object];

}

-(BOOL)isValid {
    if(![super isValid]) return false;
    if(!_m_enumManagement) return false;
    return true;
}

@end
