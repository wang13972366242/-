//
//  OrganizedClientMessage.m
//  organizeClass
//
//  Created by wang on 16/9/23.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedClientMessage.h"

#import "CodeException.h"
@implementation OrganizedClientMessage

/**CompanyCreateRequest 公司创建请求
 * <br><i style="color:green">新公司购买激活码情形下发送</i>
 * <br><i style="color:orange">目的：购买激活码，支付前询问服务器是否可以创建公司以及公司订购的套餐是否OK；
 * 成功的情况下，服务器创建公司条目并返回公司的唯一码（UniqueID);失败时，服务器返回错误代码</i>
 * <br><i style="color:red">-VarCode: 注册时有校验码（从注册界面读入并存储在本地)，在发送消息时，要将校验码从cookie中读出，并设置request.setParameter(OrganizedParam.KEY_VARCODE,varcodestring)
 * <br>-COOKIE: JSESSIONID - 注册界面获取激活码时，要从服务器返回的数据报文中(Response的HEADER中,key is "JSESSIONID")读入SESSIONID，放在request header中。</i>
 * @param objUserBase - 公司基本信息 {@linkplain OrganizedCompanyBase}
 * @param functionlist - 公司预定功能列表数组{@linkplain CompanyFunction}
 * @param iMaxMember - 公司总人数
 * @return OrganizedClientMessage 组装好的客户端请求消息
 * @throws OrganizedException
 * <br> MESSAGE_CREATE_WRONGPARAM - 参数无法通过校验
 *
 */

+(OrganizedClientMessage*)getInstanceOfCompanyCreateRequestCompanyBase:(UserCompanyBase*)objUserBase functionlists:(NSArray*)functionlist iMaxMember:(int)iMaxMember{
    if(![CompanyFunction isFunctionListValid:functionlist bCheckExpired:true] || iMaxMember < 2){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"CompanyCreateRequest" userInfo:nil];
        [ce raise];
    }
    
    OrganizedClientMessage *message;
    message = [[OrganizedClientMessage alloc]initCompanyWith:CreateRequest];
    [message addCompanyBaseInfo:objUserBase];
    NSString *funStr =[ CompanyFunction functionArrayToString:functionlist];
    [message addCompanyInfoStatSign:Functionlist statuValue:funStr];
    NSString *str = [NSString stringWithFormat:@"%d",iMaxMember];
    [message addCompanyInfoStatSign:MaxMember statuValue:str];
    return message;
}


/**CompanyGenerateActivationCodeRequest  - 公司生成激活码请求
 * <br><i style="color:green">新公司购买激活码-支付完成之后（成功或者失败均需反馈给服务器）的情形下发送</i>
 * <br><i style="color:orange">目的：告知服务器支付结果，支付成功情形下，等待服务器返回一对激活码；支付失败情况下，服务器回应中，无信息提取</i>
 * @param szCompanyUniqueID - 公司唯一ID
 * @param purchaseinfo - 支付信息{@linkplain PurchaseInfo}<br>
 * (当支付失败时，该参数应该设置为null)
 * @return OrganizedClientMessage 组装好的客户端请求消息
 * @throws OrganizedException
 * <br> MESSAGE_CREATE_WRONGPARAM  - 参数无法通过校验
 */
+(OrganizedClientMessage*)getInstanceOfCompanyGenerateActivationCodeRequest:(NSString *)szCompanyUniqueID  purchaseinfo:(PurchaseIASD*) purchaseinfo{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initCompanyWith:GenerateActivationCodeRequest];
    [message addCompanyInfoStatSign:uniqueID statuValue:szCompanyUniqueID];
    
    NSString *szPaymentInfo = purchaseinfo == nil ? nil : [purchaseinfo toString];
    if(purchaseinfo != nil && ![purchaseinfo isValid]){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"CompanyGenerateActivationCodeRequest-PurchaseInfo" userInfo:nil];
        [ce raise];
    }else if(purchaseinfo != nil){
        [message addCompanyInfoStatSign:CurrentPurchaseinfo statuValue:szPaymentInfo];
    }
    return message;
}

