//
//  FunctionOperation.h
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperation.h"

@interface FunctionOperation : UserOperation
typedef enum {
    SET_CONFIG,
    GET_CONFIG,
    SET_FUNCDATA,
    GET_FUNCDATA,
    QUERY_USERLIST,
    QUERY_USER_FUNCDATA,
    CHANGE_USER_FUNCDATA,
    DISABLE_USER_FUNCTION,
    ENABLE_USER_FUNCTION,
    ASSIGN_USER_FUNCADMIN,
    RESIGN_SELF_FUNCADMIN,
}FUNCTION_OPERATION;



/**
 * 构造函数
 */

-(instancetype)initWithUsrAccount:(NSString *)szUserAccount operation:(FUNCTION_OPERATION)operation class:(id)functionClass;

-(instancetype)initWithUserAccount:(NSString *)account operation:(FUNCTION_OPERATION)operation functionID:(FunctionID)functionID;


/**
 *  构造函数 - 从JSON格式恢复成类对象；
 */
-(instancetype)initWithJsonString:(NSString *)josnStr;
/**
 * 根据操作类型，确定是否需要管理员权限；
 */
-(BOOL)getAdminPrivilegeFlag:(FUNCTION_OPERATION)functionOperation;


-(BOOL)isValid;
@end
