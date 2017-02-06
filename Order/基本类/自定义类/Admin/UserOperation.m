//
//  UserOperation.m
//  Admint
//
//  Created by wang on 2016/11/17.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperation.h"
#import "OrganizedParams.h"
@implementation UserOperation

/**
 * 从json string恢复成对象；
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @param szJsonString 待解析的JSON字符串
 * @throws JSONException 无法解析为JSON对象时抛出异常；
 * @throws OrganizedException 非本类合法的JSON对象，抛出异常；
 */

-(instancetype)initWithJson:(NSString *)szJsonString{
    
    
    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:szJsonString];
    return  [self initWithDic:dic];
    
}

-(instancetype)initWithDic:(NSDictionary *)object{
    if (self = [super initWithDic:object]) {
        _m_eOperation = [self __getArgumentValue:@"USROPT"];
        if (_m_eOperation == nil &&[[object allKeys] containsObject:@"USROPT"]) {
            _m_eOperation = [CommonFunctions functionsFromObjectToJsonString:object[@"USROPT"]];
        }
        
    }
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
    

}


-(instancetype)initWithOperation:(NSString *)operation account:(NSString *)szUserAccount{

    if (self = [super initWithszAccount:szUserAccount]) {
        _m_eOperation = operation;
    }
    return self;
}

-(instancetype )initWithcreatUserOperationWithOperation:(NSString *)operation account:(NSString *)szUserAccount dic:(NSDictionary *)argList{
   
   UserOperation *userO = [[UserOperation alloc] initWithOperation:operation account:szUserAccount];
    [userO __addUserStatMap:argList];
    if ([userO isValid]) {
        return userO;
    }else{
        return nil;
    }
    
    
}

/**
 * 校验参数，并转化为String格式；
 * @param operations 用户操作集合
 * @return 转化为的字符串形式；
 */