/**
 * CheckActivationCodeRequest - 检测激活码的请求
 * <br><i style="color:green">激活公司的第一步操作，发送使用的激活码和类型</i>
 * <br><i style="color:orange">目的：向服务器提出激活请求，校验用户的激活码是否有效可激活；
 * 若有效，等待服务器返回激活码携带的公司基本信息；无效则服务器返回错误代码</i>
 * <br><i style="color:red">COOKIE: 此消息对应的response中，要获取ACT验证码存入cookie以供用户补全消息之后第二步激活公司之用；
 * <br> 参数处于Response的HEADER中，key为 OrganizedParams.KEY_ACTVARCODE
 * </i>
 * @param szClientActivationCode - 单个激活码（公司激活码，即管理员激活码）
 * @return OrganizedClientMessage 组装好的客户端请求消息
 * @throws OrganizedException
 * <br> MESSAGE_CREATE_WRONGPARAM  - 参数无法通过校验
 * <br> ARGUMENT_EMPTY_ERROR  - 参数为空
 */



+(OrganizedClientMessage *)getInstanceOfCompanyCheckActivationCodeRequest:(NSString*)szClientActivationCode{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initCompanyWith:CheckActivationCodeRequest];
    [message addCompanyInfoStatSign:Activationcode statuValue:szClientActivationCode];
    //message.AddActivationCodeType(bCompany); version 0.36 - 已经是公司激活的请求了，不需要再规定类型了。
    return message;
}


/**
 * CompanyActivationRequest - 激活公司请求
 * <br><i style="color:green">激活公司的第二步操作，发送公司的完整信息(包括管理员信息)</i>
 * <br><i style="color:orange">目的：向服务器提出激活请求，补全公司的完整信息；
 * 若有效，服务器返回一个空的回应消息（取不到ERRORCODE)；无效则服务器返回错误代码</i>
 * <br><i style="color:red">额外参数: <br>
 * request中还要附带在激活第一步-验证激活码时获取的服务器返回的ACTVarCode,放在request中。
 * <br> request.setParameter(OrganizedParams.KEY_ACTVARCODE,ACTvarcodestring)
 * </i>
 * @param szCompanyUniqueID - 公司的唯一ID号，激活公司第一步中获取的ID号；
 * @param usercompany - 用户补全的完整的公司信息 (基本信息和职位框架需要定义）
 * @param userAdmin	- 公司制定的管理员的账号密码和注册设备信息
 * @param adminUser - 管理员的其他个人信息；
 * @return OrganizedClientMessage - 根据参数组装好的消息
 * @throws OrganizedException	- 无效或空的参数
 */
+(OrganizedClientMessage*)getInstanceOfCompanyActivationRequest:(NSString *)szCompanyUniqueID  usercompany:(OrganizedCompany*)usercompany userAdmin:(UserBean*)userAdmin  adminUser:(OrganizedMember*)adminUser{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initCompanyWith:ActivationRequest];
    [message addCompanyInfoStatSign:uniqueID statuValue:szCompanyUniqueID];
    [message addClientCompany:usercompany];
    [message addClientUser:adminUser];
    [message addUserBean:userAdmin];
    return message;
}


