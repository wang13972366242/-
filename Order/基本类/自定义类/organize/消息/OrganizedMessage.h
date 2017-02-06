//
//  OrganizedMessage.h
//  PersonClass
//
//  Created by wang on 16/7/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeException.h"
#import "CommonFunctions.h"
#import "UserCompanyBase.h"
#import "COMPANY_STAT_ID.h"
#import "OrganizedCompany.h"
#import "SecurityUtil.h"
#import "UserBean.h"
#import "OrganizedMember.h"

#import "ArgumentObject.h"
#import "OrganizedParams.h"
#import "AdminManagementOperation.h"
#import "AdminManagementOperationResult.h"

/**
 * MESSAGE_TYPE: 消息类型
 * <br><pre style="color:blue">
 * 公司类消息	COMPANY
 * 用户类消息	USER
 * </pre>
 * @author Sophie_WS
 *
 */
typedef enum MESSAGE_TYPE {
    COMPANY,
    USER,
}MESSAGE_TYPE;


/**
 * MESSAGE_SENDER: 消息发送源
 * <br><pre style="color:blue">
 * 来自客户端消息	CLIENT
 * 来自服务器消息	SERVER
 * </pre>
 * @author Sophie_WS
 *
 */
typedef enum MESSAGE_SENDER{
    CLIENT,
    SERVER,
}MESSAGE_SENDER;

/**公司类消息
 * <br><pre style="color:blue">
 *创建请求 			CreateRequest,
 *创建回应			CreateResponse,
 *生成激活码请求		GenerateActivationCodeRequest,
 *生成激活码回应		GenerateActivationCodeResponse,
 *功能套餐更改请求		PlanChangeRequest,
 *功能套餐更改回应		PlanChangeResponse,
 *激活请求			ActivationRequest,
 *激活回应			ActivationResponse,
 *更改属性信息请求		SetInfoRequest,
 *更改属性信息回应		SetInfoResponse,
 *获取属性信息请求		GetInfoRequest,
 *获取属性信息回应		GetInfoResponse,
 *查询公司ID请求		QueryIDRequest,
 *查询公司ID回应		QueryIDResponse,
 *检验激活码请求		CheckActivationCodeRequest,
 *检验激活码回应		CheckActivationCodeResponse,
 *管理员修改公司信息提权请求		GetSuperCodeRequest
 *管理员修改公司信息提权回应		GetSuperCodeResponse
 *一般未知错误请求		GeneralErrorRequest,
 *一般未知错误回应		GeneralErrorResponse;
 * </pre>
 * @author Sophie_WS
 *
 */
typedef enum COMPANY_MESSAGE{
    CreateRequest = 1,
    CreateResponse,
    GenerateActivationCodeRequest,
    GenerateActivationCodeResponse,
    PlanChangeRequest,
    PlanChangeResponse,
    ActivationRequest,
    ActivationResponse,
    SetInfoRequest,
    SetInfoResponse,
    GetInfoRequest,
    GetInfoResponse,
    QueryIDRequest,
    QueryIDResponse,
    CheckActivationCodeRequest,
    CheckActivationCodeResponse,
    GetSuperCodeRequest,
    GetSuperCodeResponse,
    GeneralErrorRequest,
    GeneralErrorResponse,
}COMPANY_MESSAGE;


/**
 * 用户类消息
 *<br><pre style="color:blue">
 *激活请求			ActivationRequest,
 *激活回应			ActivationResponse,
 *管理请求-仅供管理员 		ManagementRequest,
 *管理请求回应			ManagementResponse,
 *更改属性信息请求		SetInfoRequest,
 *更改属性信息回应		SetInfoResponse,
 *获取属性信息请求		GetInfoRequest,
 *获取属性信息回应		GetInfoResponse,
 *查询用户列表请求		GetUserListRequest,
 *查询用户列表回应		GetUserListResponse,
 *登录请求			LoginRequest,
 *登录回应			LoginResponse,
 *登出请求			LogoutRequest,
 *登出回应			LogoutResponse,
 *退出公司请求		QuitCompanyRequest,
 *退出公司回应		QuitCompanyResponse,
 *检验激活码请求		CheckActivationCodeRequest,
 *检验激活码回应		CheckActivationCodeResponse,
 *用户提权请求		GetSuperCodeRequest
 *用户提权回应		GetSuperCodeResponse
 *一般未知错误请求		GeneralErrorRequest,
 *一般未知错误回应		GeneralErrorResponse;
 *</pre>
 * @author Sophie_WS
 */

typedef  enum USER_MESSAGE{
    activationRequest = 101,
    activationResponse,
    adminManagementRequest,
    AdminManagementResponse,
    setInfoRequest,
    setInfoResponse,
    getInfoRequest,
    getInfoResponse,
    getUserListRequest,
    getUserListResponse,
    LoginRequest,
    LoginResponse,
    LogoutRequest,
    LogoutResponse,
    QuitCompanyRequest,
    QuitCompanyResponse,
    checkActivationCodeRequest,
    checkActivationCodeResponse,
    getSuperCodeRequest,
    getSuperCodeResponse,
    FunctionRequest,
    FunctionResponse,
}USER_MESSAGE;



