//
//  UserOperation.h
//  Admint
//
//  Created by wang on 2016/11/17.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseOperation.h"

@interface UserOperation : BaseOperation
/** m_eOperation*/
@property(nonatomic,strong) NSString *m_eOperation;

//-(instancetype)initWithJsonString:(NSString *)szJsonString;
-(instancetype )initWithcreatUserOperationWithOperation:(NSString *)operation account:(NSString *)szUserAccount dic:(NSDictionary *)argList;
-(instancetype)initWithJson:(NSString *)szJsonString;
-(instancetype)initWithOperation:(NSString *)operation account:(NSString *)szUserAccount;

-(BOOL)isValid;




/**
 * 对于多用户修改参数来说，需要把用户需修改的参数列表转换为JSONArray格式，
 */


+(NSDictionary *)userStatsKeyValueMapFromJSON:(NSDictionary *) object arrPermitList:(NSArray *) arrPermitList;

/**
 * 添加公司员工的对象的String的形式；
 */
-(void)__addOrganizedMember:(NSString *) szMemberInfo;


/**
 * 字符串转化为useroperation的动态数组，其中的对象并非都是useroperation; 而是通过反射动态new的对象；
 *
 */
+(NSArray *) __stringToArrayOfAdminOptUserOperationResult:(NSString *)szJsonArrayString  objclass:(id)objclass;

/**
 * 校验参数，并转化为String格式；
 * @param operations 用户操作集合
 * @return 转化为的字符串形式；
 */
+(NSString *) __arrayToStringOfUserChangeOperation:(NSArray *) operations;

-(OrganizedMember *) __getOrganizedMember;

/**
 * 设置操作所涉及的功能ID
 
 */
-(void )setFunctionID:(FunctionID) ID;

/**
 * 返回操作所涉及的功能ID
 */
-(FunctionID)	getFunctionID;

@end