/**
 * CompanyGetInfoRequest - 查询公司信息请求
 * <br><i style="color:green">两种使用情况：
 * <br> 1. 登录情况下，管理员查询公司相关统计信息（非客户端公司对象的一部分）
 * <br> 2. 非登录情况下，通过输入注册公司名字，邮箱地址或手机号来获取可用验证方式
 * <br> 3. 非登录情况下，通过验证公司 之前绑定的通信方式，来获取查询激活码；（非登录情况下，仅支持2，3两种方式）
 * </i>
 * <br><i style="color:orange">目的：向服务器提出查询公司信息请求，获取公司的信息；
 * 若有效，服务器返回用户请求的数据（查询的属性若对应值为null,是不会包含在返回数据中的）；若所有查询属性对应值都为空，则返回错误代码，消息参数无效的情况下服务器也返回错误代码</i>
 * <br>
 * </i>
 * <font color="red"> 参数说明：</font><br>
 * <ul style="color:red"><li>登录情形下: JSESSIONID</li>
 * <li>登录情形下: 某些需要验证码的情况下，携带验证码信息</li>
 * <li>未登录查询激活码情况下：验证码（根据用户选择 - EmailVarCode or MobileVarCode)</li>
 * </ul>
 * @param szArbitraryKey - （未登录的情况下）公司名，邮箱地址，或者手机号其中的一个；（登录情况下，使用登录账号，**仅限用户账号**)
 * @param bIsUserLogin - true:登录状态，管理员发起的查询； false-未登录账号发起的查询；
 * @param ids - 需请求的参数列表
 * <br><ul>
 * <li>非登录情况下，通过输入注册公司名字，邮箱地址或手机号来获取可用验证方式 - 固定{COMPANY_STAT_ID.Email,COMPANY_STAT_ID.Mobile,COMPANY_STAT_ID.Validcontact}</li>
 * <li>非登录情况下，通过验证公司 之前绑定的通信方式，来获取查询激活码 - 固定{COMPANY_STAT_ID.Activationcode}</li>
 * <li>登录情形下，一般客户端公司对象不具备的对象，但管理员可查看的信息都有效 - 如：激活码，支付信息等</li>
 * </ul>
 * @return - 根据参数组装好的消息
 * @throws OrganizedException - 无效的参数，或者组装失败，返回错误代码；
 */

+(OrganizedClientMessage*)getInstanceOfCompanyGetInfoRequest:(NSString*)szArbitraryKey bIsUserLogin:(BOOL)bIsUserLogin COMPANy_STAT_ID:(NSArray*)ids{
    if(![CommonFunctions functionsIsStringValid:szArbitraryKey]){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"CompanyGetInfoRequest Init Error: Invalid username or CompanyID" userInfo:nil];
        [ce raise];
    }
    
    //未登录情况下的参数判断
    if(bIsUserLogin == false){
        if( ![self isCompanyQueryWithoutLoginValidCOMPANY_STAT_ID:ids]){
            CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"CompanyGetInfoRequest Init Error: Invalid COMPANY_STAT_ID list" userInfo:nil];
            [ce raise];
        }
    }
    
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initCompanyWith:GetInfoRequest];
    
    [message addInfoQueryKey:szArbitraryKey];
    [message addUserLoginFlag:bIsUserLogin ];
    [message addCompanyStatKeyListCOMPANY_STAT_ID:ids];
    return message;
}





/**
 * CheckActivationCodeRequest - 检测用户激活码的请求
 * <br><i style="color:green">激活用户的第一步操作，发送使用的激活码和类型</i>
 * <br><i style="color:orange">目的：向服务器提出激活请求，校验用户的激活码是否有效可激活；
 * 若有效，等待服务器返回激活码携带的公司基本信息；无效则服务器返回错误代码</i>
 * <br><i style="color:red">COOKIE: 此消息对应的response中，要获取ACT验证码存入cookie以供用户补全消息之后第二步激活用户之用；
 * <br> 参数处于Response的HEADER中，key为 OrganizedParams.KEY_ACTVARCODE
 * </i>
 * @param szClientActivationCode - 用户激活码
 * @return {@linkplain OrganizedClientMessage}
 * @throws OrganizedException - 无效的用户激活码
 */


+(OrganizedClientMessage *) 	getInstanceOfUserCheckActivationCodeRequest:(NSString *)szClientActivationCode{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:checkActivationCodeRequest];
    
    //此处虽是用户激活码，但由于返回的信息还是公司基本信息，用于关联用户，因此仍然选择添加的属性为公司属性；
    [message addCompanyInfoStatSign:Activationcode statuValue:szClientActivationCode];

    //message.AddActivationCodeType(bCompany); version 0.36 - 已经是公司激活的请求了，不需要再规定类型了。
    return message;
}

