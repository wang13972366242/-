//
//  FunctionOperation.m
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "FunctionOperation.h"
//#import "CompanyFunction.h"
@implementation FunctionOperation



/**
 * 根据操作类型，确定是否需要管理员权限；
 * @return true - 本操作需要管理员权限，false - 本操作不需要管理员权限；
 */
-(BOOL)getAdminPrivilegeFlag:(FUNCTION_OPERATION)functionOperation{
    switch (functionOperation) {
        case GET_CONFIG:
        case SET_FUNCDATA:
        case GET_FUNCDATA:
            return false;
        case SET_CONFIG:
        case QUERY_USERLIST:
        case QUERY_USER_FUNCDATA:
        case CHANGE_USER_FUNCDATA:
        case DISABLE_USER_FUNCTION:
        case ENABLE_USER_FUNCTION:
        case ASSIGN_USER_FUNCADMIN:
        case RESIGN_SELF_FUNCADMIN:
            return true;
        default:
            break;
    }
    return true;
}


/**
 * 构造函数
 * @param szUserAccount -- 用户操作账号
 * @param operation  -- 功能操作种类
 * @param functionClass  -- 功能参数的CLASS
 * @throws OrganizedException -- 参数错误
 */

-(instancetype)initWithUsrAccount:(NSString *)szUserAccount operation:(FUNCTION_OPERATION)operation class:(id)functionClass{
    FunctionID funcID = [FunctionOperation getfunctionIDFrom:functionClass];
    
   return  [self initWithUserAccount:szUserAccount operation:operation functionID:funcID];
    
}


/**
 * 构造函数
 * @param szUserAccount -- 用户操作账号
 * @param operation -- 功能操作种类
 * @throws OrganizedException 参数出错；
 */

-(instancetype)initWithUserAccount:(NSString *)account operation:(FUNCTION_OPERATION)operation functionID:(FunctionID)functionID{

    if (self = [super initWithOperation:[FunctionOperation getFunctionOperationString:operation] account:account]) {
        [self setFunctionID:functionID];
    }
    
    if ([self isValid]) {
    return self;
    }else{
    
        return nil;
    }
    
}



/**
 *  构造函数 - 从JSON格式恢复成类对象；
 *
 * <br><font style="color:red">***仅供服务器使用，客户端不应调用***</font>
 * @param szJsonString - 对象的JSON格式；
 * @throws JSONException	- 参数为不符合JSON格式的的字符串，抛出异常
 * @throws OrganizedException - 参数为不符合对象格式的JSON字符串，抛出异常；
 */
-(instancetype)initWithJsonString:(NSString *)josnStr{
  
    return  [super initWithJson:josnStr];
}

//========================静态函数=============================

/**
 * SetFunctionConfigurationOperation - 修改功能配置；
 * <ul>
 * <li style="color:blue">权限说明： 仅由已登录的该功能的管理员发起</li>
 * <li style="color:blue">其他说明：
 * <ul>
 * <li>每个功能，分为配置数据，和功能数据;</li>
 * <li>配置数据也是一个FunctionConfiguration的interface,支持一系列方法，但不同的功能，配置数据的class类型不同，此处不影响参数传递；</li>
 * <li>功能数据则是FunctionData的interface,支持interface指定的方法，不同的功能下的功能呢数据的Class类型也不同，同样不影响参数传递；</li>
 * </ul>
 * </li>
 * </ul>
 *
 * @param szOperatorAccount	- 发起该操作的已登录的用户的账号，<b style="color:red">***仅账号***</b>
 * @param functionConfiguration - 用户设置的功能配置对象（统一的FunctionConfiguration interface);
 * @return 功能操作对象；
 * @throws OrganizedException - 参数有误，如，账号不符合规范，配置数据无效时抛出异常；
 */

+(FunctionOperation *)getInstanceOfSetFunctionConfigurationOperation:(NSString *) szOperatorAccount functionClass:(id)functionConfiguration{
    FunctionOperation *operation = [[FunctionOperation alloc]initWithUsrAccount:szOperatorAccount operation:SET_CONFIG class:functionConfiguration];
    
    [operation __addArgumentObject:functionConfiguration];
    return operation;
}

/**
 * 获取FunctionConfigurationData的String格式；
 *
 * @param functionClass
 * @return
 */

//public FunctionConfiguration getFunctionConfiguration(FUNCTIONID id) {
//    return getFunctionConfiguration(CompanyFunction.getFunctionConfigurationClass(id));
//}
//

+(NSString *)getFunctionOperationString:(FUNCTION_OPERATION)operation{


    switch (operation) {
        case SET_CONFIG:
           return  @"SET_CONFIG";
            break;
        case GET_CONFIG:
           return @"GET_CONFIG";
            break;
        case SET_FUNCDATA:
            return @"SET_FUNCDATA";
            break;
        case GET_FUNCDATA:
            return @"GET_FUNCDATA";
            break;
        case QUERY_USERLIST:
            return @"QUERY_USERLIST";
            break;
        case QUERY_USER_FUNCDATA:
            return @"QUERY_USER_FUNCDATA";
            break;
        case CHANGE_USER_FUNCDATA:
            return @"CHANGE_USER_FUNCDATA";
            break;
        case DISABLE_USER_FUNCTION:
            return @"DISABLE_USER_FUNCTION";
            break;
        case ENABLE_USER_FUNCTION:
            return @"ENABLE_USER_FUNCTION";
            break;
        case ASSIGN_USER_FUNCADMIN:
            return @"ASSIGN_USER_FUNCADMIN";
            break;
        case RESIGN_SELF_FUNCADMIN:
            return @"RESIGN_SELF_FUNCADMIN";
            break;
            
        default:
            break;
    }


}

+(FunctionID)getfunctionIDFrom:(id)className{
    NSString *str = NSStringFromClass([className class]);
    NSString *classUpperStr = [str uppercaseString];
    if ([classUpperStr isEqualToString:@"FUNCTIONUSERSWIPE"] ||[classUpperStr isEqualToString:@"USERSWIPE"]) {
        return FUNC_WORK_ATTENDENCE;
    }else{
    
        return  10000;
    }
    

}

-(BOOL)isValid{
    if(![super isValid]) return false;
    
    NSString *functionStr =[NSString stringWithFormat:@"%d",[self getFunctionID]];
    
    return (functionStr == nil)? false:true;
}

@end