+(NSString *) __arrayToStringOfUserChangeOperation:(NSArray *) operations{
    if(operations == nil){
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    for(UserOperation *operation in operations){
        if(operation == nil) return nil;
        NSString *szOperationContent = [operation toString];
        if(szOperationContent == nil) return nil;
        [array addObject:szOperationContent];
        
    }
    if(array.count == 0) return nil;
    return  [CommonFunctions functionsFromObjectToJsonString:array];
    
}


/**
 * 字符串转化为useroperation的动态数组，其中的对象并非都是useroperation; 而是通过反射动态new的对象；
 *
 */
+(NSArray *) __stringToArrayOfAdminOptUserOperationResult:(NSString *)szJsonArrayString  objclass:(id)objclass{
    if(objclass == nil){return nil;}

      NSMutableArray *operations = [NSMutableArray array];
    @try {
      
        NSArray *array = [CommonFunctions functionsFromJsonStringToObject:szJsonArrayString];
        for(id  object in array){
            if(object == nil) return nil;
            
            //利用反射；
        if ([object isKindOfClass:[UserOperation class]]) {
            UserOperation *userO = (UserOperation *)object;
        UserOperation *operation =  [[UserOperation alloc]initWithJson:[userO toString]];
            [operations addObject:operation];
            
        }
        }
        if(operations.count == 0) return nil;
        return operations;
    } @catch (NSException *exception) {
        return  nil;
    }
  
        
        
}


-(void)__addUserStatValue:( USE_STAT_ID)statID value:(NSString *) szValue{
    NSString *userStr = [USER_STAT_ID getKeyNameForCompanyStatID:statID];
    [self __addArgumentPair:userStr szValue:szValue];
}


//
//-(NSString *)__getUserStatValue:(USE_STAT_ID ) statID{
//    NSString *userStr = [USER_STAT_ID getKeyNameForCompanyStatID:statID];
//    return  [self __getArgumentValue:userStr];
//    
//    
//}




-(void)__addUserStatMap:(NSDictionary *) mpValues{
    [self __setDBColumsStatValue:mpValues ];
//    if(mpValues != nil && !(mpValues.count >1)){
//    for(NSString * colunm in [mpValues allKeys]){
//        
//        [self  __addArgumentPairKey:<#(NSString *)#> value:<#(NSString *)#>]
//        __addArgumentPair(colunm.getDBColumnName(), mpValues.get(colunm));
//    }
//        }
    
}



/**
 * 添加公司员工的对象的String的形式；
 * <em style="color:red">***仅供服务器使用***</em>
 * @param szMemberInfo 员工的String对象形式；
 * @throws OrganizedException - 参数有误的情况下抛出异常；
 */
-(void)__addOrganizedMember:(NSString *) szMemberInfo{
    [self __addArgumentObject:[OrganizedMember class] szObject:szMemberInfo];
    
}

-(OrganizedMember *) __getOrganizedMember{
    
    id obj = [self getOrganizedMember:[OrganizedMember class]];
    @try {
        return (OrganizedMember *)obj;
    } @catch (NSException *exception) {
        return  nil;
    }
    
}



/**
 * 返回操作所涉及的功能ID
 * @return 功能ID
 */
-(FunctionID)	getFunctionID{
    @try {
        NSString *funStr =  [self __getArgumentValue:@"FUNCTIONID"];
        FunctionID funID = [CompanyFunction getEnumFormStr:funStr];
        
        return funID;
    } @catch (NSException *exception) {
        return  100000;
    }
 
}


/**
 * 设置操作所涉及的功能ID
 
 */
-(void )setFunctionID:(FunctionID) ID {
    NSString *str ;
    [self __addArgumentPairKey:@"FUNCTIONID" value:str == nil ?nil:[CompanyFunction getStringFormEnum:ID]];

}




-(BOOL)isValid{
    //基类无效，返回false;
    if(![super isValid]) return false;
    if(_m_eOperation == nil){
        return false;
    }
    return true;
}



-(NSString *)toString{
    
    if(![self isValid]) return nil;
    NSMutableDictionary *object = [self toJsonObject];
    if(object == nil || object.count == 0) return nil;
    return [CommonFunctions functionsFromObjectToJsonString:object];

}


-(NSDictionary *)toJsonObject{
    NSMutableDictionary *object = [super toJsonObject];
    if(_m_eOperation != nil){
        [object addEntriesFromDictionary:@{@"USROPT":_m_eOperation}];

    }
    return object;
}



/**
 * 对于多用户修改参数来说，需要把用户需修改的参数列表转换为JSONArray格式，
 * 此函数为从HashMap键值对的格式转换为JSONObject；
 * @param userKeyValuePairs 需转换的有效的对象；不可包含null;
 * @param arrPermitList - 对HASHMAP参数中的KEY是否要限定在某个范围，如为null, 表示无限制；否则，待转换的key必须在指定的数据中才有效，否则抛出异常；
 * @return JSONARRAY 对象 - 不会返回null或者空对象，两种情况下会抛出异常；
 * @throws OrganizedException 参数无效（参考参数说明）的情况下抛出异常；
 */
-(NSDictionary *)userStatsKeyValueMapToJSON:(NSDictionary *)userKeyValuePairs arrPermitList:(NSArray *)arrPermitList{
    if(userKeyValuePairs == nil || userKeyValuePairs.count <1  ){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"userStatsKeyValueMapToJSONArray" userInfo:nil];
        [Ce raise];
        
    }
    //检查KEY；
    for(NSString *ID in [userKeyValuePairs allKeys]){
        if(arrPermitList != nil  && ![arrPermitList containsObject:ID]){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"NOT PERMITED USER_STAT_ID:" userInfo:nil];
            [Ce raise];
    
        }
    }
    NSMutableDictionary *object =(NSMutableDictionary *)[BaseArgumentList convertHashMapToJSONObject:userKeyValuePairs];
    if(object.count == 0){
        CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"userStatsKeyValueMapToJSONArray" userInfo:nil];
        [Ce raise];
    
    
    
    }
    return object;
    
}

/**
 * 对于多用户修改参数来说，需要把用户需修改的参数列表转换为JSONArray格式，
 * 此函数为从被转换的JSONArray恢复成HashMap键值对的格式；
 * @param dic - 需转换的JSONArray对象；
 * @param arrPermitList - 参数包含的Key USER_STAT_ID需限定在某个范围内，超范围抛出异常； 若此处为null,则表示无限制；
 * @return  有效的对象，不会返回null;
 * @throws OrganizedException 结果为空，或者参数格式有误，抛出异常；
 */


+(NSDictionary *)userStatsKeyValueMapFromJSON:(NSDictionary *) object arrPermitList:(NSArray *) arrPermitList{
     NSMutableDictionary *resultMap = [NSMutableDictionary dictionary];
    if(object !=nil  || object.count > 0){
        NSMutableDictionary *tmpResultMap = (NSMutableDictionary *)[BaseArgumentList convertJSONObjectToHashMap:object];
    //检查KEY；
       
        [tmpResultMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *memberDBColumns =  [OrganizedParams convertStringToMemberDBColumns:key];
        
        if(memberDBColumns == nil){
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"userStatsKeyValueMapFromJSONArray" userInfo:nil];
            [Ce raise];
        }
            
        if(arrPermitList != nil  && [arrPermitList containsObject:memberDBColumns]){
            [resultMap addEntriesFromDictionary:@{memberDBColumns:object}];
        }

        }];
        
        if (resultMap.count == 0) {
            CodeException *Ce =[[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"" userInfo:nil];
            [Ce raise];
        }
    

    
    }
        return resultMap;
}

@end
