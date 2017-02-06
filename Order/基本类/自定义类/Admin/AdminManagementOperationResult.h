//
//  AdminManagementOperationResult.h
//  Admint
//
//  Created by wang on 2016/11/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "AdminManagementOperation.h"
@interface AdminManagementOperationResult : BaseArgumentList
/** MANAGEMENT_OPERATION*/
@property(nonatomic,assign) MANAGEMENT_OPERATION m_enumManagement;



/**
 * 构造函数 - 从JSON格式恢复成类对象；
 */
-(instancetype)initWithJsonString:(NSString *)szJsonString;

-(NSString *)toString;


/**
 * 获取管理员修改单个用户的某个或者某些属性时的操作 结果参数：
 */
-(NSArray *)getAdminUserOperationResultArray;


/**
 * 添加管理员需要执行完毕的操作结果的数组；
 */

-(void)addAdminUserOperationResultArray:(NSArray *) adminOperationResults;


/**
 * 获取管理员查询用户列表回应中的： 多个用户的账号和查询属性结果；
 */
-(NSDictionary *) getQueryMemberListResult;

@end



