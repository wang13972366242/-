//
//  OrganizedClientMessage.h
//  organizeClass
//
//  Created by wang on 16/9/23.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedMessage.h"
#import "CompanyFunction.h"
#import "PurchaseIASD.h"

/**
 * @version 0.36
 * <pre style="color:red">
 * ReleaseNotes:
 * 1. 重要说明： 所有消息放入HTTPREQUEST之后，还需在同一个request中增加一个参数：
 *   <i style="color:blue"> request.setAttribute("SOURCE", "web");</i>
 * 2. 在服务器返回session-id的情况下，客户端要比对保存该session-id,并在后续的所有的请求的HEADER上增加session-id；
 * 3. 根据服务器客户端消息交互说明文档，在必要的信息交互时，添加参数 VarCode 或者 ACTVarCode;
 *  <i style="color:blue">  "VarCode";	//登录注册时，客户端填写的验证码
 *    "ACTVarCode"; //激活时，激活码校验和激活提交之间衔接的校验码，服务器发送。
 * </i>
 * </pre>
 * @author Sophie_WS
 *
 */
@interface OrganizedClientMessage : OrganizedMessage


/**
 * UserLoginRequest - 用户登录请求
 */
+(OrganizedClientMessage*)clientMessageGetInstanceOfUserLoginRequest:(UserBean *)user hasVarCode:(BOOL) hasVarCode;
/**
 <br><i style="color:green">新公司购买激活码情形下发送</i>
 */

+(OrganizedClientMessage*)getInstanceOfCompanyCreateRequestCompanyBase:(UserCompanyBase*)objUserBase functionlists:(NSArray*)functionlist iMaxMember:(int)iMaxMember;

/**CompanyGenerateActivationCodeRequest  - 公司生成激活码请求
 * <br><i style="color:green">新公司购买激活码-支付完成之后（成功或者失败均需反馈给服务器）的情形下发送</i>
 */
+(OrganizedClientMessage*)getInstanceOfCompanyGenerateActivationCodeRequest:(NSString *)szCompanyUniqueID  purchaseinfo:(PurchaseIASD*) purchaseinfo;

/**
 * CheckActivationCodeRequest - 检测激活码的请求
 * <br><i style="color:green">激活公司的第一步操作，发送使用的激活码和类型</i>
 */

+(OrganizedClientMessage *)getInstanceOfCompanyCheckActivationCodeRequest:(NSString*)szClientActivationCode;
/**
 * CompanyActivationRequest - 激活公司请求
 * <br><i style="color:green">激活公司的第二步操作，发送公司的完整信息(包括管理员信
 */
+(OrganizedClientMessage*)getInstanceOfCompanyActivationRequest:(NSString *)szCompanyUniqueID  usercompany:(OrganizedCompany*)usercompany userAdmin:(UserBean*)userAdmin  adminUser:(OrganizedMember*)adminUser;

/**
 * CheckActivationCodeRequest - 检测用户激活码的请求
 */


+(OrganizedClientMessage *) 	getInstanceOfUserCheckActivationCodeRequest:(NSString *)szClientActivationCode;
/**
 * CompanyGetInfoRequest - 查询公司信息请求
 * <br><i style="color:green">两种使用情况：
 */

+(OrganizedClientMessage*)getInstanceOfCompanyGetInfoRequest:(NSString*)szArbitraryKey bIsUserLogin:(BOOL)bIsUserLogin COMPANy_STAT_ID:(NSArray*)ids;

+(OrganizedClientMessage *)	getInstanceOfUserActivationRequest:(NSString *) szCompanyUniqueID userBean:(UserBean *)userNormal  member:(OrganizedMember *)userInfo ;

/**
 * 用户登出请求
 */
+(OrganizedClientMessage *)getInstanceOfUserLogOutRequest:(UserBean *)user;

/**
 * 用户退出公司请求 - 必须是登录用户和非管理员才可发起请求；
 */

+(OrganizedClientMessage *)getInstanceOfUserQuitCompanyRequest:(NSString *) szUserAccount;

/**
 * 用户信息更改请求 <br>-多个需要修改的信息
 */

+(OrganizedClientMessage *)getInstanceOfUserSetInfoRequest:(NSString *) szUserAccount mpKeyValuePairs:(NSDictionary *)mpKeyValuePairs;


/**
 * 用户信息更改请求 <br>-单个需要修改的信息
 */

+ (OrganizedClientMessage *)getInstanceOfUserSetInfoRequestSign:(NSString *)szUserAccount tyepe:(USE_STAT_ID )userStatid  szStatValue:(NSString *)szStatValue;


/**
 * 用户提权请求
 */


+ (OrganizedClientMessage *)	getInstanceOfUserGetSuperCodeRequest:(NSString *) szUserAccount useEnum:(USE_STAT_ID)EmailOrMobielType emialOrMboileNumber:(NSString *)szStatIDValue;


/**
 * 用户查询信息请求

 * @throws OrganizedException - 参数错误；
 */

+ (OrganizedClientMessage *) getInstanceOfUserGetInfoRequest:(NSString *) szInfoQueryKey userEnumArr:(NSArray *) arrStatList;


/**
 * 仅适用于 - 登录用户 使用旧密码进行身份验证，然后修改当前密码的情况；
 */
//
+(OrganizedClientMessage *)getInstanceOfUserSetInfoRequestOldPassWord:(NSString *)szUserAccount oldPassword:(NSString*)szOldPassword  szNewPassword:(NSString *) szNewPassword;


/**
 * 公司信息更改请求 <br>-多个需要修改的信息
 */

+(OrganizedClientMessage *)	getInstanceOfCompanySetInfoRequest:(NSString *) szUserAccount values:(NSDictionary *)valuepairs;


/**
 *
 * 供登录管理员用户 - 修改公司高安全敏感度的信息或其他单个属性信息使用
 */

+(OrganizedClientMessage *)	getInstanceOfCompanySetInfoRequest:(NSString *) szUserAccount companyEnum:(COMPANy_STAT_ID) idCompanyStat szCompanyStatValue:(NSString *)szCompanyStatValue;


/**
 * 管理员管理操作请求 - 必须是登录用户和管理员才可以发起请求
 */
+(OrganizedClientMessage *) getInstanceOfAdminManagementOperationRequest:(AdminManagementOperation *) adminoperation;
@end