/**
 * UserLoginRequest - 用户登录请求
 * <br><i style="color:green">前台登录 - 由用户输入账号密码以及校验码；</i>
 * <br><i style="color:green">后台登录 - 当用户选择“记住密码”“自动登录”功能之后，若登录状态过期，则客户端后台自动发送登录请求；</i>
 * <br><i style="color:orange">目的：获取用户信息，所在公司信息，以及据此判断用户所具备的功能权限</i>
 * <br><i style="color:red">COOKIE: 前台登录时有校验码（从注册界面读入并存储在cookie中)，在发送消息时，要将校验码从cookie中读出，并设置request.setAttribute("VarCode",varcodestring); </i>
 * <br><i style="color:red">COOKIE: SESSIONID -- 控制登录状态; </i>
 * @param user - 用户的登录账号信息
 * @param hasVarCode - 前台登录 - true; 后台登录 - false;
 * @return OrganizedClientMessage
 * @throws OrganizedException	- 参数有误
 */

+(OrganizedClientMessage*)clientMessageGetInstanceOfUserLoginRequest:(UserBean *)user hasVarCode:(BOOL) hasVarCode{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:LoginRequest];
    [message addUserBean:user];
    [message addLoginVarCodeFlag:hasVarCode];
    return message;
}



/**
 * UserActivationRequest
 * <br>- 激活用户请求  （加入公司请求）,也是用户注册
 * <br><i style="color:green">激活用户的第二步操作，发送用户的完整信息(账户信息和完整信息)</i>
 * <br><i style="color:orange">目的：向服务器提出激活请求（加入公司请求），补全用户的完整信息；
 * 若有效，服务器返回一个空的回应消息（取不到ERRORCODE)；无效则服务器返回错误代码</i>
 * <br><i style="color:red">额外参数: request中还要附带在激活第一步-验证激活码时获取的服务器返回的ACTVarCode,放在request中。
 * <br> request.setParameter(OrganizedParams.KEY_ACTVARCODE,ACTvarcodestring)
 * </i>
 * @param szCompanyUniqueID	- 员工所属公司的Company ID
 * @param userNormal	- 员工的基本账户信息 （登录相关）
 * @param userInfo		- 员工的补充信息
 * @return	OrganizedClientMessage
 * @throws OrganizedException 参数无效抛出异常
 */
+(OrganizedClientMessage *)	getInstanceOfUserActivationRequest:(NSString *) szCompanyUniqueID userBean:(UserBean *)userNormal  member:(OrganizedMember *)userInfo {
    //激活时需要有作为公司成员的基本信息，否则是一般用户；
    if(![userInfo isValidAsCompanyMember]){
        CodeException *ce = [[CodeException alloc]initWithName:@"USER_ACTIVATION_INFOMATIONNOTCOMPLETE" reason:@"个人信息不完整" userInfo:nil];
        [ce raise];
       
    }
    
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:activationRequest];
    [message addCompanyInfoStatSign:uniqueID statuValue:szCompanyUniqueID];
    [message addUserBean:userNormal];
    [message addClientUser:userInfo];
    return message;
}



/**
 * 用户退出公司请求 - 必须是登录用户和非管理员才可发起请求
 * @param szUserAccount - 登录用户的账号**仅账号**
 * @return 组装好的客户端消息
 * @throws OrganizedException 参数错误；
 */

+(OrganizedClientMessage *)getInstanceOfUserQuitCompanyRequest:(NSString *) szUserAccount{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:QuitCompanyRequest];
    [message  addUserInfoStat:@{[USER_STAT_ID getKeyNameForCompanyStatID:UniqueAccount]:szUserAccount}];
    
    return message;
}


/**
 * 用户查询信息请求
 * <br><i style="color:green">特殊情况下（比如忘记密码情况下，非登录状态，根据用户输入的账号或者手机号，邮箱地址，请求服务器返回用户之前等级的通过验证了的联系方式）;
 * <br>目前仅支持获取 - 当前通过验证了的联系方式
 * </i>
 * <br><i style="color:orange">目的：从服务器获取用户相关属性信息；</i>
 * <br>
 *
 * @param szInfoQueryKey - 用户输入的账号或者手机号，邮箱地址
 * @param arrStatList	- 目前应为(只能为，否则报错)：{USER_STAT_ID.Email,USER_STAT_ID.Mobile,USER_STAT_ID.ValidContact};
 * @return 组装好的客户端消息
 * @throws OrganizedException - 参数错误；
 */

