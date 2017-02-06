//
//  OrganizedParams.h
//  organizeClass
//
//  Created by wang on 16/9/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef enum {
    COMPANY_EMAIL= 1,
    COMPANY_MOBILE,
    USER_EMAIL,
    USER_MOBILE,
    ACCOUNT_NAME,
    EMPLOYEE_NUMBER,
}CheckType;

/**
 * //登录注册时，客户端填写的验证码 - request.setparam的key;
 */
static  NSString *KEY_VARCODE = @"VarCode";
/**
 * 忘记密码的情况下，通过手机验证，服务器返回的临时提权验证码，需在修改密码请求中放置此参数 - request.setparam的key;
 */
static  NSString *KEY_SUPERVARCODE	= @"SuperVarCode";
/**
 * 激活时，激活码校验和激活提交之间衔接的校验码，服务器发送。
 * - request.setparam的key;
 * - response.setheader的key
 */
static  NSString *KEY_ACTVARCODE = @"ACTVarCode";
/**
 * //邮箱校验码KEY
 */
static  NSString *KEY_EMAILVARCODE = @"EmailVarCode";
/**
 * //邮箱校验时的账号key
 */
static  NSString *KEY_EMAILACCOUNT = @"EmailAccount";
/**
 * //手机校验时的手机号的key
 */
static  NSString *KEY_MOBILENUMBER = @"MobileNumber";
/**
 * //手机校验码KEY
 */
static  NSString *KEY_MOBILEVARCODE = @"MobileVarCode";
/**
 * 消息的发送源：key == 对应的value可以为 web, android, ios;
 */
static  NSString *KEY_REQUESTFROM = @"SOURCE";

/**
 * 有序request请求消息放在param里面的key值
 */
static  NSString *KEY_REQUEST = @"ORGMSGRES";
/**
 * 有序response回应消息放在attribute里面的key值 -- ONLY FOR WEB
 */
static  NSString *KEY_RESPONSE = @"ORGMSGRSP";
/**
 * 时间戳的key - 客户端发送给服务器
 */
static  NSString *KEY_TIMESTAMP = @"TIMESTAMP";
/**
 * 用于本地或者request消息中存储携带SESSIONID对象的 Key
 * <br>例子:
 * <br>
 * request.addHeader("Cookie",KEY_SESSIONID+"=mysessionid");
 *
 */
static  NSString  *KEY_SESSIONID	= @"JSESSIONID";
/**
 * 用于本地或者request消息中存储携带OrganizedCompanyBase对象的 Key
 *
 */
static  NSString  *KEY_COMPANYBASE	= @"CompanyBase";
/**
 * 用于本地或者request消息中存储携带CompanyUniqueID的 Key
 * <br>例子:
 * <br>request.setParam(OrganizedParam.KEY_COMPANYID,"公司的uniqueID字符串");
 *
 */
static  NSString  *KEY_COMPANYID	= @"UniqueID";
/**
 * 用于本地或者request消息中存储携带OrganizedCompany对象的 Key
 *
 */
static  NSString  *KEY_COMPANYCLIENT = @"CompanyClient";
/**
 * 用于本地或者request消息中存储携带OrganizedMember对象的 Key
 *
 */
static  NSString  *KEY_MEMBER		= 	@"OrganizedMember";
/**
 * 用于本地或者request消息中存储携带UserBean对象的 Key
 *
 */
static  NSString  *KEY_USERBEAN		= 	@"UserBean";

/**
 * 默认发送邮件验证码和手机验证码是在注册时，目标邮件手机号不存在时才发送，若是提权请求发送前，用户需验证自身权限，则必须在Requset中携带此参数，设置为“1";
 * 此时，仅发送给数据库中存在的地址。
 */
static  NSString  *KEY_CHECKIDENTITY	=   @"OnlyWhenExist";

/**
 * 客户端发送消息前，要把服务器指定的cookie(也就是从Set-Cookie中读出的所有参数）添加到HEADER "Cookie"这个键中。
 * <br>Cookie的常量KEY
 *
 */

static  NSString  *KEY_CLIENTCOOKIE			=   @"Cookie";

/**
 * 从服务器返回的response中读取服务器让存储的参数 - 本应用暂时只放置SESSION-ID在这个HEADER KEY中；
 * <br>Set-Cookie的常量KEY
 */
static  NSString  *KEY_SERVERSETCOOKIE		=   @"Set-Cookie";



@interface OrganizedParams : NSObject
/**
 *  获得检查的key
 */
+(NSString *)paramsGetCheckParamKey;
+(NSString *)getStringFormEnum:(CheckType)ID;

/**
 *  获得检查的枚举对应的字符串
 */
+(NSString *)getCheckTypeValueKey:(CheckType)type;

+(NSString*)getCompanyIDKeyforCheckTypeRequest;



+(NSArray *)toStringKeySet:(NSArray *) argKeyList;
+(NSDictionary *)toStringKeyHash:(NSDictionary *) argKeyList;

/**
 * 所有公司属性中，为unique的条目；
 */

+(NSArray *)getCompanyDBUniqueItemList;
/**
 * 把字符串（数据库中的列名）转化
 */
+(NSString *)convertStringToCompanyDBColumns:(NSString *) szCompanyStatStr;

/**
 * 把字符串转回MemberDBColumns interface
 */

+(NSString *)convertStringToMemberDBColumns:(NSString *) szMemberStatStr;


+(NSArray *)allUserClientStat;
+(NSArray *)allUserServerStat;

+(NSArray *)allCompanyBase;

+(NSArray *) getAdminQueryResultStats;
@end