@interface OrganizedMessage : NSObject
/** 字典*/
@property(nonatomic,strong) NSMutableDictionary *m_argmentsmap;
/** 信息类型*/
@property(nonatomic,assign) MESSAGE_TYPE m_msgMaintype;
/** 公司ID*/
@property(nonatomic,assign)  int m_iMsgID;


/** 公司消息*/
-(instancetype)initCompanyWith:(COMPANY_MESSAGE)msgcpy;
/**用户消息*/
-(instancetype)initUserWith:(USER_MESSAGE)msgcpy;
/**构造有序应用消息基类对象
 */

-(OrganizedMessage*)initWithStringToMessage:(NSString *)szEncryptedString;

/**
 * 添加用户基本信息
 */
-(void)addUserBean:(UserBean *)userbeaninfo;
/**
 * 添加公司基本信息对象
 */

-(void)addCompanyBaseInfo:(UserCompanyBase *)baseobj;

/**
 * 添加单个公司的属性
 */
-(void)addCompanyInfoStatSign:(COMPANy_STAT_ID)ID statuValue:(NSString *)szStatuValue;
/**
 * 添加多个公司的属性
 */
-(void)addCompanyInfoStat:(NSDictionary *)hashValue;
/**
 * 指定登录方式：
 */

-(void)addLoginVarCodeFlag:(BOOL)bUserInterface;
-(NSString *)toString;
-(NSString *)testString;
/**
* 添加公司客户端对象
*/

-(void)addClientCompany:(OrganizedCompany *)clientCompany;
/**
 * 添加用户客户端对象
 */
-(void)addClientUser:(OrganizedMember *)clientmember;
-(AdminManagementOperationResult *) getAdminManagementOperationResultObject;
/**
 * 添加用户基本信息
 */
-(void)addUserBean:(UserBean *)userbeaninfo;
/**
 * 判断用户是否在查询有效的联系方式；
 */
+(BOOL)isCompanyQueryWithoutLoginValidCOMPANY_STAT_ID:(NSArray *) arrStatList;
/**
 * 仅供查询消息时使用，把查询时使用的Key加入到消息中。
 */

-(void)addInfoQueryKey:(NSString *)szQueryKey;

/**
 * 在查询公司信息时，需指定是否登录状态下查询；(仅在此情况下使用)
 *
 * @param bIsLogin - 查询时用户为登录状态-true,否则设置false;
 */
-(void)addUserLoginFlag:(BOOL)bIsLogin;
/**
 * 查询，获取公司属性时使用。
 */

-(void)addCompanyStatKeyListCOMPANY_STAT_ID:(NSArray *)arrStatIDs;
+(NSDictionary *)IsBeingUsedcheckType:(CheckType)checkType pamar:(NSString *)pamar uniqueID:(NSString*)uniqueID;


/**
 * 读取公司基本信息对象;
 */
-(UserCompanyBase*)getCompanyBaseObject;
/**
 * 读用户完整客户端信息对象;;
 */
-(OrganizedMember *)getClientUserObject;
/**
 * 读取公司完整客户端信息对象;;
 */

-(OrganizedCompany*)getClientCompanyObject;
/**
 * 读取用户基本信息对象;
 */
-(UserBean*)getUserBeanObject;
-(NSString *)getErrorCode;

/**
 * 读取单个公司属性value;
 */
-(NSString *)getCompanyInfoStatString:(COMPANy_STAT_ID)ID;

/**
 * 读取发送而来的激活码对;
 */
-(NSArray*) getActivatonCodePair;

/**
* 添加多个用户的属性
*/
-(void)addUserInfoStat:(NSDictionary *)hashValue;
/**
 *
 * 判断用户是否能设置某些属性
 */

+(void)validateUserStatList:(NSArray *)valuepairs isSet:(BOOL)bSet;

/**
 * 添加单个用户的属性
 */
-(void)addUserInfoStat:(USE_STAT_ID )ID  szStatuValue:(NSString *) szStatuValue;

/**
 * 判断用户是否在查询有效的联系方式；
 */

+(BOOL)isUserRequestingValidContactDetails:(NSArray *)arrStatList;

/**
 * 查询，获取用户属性时使用。
 */

-(void)addUserStatKeyList:(NSArray *)arrStatIDs;


/**
 * 读取员工属性key-value的hashmap;
 */
-(NSDictionary *)getUserInfoStat;


/**
 * 仅供修改密码时使用
 * <br>只有在使用旧密码认证来修改密码的情况下才使用；
 * @param szPassword - 旧密码-进行密码认证；
 * @throws OrganizedException - 无效的格式不正确的旧密码情况下，抛出异常；
 */


-(void)addUserOldPassword:(NSString *)szPassword;

/**
 * 根据传递的第二个参数，检查传入的第一个参数，
 */

+(void)validateCompanyStatList:(NSArray *)valuepairs bset:(BOOL) bSet;
/**
 * 读取公司属性key-value的hashmap;
 */
-(NSMutableDictionary *)getCompanyInfoStat;

/**
 * 添加管理操作对象
 */

-(void)addAdminManagementOperation:(AdminManagementOperation *) operation;

-(UserCompanyBase*)getCompanyBaseVercityObject;


-(AdminManagementOperation *) getAdminManagementOperationObject;
@end