+ (OrganizedClientMessage *) getInstanceOfUserGetInfoRequest:(NSString *) szInfoQueryKey userEnumArr:(NSArray *) arrStatList{
    if(![self isUserRequestingValidContactDetails:arrStatList]){
        
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"用户查询信息邮箱电话和验证" userInfo:nil];
        [ce raise];
        
    }
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:getInfoRequest];
    [message addInfoQueryKey:szInfoQueryKey];
    [message addUserStatKeyList:arrStatList];
    
    return message;
}

/**
 * 用户登出请求
 * <br><i style="color:green">用户主动登出的情况下；</i>
 * <br><i style="color:orange">目的：在暂不需要服务的情况下，登出账号</i>
 * <br><i style="color:red">COOKIE: SESSIONID -- 控制登录状态; </i>
 * @param user - 用户账户信息
 * @return -组装好的消息
 * @throws OrganizedException - 参数有误的情况下跳出异常
 */
+(OrganizedClientMessage *)getInstanceOfUserLogOutRequest:(UserBean *)user {
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:LogoutRequest];
    [message addUserBean:user];
    
    return message;
}

/**
 * 用户信息更改请求 <br>-单个需要修改的信息
 * <p>
 * <span  style="color:green">
 * <br>
 * <i>供登录用户本人修改自身高安全敏感度的信息或其他单个属性信息使用</i>
 * <br> - 用户账户名不允许修改！
 * <br> - 修改密码（忘记密码模式-使用手机或者邮件认证时），邮件地址，手机号 必须使用此函数，只包含一个参数；
 * <br> - 其它修改若只有一个参数变动，也可以使用这个函数；
 * <br> - 修改邮件地址，或者手机号时，在使用此函数之前，必须先验证之前登记过的有效的身份验证方式进行提权（提权请求），提权成功，从服务器返回的回应中获取提权码：SuperVarCode.
 * <br><i style="color:orange">目的：用户自身安全信息（属性）或单个属性信息发生变化时，更新数据；</i>
 * </span>
 * </p>
 * 参数说明：
 * <ul>
 * <li>COOKIE: SESSIONID -- Request中必须携带（仅限登录用户使用）;</li>
 * <li>Parameter: EmailVarCode or MobileVarCode -- 若修改的信息是手机号或者邮件地址，则强制需要验证新提供的号码，以及旧的认证方式之一;</li>
 * <li>Parameter: VarCode or EmailVarCode or MobileVarCode -- <br>若修改的信息是用户密码，客户端有两种方式：
 * <ul>
 * <li><span style="color:red">（本函数不适用）</span>修改密码：先输入旧密码，再输入两次新密码，吻合以及符合密码规则的情况下，发送修改请求至服务器。此时无需验证。</li>
 * <li>（本函数适用）忘记密码：需指定用户名，先绑定的手机获取验证码，和新密码一起发送</li>
 * </ul>
 * </li>
 * </ul>
 *
 *
 *
 * @param szUserAccount - 用户的Account信息（必须是账号，而非手机号或邮件地址）
 * @param userStatid - 需要修改的信息的属性
 * @param szStatValue - 需要修改的信息的属性对应的值
 * @return  -组装好的消息
 * @throws OrganizedException	参数不合法时抛出异常；
 */

+ (OrganizedClientMessage *)getInstanceOfUserSetInfoRequestSign:(NSString *)szUserAccount tyepe:(USE_STAT_ID )userStatid  szStatValue:(NSString *)szStatValue{
    //如果属性是密码，则做hash
    
    if(userStatid == Password){
        if(szStatValue.length>7){
            UserBean *useb = [[UserBean alloc]initWithPasswod:szStatValue];
            szStatValue = useb.m_szPassword;
        }else{
            
            CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"密码为空" userInfo:nil];
            [ce raise];
            
        }
    }
    
    NSMutableDictionary *mptochange = [NSMutableDictionary dictionary];
    NSString  *userStat = [USER_STAT_ID getKeyNameForCompanyStatID:userStatid];
    [mptochange addEntriesFromDictionary:@{userStat:szStatValue}];
    OrganizedClientMessage *message = [self getInstanceOfUserSetInfoRequest:szUserAccount mpKeyValuePairs:mptochange];
    
    return  message;
}


/**
 * 用户信息更改请求 <br>-多个需要修改的信息
 * <br><i style="color:green">限登录用户本人修改自身一般信息使用 <br>
 * <b>- 注： 修改密码，邮件地址，手机号等安全敏感度高的信息除外；
 * <br>- 用户账户名不允许修改！</b>
 * <br>安全类属性修改需调用单独属性修改函数：（{@linkplain #getInstanceOfUserSetInfoRequest(String , USER_STAT_ID , String)} )</i>
 * <br><i style="color:orange">目的：用户自身一般信息（属性）发生变化时，更新数据；</i>
 * <br>
 * 参数说明：
 * <ul>
 * <li>COOKIE: SESSIONID - Request中必须携带（仅限登录用户使用）;</li>
 * </ul>
 *
 * @param szUserAccount - 用户的Account信息（必须是账号，而非手机号或邮件地址）
 * @param mpKeyValuePairs - 需要修改的信息的key/value键值对；（不可含有null值,不可包含UniqueAccount,PASSWORD,EMAIL,MOBILE）;
 * @return  -组装好的消息
 * @throws OrganizedException	参数不合法时抛出异常；
 */

+(OrganizedClientMessage *)getInstanceOfUserSetInfoRequest:(NSString *) szUserAccount mpKeyValuePairs:(NSDictionary *)mpKeyValuePairs {
    if(mpKeyValuePairs == nil){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"修改的内容为空" userInfo:nil];
        [ce raise];

    }
    
    [OrganizedClientMessage validateUserStatList:[mpKeyValuePairs allKeys] isSet:YES];
    NSString *passWordStr =[USER_STAT_ID getKeyNameForCompanyStatID:Password];
    NSString *EmailStr =[USER_STAT_ID getKeyNameForCompanyStatID:email];
    NSString *mobileStr =[USER_STAT_ID getKeyNameForCompanyStatID:mobile];
    if (([[mpKeyValuePairs allKeys] containsObject:passWordStr] ||[[mpKeyValuePairs allKeys] containsObject:EmailStr] ||[[mpKeyValuePairs allKeys] containsObject:mobileStr])&&mpKeyValuePairs.count != 1) {
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"UserSetInfoRequest - too many user_stat_id key/value pairs" userInfo:nil];
        [ce raise];
    }
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:setInfoRequest];
    [message addUserInfoStat:UniqueAccount szStatuValue:szUserAccount];
    for (NSString *ID in [mpKeyValuePairs allKeys]) {
        USE_STAT_ID useEnum = [USER_STAT_ID getEnumFormStr:ID];
        [message addUserInfoStat:useEnum szStatuValue:mpKeyValuePairs[ID]];
    }
    return message;
}



/**
 * 用户提权请求
 * <br><i style="color:green">登录用户需修改身份验证相关信息时-手机号，邮件地址时，需进行提权请求;
 * <br>提权请求时，用户需在之前的登记的有效通信方式中，选择一种进行身份验证，通过后，服务器会返回一串代码SuperVarCode;(有效期10分钟)
 * </i>
 * <br><i style="color:orange">目的：修改重要信息前的身份验证；</i>
 * <br>
 * 参数说明：
 * <ul>
 * <li>COOKIE: SESSIONID -- Request中必须携带（仅限登录用户使用）;</li>
 * </ul>
 *
 * @param szUserAccount - 用户的账号 - 仅限账号
 * @param idEmailOrMobiel - USER_STAT_ID.Email or USER_STAT_ID.Mobile
 * @param szStatIDValue - 对应上个参数，为邮件地址或者手机号码。(之前通过验证了的通信方式)
 * @return - 组装好的消息
 * @throws OrganizedException 	参数不合法时抛出异常；
 * <ul>
 * <li>OrganizedErrorCode.MESSAGE_CREATE_WRONGPARAM</li>
 * <li>OrganizedErrorCode.MESSAGE_ADDARGUMENT_WRONGPARAM</li>
 * </ul>
 */


+ (OrganizedClientMessage *)	getInstanceOfUserGetSuperCodeRequest:(NSString *) szUserAccount useEnum:(USE_STAT_ID)EmailOrMobielType emialOrMboileNumber:(NSString *)szStatIDValue{
    if(EmailOrMobielType != email && EmailOrMobielType != mobile){
        
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"紧支持邮箱或者手机" userInfo:nil];
        [ce raise];
        
    }
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:getSuperCodeRequest];
    [message addUserInfoStat:UniqueAccount szStatuValue:szUserAccount];
    [message addUserInfoStat:EmailOrMobielType szStatuValue:szStatIDValue];
    
    return message;
}


/**
 *
 * 供登录管理员用户 - 修改公司高安全敏感度的信息或其他单个属性信息使用
 * <ul style="color:blue">
 * <li>公司名称不允许修改！</li>
 * <li>修改邮件地址，或者手机号时(必须使用此函数)，在使用此函数之前，必须先验证之前登记过的有效的身份验证方式进行提权（提权请求），提权成功，从服务器返回的回应消息内容中获取提权码：SuperVarCode.</li>
 * <li>其它修改若只有一个参数变动，也可以使用这个函数；</li>
 * </ul>
 * <font style="color:orange">目的：用户自身安全信息（属性）或单个属性信息发生变化时，更新数据；</font>
 *
 * 参数说明：
 * <ul>
 * <li>COOKIE: SESSIONID -- Request中必须携带（仅限登录用户使用）;</li>
 * <li>Parameter: EmailVarCode or MobileVarCode -- 若修改的信息是手机号或者邮件地址，则强制需要验证新提供的号码，以及旧的认证方式之一;</li>
 * <li>Parameter: SuperVarCode</li>
 * </ul>
 * @param szUserAccount - 用户管理员登录账号 -- **仅限账号**
 * @param idCompanyStat - 需要修改的信息的stat; 如：COMPANY_STAT_ID.Email,COMPANY_STAT_ID.Mobile;
 * @param szCompanyStatValue - 上一个参数对应的新的value的值；如email的实际值，手机号；
 * @return 组装好的客户端消息
 * @throws OrganizedException - 参数有误的情况下跳出异常；
 */

+(OrganizedClientMessage *)	getInstanceOfCompanySetInfoRequest:(NSString *) szUserAccount companyEnum:(COMPANy_STAT_ID) idCompanyStat szCompanyStatValue:(NSString *)szCompanyStatValue{
    NSMutableDictionary *mapStats = [NSMutableDictionary dictionary];
    NSString *str1 = [COMPANY_STAT_ID getKeyNameForCompanyStatID:idCompanyStat];
    [mapStats addEntriesFromDictionary:@{str1:szCompanyStatValue}];
    OrganizedClientMessage *message = [OrganizedClientMessage getInstanceOfCompanySetInfoRequest:szUserAccount values:mapStats];
    
    return message;
}

/**
 * 公司信息更改请求 <br>-多个需要修改的信息
 * <br><i style="color:green">限登录管理员用户修改公司一般信息使用
 * <b><br>- 注： 邮件地址，手机号等安全敏感度高的信息除外；
 * <br>- 公司名称不允许修改！</b>
 * <br>安全类属性修改需调用单独属性修改函数：（{@linkplain #getInstanceOfCompanySetInfoRequest(String, COMPANY_STAT_ID, String)} )</i>
 * <br><i style="color:orange">目的：公司一般信息（属性）发生变化时，更新数据；</i>
 * <br>
 * 参数说明：
 * <ul>
 * <li>COOKIE: SESSIONID - Request中必须携带（仅限登录用户使用）;</li>
 * </ul>
 *
 * @param szUserAccount - 登录用户的Account信息（必须是账号，而非手机号或邮件地址）
 * @param valuepairs - 需要修改的信息的参数键值对；
 * @return 组装好的客户端消息
 * @throws OrganizedException 参数错误的情况下抛出异常；
 */

+(OrganizedClientMessage *)	getInstanceOfCompanySetInfoRequest:(NSString *) szUserAccount values:(NSDictionary *)valuepairs{
    
    if(valuepairs == nil){
        
        CodeException *ce = [[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"公司信息修改为空" userInfo:nil];
        [ce raise];

    }
    [OrganizedClientMessage validateCompanyStatList:[valuepairs allKeys] bset:YES];

    if(![CommonFunctions functionsIsStringValid:szUserAccount ]){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"账号错误" userInfo:nil];
        [ce raise];
        
    }
    if (([[valuepairs allKeys] containsObject:@"Email"] ||[[valuepairs allKeys] containsObject:@"Email"]) &&valuepairs.fileSize != 1) {
        
    }
    
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initCompanyWith:SetInfoRequest];
    [message addUserInfoStat:UniqueAccount szStatuValue:szUserAccount];
    [message addCompanyInfoStat:valuepairs];
    
    return message;
}



/**
 * 仅适用于 - 登录用户 使用旧密码进行身份验证，然后修改当前密码的情况；
 * <ul>
 * <li><span style="color:blue">（本函数适用）</span>修改密码：先输入旧密码，再输入两次新密码，吻合以及符合密码规则的情况下，发送修改请求至服务器。此时无需验证手机或者邮箱。</li>
 * </ul>
 * @param szUserAccount - 用户的账号 - 仅限账号
 * @param szOldPassword 用户的旧密码
 * @param szNewPassword 用户修改的新密码
 * @return -组装好的客户端消息
 * @throws OrganizedException - 参数错误则跳出异常；
 */
//
+(OrganizedClientMessage *)getInstanceOfUserSetInfoRequestOldPassWord:(NSString *)szUserAccount oldPassword:(NSString*)szOldPassword  szNewPassword:(NSString *) szNewPassword{
    OrganizedClientMessage *clientMessage = [OrganizedClientMessage getInstanceOfUserSetInfoRequestSign:szUserAccount tyepe:Password szStatValue:szNewPassword];
    [clientMessage addUserOldPassword:szOldPassword];
    
    return clientMessage;
}



/**
 * 管理员管理操作请求 - 必须是登录用户和管理员才可以发起请求
 * <br>具体请求内容类型，查看class - {@linkplain AdminManagementOperation};
 * @param adminoperation - 管理操作对象
 * @return  组装好的客户端消息
 * @throws OrganizedException 参数为空或者非法（如adminoperation == null or adminoperation.isValid() 返回false；
 */
+(OrganizedClientMessage *) getInstanceOfAdminManagementOperationRequest:(AdminManagementOperation *) adminoperation{
    OrganizedClientMessage *message = [[OrganizedClientMessage alloc]initUserWith:adminManagementRequest];
    [message addAdminManagementOperation:adminoperation];
    return message;
}




///**
// * FunctionOperationRequest - 功能相关操作请求
// *
// * <br>具体请求内容类型，查看class - {@linkplain FunctionOperation};
// * @param funcOperation - 功能相关操作对象
// * @return  组装好的客户端消息
// * @throws OrganizedException 参数为空或者非法（如funcOperation == null or funcOperation.isValid() 返回false；
// */
//
//public static OrganizedClientMessage getInstanceOfFunctionOperationRequest(FunctionOperation funcOperation) throws OrganizedException{
//    OrganizedClientMessage message = new OrganizedClientMessage(USER_MESSAGE.FunctionRequest);
//    message.addFunctionOperation(funcOperation);
//    return message;
//}


@end
