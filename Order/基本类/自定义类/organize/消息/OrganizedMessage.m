//
//  OrganizedMessage.m
//  PersonClass
//
//  Created by wang on 16/7/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedMessage.h"
#import "CodeException.h"

typedef enum MESSAGE_ARGUMENTS{
    ERRORCODE,
    
    ORGANIZEDCOMPANYBASE,	//对象
    USERBEAN,
    ORGANIZEDMEMBER,
    ORGANIZEDCOMPANY,
    ADMINMANAGEMENTOPERATION,
    ADMINMANAGEMENTOPERATIONRESULT,
    FUNCTIONOPERATION,
    FUNCTIONOPERATIONRESULT,
    
    
    COMPANY_INFOID,
    USER_INFOID,
    ACTIVATIONCODE_ISADMINCODE,
    LOGIN_HAS_VARCODE,
    USER_SUPERCODE,
    COMPANY_STAT_KEYLIST,
    USER_STAT_KEYLIST,
    INFO_QUERY_KEY,
    USER_ISLOGIN,
    USER_OLDPASSWORD,
    COMPANY_PLANCHANGE,
    PLANCHANGE_EXTENDDAYS,
    
    DATAQUERY,
    DATAQUERYRESULT,
    USER_ENABLED_FUNC,
}MESSAGE_ARGUMENTS;

@implementation OrganizedMessage


 static  NSString *MESSAGECIPHERCLIENT		=@"Qilikeji_2016_cipher0829";

//============================== Construction Functions=====================================
/**构造有序应用消息基类对象 - 仅可继承
 * <br>Only For Server - 仅当应用在服务器端。
 * @param msgcpy - 生成公司类的空消息；
 * @throws OrganizedException  - 参数为null 跳出异常；
 */

-(instancetype)initUserWith:(USER_MESSAGE)msgcpy{
    if (self = [super init]) {
    _m_msgMaintype = USER;
    _m_iMsgID = msgcpy;
    _m_argmentsmap = [NSMutableDictionary dictionary];
    }
    return self;
}

/**构造有序应用消息基类对象 - 仅可继承
 * <br>Only For Server - 仅当应用在服务器端。
 * @param msguser - 生成用户类的空消息；
 * @throws OrganizedException - 参数为null 跳出异常；
 */

-(instancetype)initCompanyWith:(COMPANY_MESSAGE)msgcpy{
    if (self = [super init]) {
        _m_msgMaintype = COMPANY;
        _m_iMsgID = msgcpy;
        _m_argmentsmap = [NSMutableDictionary dictionary];
    }
    return self;
}

/**构造有序应用消息基类对象
 * <br> 从网络端收入的消息内容（Encrypted JSON string)进行消息构造；
 * @param szEncryptedString - 消息字符串流；
 *  @throws OrganizedException - 参数为null 或无效的JSON格式 跳出异常；
 */

-(OrganizedMessage*)initWithStringToMessage:(NSString *)szEncryptedString{
    
    if (self = [super init]) {
    
    if(![CommonFunctions functionsIsStringValidAfterTrim:szEncryptedString]) {
        CodeException *ce =  [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"Empty szEncryptedString argument" userInfo:nil];
        [ce raise];
    }
    
    @try {
        NSDictionary *jsObject = [CommonFunctions functionsFromJsonStringToObject:szEncryptedString];
        _m_msgMaintype  = [jsObject[@"MSG_TYPE"] intValue];
        _m_iMsgID = [jsObject [@"MSG_ID"] intValue];
        if ([[jsObject allKeys] containsObject:@"ARGS_HASH"] == YES) {
            NSDictionary *ARGS_HASHDic = (NSDictionary *)jsObject[@"ARGS_HASH"];
            _m_argmentsmap = [OrganizedMessage _argumentJsonObjectToHash:ARGS_HASHDic];
        }
    } @catch (NSException *exception) {
        CodeException *ce =  [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:exception.reason userInfo:nil];
        [ce raise];
    }
    }
    
    if ([[self.m_argmentsmap allKeys] containsObject:@"ERRORCODE"]) {
         return nil;
    }
    return self;
}



-(NSString *)getKeyNameForArgument:(MESSAGE_ARGUMENTS)enumArgName{
    switch (enumArgName) {
        case ERRORCODE:return @"ERRORCODE";
        case ORGANIZEDCOMPANYBASE:return @"ORGANIZEDCOMPANYBASE";
        case USERBEAN:return @"USERBEAN";
        case ORGANIZEDMEMBER:return @"ORGANIZEDMEMBER";
            
        case ORGANIZEDCOMPANY: return @"ORGANIZEDCOMPANY";
        case ADMINMANAGEMENTOPERATION: return @"ADMINMANAGEMENTOPERATION";
        case ADMINMANAGEMENTOPERATIONRESULT: return @"ADMINMANAGEMENTOPERATIONRESULT";
        case FUNCTIONOPERATION: return @"FUNCTIONOPERATION";
        case FUNCTIONOPERATIONRESULT: return @"FUNCTIONOPERATIONRESULT";
        case COMPANY_INFOID: return @"COMPANY_INFOID";
        case USER_INFOID: return @"USER_INFOID";
        case ACTIVATIONCODE_ISADMINCODE: return @"ACTIVATIONCODE_ISADMINCODE";
        case LOGIN_HAS_VARCODE: return @"LOGIN_HAS_VARCODE";
        case USER_SUPERCODE: return @"USER_SUPERCODE";
        case COMPANY_STAT_KEYLIST: return @"COMPANY_STAT_KEYLIST";
        case USER_STAT_KEYLIST: return @"USER_STAT_KEYLIST";
        case INFO_QUERY_KEY: return @"INFO_QUERY_KEY";
            
        case USER_ISLOGIN: return @"USER_ISLOGIN";
        case USER_OLDPASSWORD: return @"USER_OLDPASSWORD";
        case COMPANY_PLANCHANGE: return @"COMPANY_PLANCHANGE";
        case PLANCHANGE_EXTENDDAYS: return @"PLANCHANGE_EXTENDDAYS";
            
        case DATAQUERY: return @"DATAQUERY";
        case DATAQUERYRESULT: return @"DATAQUERYRESULT";
        case USER_ENABLED_FUNC: return @"USER_ENABLED_FUNC";
        default:
            return nil;
    }
}


/**
 * 获取消息的发送方信息
 * @return {@linkplain MESSAGE_SENDER}
 */
-(MESSAGE_SENDER)getMessageSender:(UserCompanyBase *)ba{
       
    return _m_iMsgID % 2 == 0 ? SERVER:CLIENT;
}

/**
 * 添加ErrorCode - ErrorCodes.xml中的error_code
 * <em style='color:green'>
 * <br>使用情景：
 * <br>一般在消息格式或者内容类型非预期，出现错误时进行告知链接的另一端
 * </em>
 * @param objErrorCode ({@linkplain OrganizedException.OrganizedErrorCode})
 * @throws OrganizedException 空的ERRORCODE
 */
-(void)addErrorCode:(CodeException *)objErrorCode{
    
    if (objErrorCode) {
        [_m_argmentsmap addEntriesFromDictionary:@{@"ERRORCODE":@([objErrorCode getCodeID])}];
    }else{
        [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_CREATE_WRONGPARAM" reason:@"AddErrorCode - Empty OrganizedErrorCode"];
    }
}
/**
 * 添加公司基本信息对象
 * <em style='color:green'>
 * <br>使用情景：
 * <br>购买激活码，客户端发送公司基本信息给服务器；
 * <br>激活公司，服务器返回公司基本信息；
 * </em>
 * @param baseobj {@linkplain OrganizedCompanyBase}
 * @throws OrganizedException - UserCompanyBase对象为空或者无效；
 */

-(void)addCompanyBaseInfo:(UserCompanyBase *)baseobj{

    if(baseobj != nil && [baseobj isValid]){
       [_m_argmentsmap addEntriesFromDictionary:@{[self getKeyNameForArgument:ORGANIZEDCOMPANYBASE]:[baseobj toString]}];
    }else{
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"AddCompanyBaseInfo - Empty or invalid UserCompanyBase object" userInfo:nil];
        [ce raise];
    }
    
}
/**
 * 添加公司客户端对象
 * <em style='color:green'>
 * <br>使用情景：
 * <br>激活公司时：补全公司信息之后发送到客户端；
 * <br>修改了公司信息时；
 * </em>
 * @param clientCompany {@linkplain OrganizedCompany}
 * @throws OrganizedException -无效的公司对象
 */

-(void)addClientCompany:(OrganizedCompany *)clientCompany{
      if(clientCompany && [clientCompany isValid]){ //TODO: IS VALID TOO LITTLE INFORMATION
         [_m_argmentsmap addEntriesFromDictionary:@{[self getKeyNameForArgument:ORGANIZEDCOMPANY]:[clientCompany toString]}];
    }else{
        
        [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"AddClientCompany(OrganizedCompany) - Empty or invalid OrganizedUserCompany object"];
    }
    
    
}


/**
 * 添加单个公司的属性
 * <em style='color:green'>
 * <br>使用情景：
 * <br>修改了公司某个信息时；
 * </em>
 * @param id -	{@linkplain COMPANY_STAT_ID} 公司属性ID
 * @param szStatuValue	- 公司属性对应的值；
 * @throws OrganizedException - 参数为空或者无效时跳出异常
 */
-(void)addCompanyInfoStatSign:(COMPANy_STAT_ID)ID statuValue:(NSString *)szStatuValue{
    
    NSString *str2 =[COMPANY_STAT_ID getKeyNameForCompanyStatID:ID];
    if(!ID || ![CommonFunctions functionsIsStringValid:szStatuValue ]){
        NSString *str1 =@"AddCompanyInfoStat(COMPANY_STAT_ID, String) - empty arugment";
        
        NSString *str3 = [str1 stringByAppendingString:str2];
        CodeException *Ce =[[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:str3 userInfo:nil];
        [Ce raise];
        
    }
    
    NSString *szValue = _m_argmentsmap[@"COMPANY_INFOID"];
    
    NSMutableArray  *arrlist  = [NSMutableArray array];
    if(szValue != nil){//对象中并无任何公司属性对
        NSArray *arr  = (NSMutableArray*)[CommonFunctions functionsFromJsonStringToObject:szValue];
        arrlist = [arr mutableCopy];
    }
    
    NSMutableDictionary  *object = [NSMutableDictionary dictionary];
    [object addEntriesFromDictionary:@{@"COMPANY_STAT_ID":str2}];
     [object addEntriesFromDictionary:@{@"VALUE":szStatuValue}];
    [arrlist addObject:object];
    
    [_m_argmentsmap addEntriesFromDictionary:@{@"COMPANY_INFOID":[CommonFunctions functionsFromObjectToJsonString:arrlist]}];
}

/**
 * 添加多个公司的属性
 * <em style='color:green'>
 * <br>使用情景：
 * <br>修改了公司某些信息时；
 * </em>
 * @param hashValue	- 公司属性Key-value hash对； 为空时，不添加，不报错
 * @throws OrganizedException - 有无效参数时跳出异常
 */
-(void)addCompanyInfoStat:(NSDictionary *)hashValue{
    if(hashValue == nil || hashValue.count== 0) return;
    NSArray *arrKeys = [hashValue allKeys];
    for(NSString *str in arrKeys){
        [self addCompanyInfoStatSign:[COMPANY_STAT_ID getEnumFormStr:str] statuValue:hashValue[str]];
    }
}


/**
 * 添加用户基本信息
 * <em style='color:green'>
 * <br>使用情景：
 * <br>登录；注册；查询
 * </em>
 * @param userbeaninfo {@linkplain UserBean}
 * @throws OrganizedException <br>
 * MESSAGE_CREATE_WRONGPARAM - 空的或者无效的UserBean对象
 */
-(void)addUserBean:(UserBean *)userbeaninfo{
    if (userbeaninfo&&[userbeaninfo isValid]) {
        
    [_m_argmentsmap addEntriesFromDictionary:@{[self getKeyNameForArgument:USERBEAN]:[userbeaninfo toString]}];
    }else{
    [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_CREATE_WRONGPARAM" reason:@"AddUserBean(UserBean) - Empty or invalid OrganizedUserCompany strin"];
    }
     
}

 /**
  * 添加用户客户端对象
  * <em style='color:green'>
  * <br>使用情景：
  * <br>激活用户时：注册用户信息之后发送到服务器；
  * <br>修改了用户信息时，发送到服务器
  * <br>用户请求数据，服务器发送到客户端；
  * </em>
  * @param clientmember	{@linkplain OrganizedMember}
  * @throws OrganizedException <br>
  * MESSAGE_CREATE_WRONGPARAM - 空的或者无效的OrganizedCompanyMember对象
  */
-(void)addClientUser:(OrganizedMember *)clientmember{
     if(clientmember && [clientmember isValid]){ //TODO: IS VALID TOO LITTLE INFORMATION
        [_m_argmentsmap addEntriesFromDictionary:@{[self getKeyNameForArgument:ORGANIZEDMEMBER]:[clientmember toString]}];
     }else{
         
         [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"AddClientUser(OrganizedMember) - Empty or invalid OrganizedCompanyMember string"];
     }
 }
     
/**
 * 添加多个用户的属性
 * <em style='color:green'>
 * <br>使用情景：
 * <br>修改了用户某些信息时；
 * </em>
 * @param hashValue	- 用户属性Key-value hash对； 为空时，不添加，不报错
 * @throws OrganizedException  - 有无效参数时跳出异常
 */
-(void)addUserInfoStat:(NSDictionary *)hashValue{
     if(hashValue == nil || hashValue.count== 0) return;
     NSArray *arrKeys = [hashValue allKeys];
     for(NSString *str in arrKeys){
         [self addUserInfoStat:[USER_STAT_ID getEnumFormStr:str] szStatuValue:hashValue[str]];
     }
 }
 
 /**
  * 添加单个用户的属性
  * <em style='color:green'>
  * <br>使用情景：
  * <br>修改了用户某项信息时；
  * </em>
  * @param id - {@linkplain USER_STAT_ID} 用户属性ID
  * @param szStatuValue 属性对应的值；
  * @throws OrganizedException - 参数为空或者无效时 跳出异常
  */
 -(void)addUserInfoStat:(USE_STAT_ID )ID  szStatuValue:(NSString *) szStatuValue {
     NSString *str2 =[USER_STAT_ID getKeyNameForCompanyStatID:ID];
     if(str2 == nil||szStatuValue == nil ){
         NSString *str1 =@"AddUserInfoStat(USER_STAT_ID,String) - empty arugment";
         NSString *str3 = [str1 stringByAppendingString:str2];
         [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:str3];
     }
     NSString *szValue = _m_argmentsmap[@"USER_INFOID"];
     NSMutableArray  *arrlist  = [NSMutableArray array];
     if(szValue != nil){//对象中并无任何公司属性对
         NSArray *arr  = (NSMutableArray*)[CommonFunctions functionsFromJsonStringToObject:szValue];
         arrlist = [arr mutableCopy];
     }
     NSMutableDictionary  *object = [NSMutableDictionary dictionary];
     [object addEntriesFromDictionary:@{@"USER_STAT_ID":str2}];
     [object addEntriesFromDictionary:@{@"VALUE":szStatuValue}];
     [arrlist addObject:object];
     
     [_m_argmentsmap addEntriesFromDictionary:@{@"USER_INFOID":[CommonFunctions functionsFromObjectToJsonString:arrlist]}];
}


/**
 * 判断用户是否在查询有效的联系方式；
 * @param arrStatList - 需分析检测的参数数组
 * @return true - 正在查询有效联系方式信息； 否则返回false;
 */

+(BOOL)isUserRequestingValidContactDetails:(NSArray *)arrStatList{
    
    if(arrStatList == nil || arrStatList.count != 3 ||
       ([arrStatList[0] isEqualToString: @"Email"] && [arrStatList[0] isEqualToString: @"Mobile"] && [arrStatList[0] isEqualToString: @"ValidContact"] )||
       ([arrStatList[1] isEqualToString: @"Email"] && [arrStatList[1] isEqualToString: @"Mobile"] && [arrStatList[1] isEqualToString: @"ValidContact"]) ||
       ([arrStatList[2] isEqualToString: @"Email"] && [arrStatList[2] isEqualToString: @"Mobile"] && [arrStatList[2] isEqualToString: @"ValidContact"]) ){
        return false;
    }
    return true;
}


/**
 * 查询，获取公司属性时使用。
 * @param arrStatIDs - 需要查询的属性列表
 * @throws OrganizedException
 */

-(void)addCompanyStatKeyListCOMPANY_STAT_ID:(NSArray *)arrStatIDs{
    if(arrStatIDs == nil){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"addCompanyStatKeyList - empty KeyList" userInfo:nil];
        [ce raise];
    }
    
    NSMutableArray *arrKeyList = [NSMutableArray array];
    for(NSString *str in arrStatIDs){
        if(str == nil){
            CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"addCompanyStatKeyList - empty USER_STAT_ID" userInfo:nil];
            [ce raise];
        }
        [arrKeyList addObject:str];
    }
    NSString *str1 = [self getKeyNameForArgument:COMPANY_STAT_KEYLIST];
    [_m_argmentsmap addEntriesFromDictionary:@{str1:[CommonFunctions functionsFromObjectToJsonString:arrKeyList]}];
    
}

/**
 * 在查询公司信息时，需指定是否登录状态下查询；(仅在此情况下使用)
 *
 * @param bIsLogin - 查询时用户为登录状态-true,否则设置false;
 */
-(void)addUserLoginFlag:(BOOL)bIsLogin{
    NSString *boolStr;
    if (bIsLogin == true) {
   boolStr = @"true";
    }else{
    boolStr = @"false";
    }
    NSString *arguStr = [self getKeyNameForArgument:USER_ISLOGIN];
  [_m_argmentsmap addEntriesFromDictionary:@{arguStr:boolStr}];
}

/**
 * 仅供查询消息时使用，把查询时使用的Key加入到消息中。
 * <br>函数内部会把key做trim处理；
 * @param szQueryKey - 查询公司时，可以是公司名称，公司手机，邮箱； 查询用户信息时，可以是用户账号，手机号或者邮箱地址；
 * @throws OrganizedException  参数为空时抛出异常；
 */

-(void)addInfoQueryKey:(NSString *)szQueryKey{
    if(![CommonFunctions functionsIsStringValidAfterTrim:szQueryKey]){
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"addInfoQueryKey - empty query key" userInfo:nil];
        [ce raise];
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    szQueryKey = [szQueryKey stringByTrimmingCharactersInSet:set];
    NSString *infoStr = [self getKeyNameForArgument:INFO_QUERY_KEY];
    [_m_argmentsmap addEntriesFromDictionary:@{infoStr:szQueryKey}];
}

/**
 * 添加一对激活码信息
* <em style='color:green'>
* <br>使用情景：
* <br>客户端请求激活码时，由服务器发送；
* </em>
* @param ActivationCodes - 激活码串的数组；SIZE应为2，<br>
* [0] - 管理员激活码
* <br>[1] - 客户端激活码
* @throws OrganizedException - 激活码对无效
*/
-(void)addActivationCodePair:(NSArray *)ActivationCodes{
    if(![CommonFunctions functionsIsArrayValid:ActivationCodes] || ActivationCodes.count != 2){
        [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"AddActivationCodePair(String[]) - Empty or invalid ActivationCodes"];
  }
    NSString *szValue = [CommonFunctions functionsJoinString:@"" arr:ActivationCodes];
    [self addCompanyInfoStatSign:Activationcode statuValue:szValue];
}

/**
* 添加激活码类型信息 - 单个激活码的情况
* <em style='color:green'>
* <br>使用情景：
* <br>客户端使用激活码进行激活时，需要指定当前的激活码类型是管理员激活码还是员工激活码
* </em>
* @param bCompany - 是否为公司激活码（管理员激活码）<br>
* true - 管理员激活码
* <br>false - 客户端激活码
*/
-(void)addUserAdminFlag:(BOOL)bCompany{
    NSString *str ;
    if (bCompany == YES) {
        str =@"YES";
    }else{
    str =@"NO";
    }
    [_m_argmentsmap addEntriesFromDictionary:@{@"ACTIVATIONCODE_ISADMINCODE":str}];
  
}
/**
 * 检测邮箱，电话，账号是否被占用：
 * <em style='color:green'>
 * <br>使用情景：
 * <br>邮箱电话，账号失去焦点时候
 * </em>
 * @param bUserInterface - true - 前台登录，有校验码； false - 后台登录，无校验码
 */
+(NSDictionary *)IsBeingUsedcheckType:(CheckType)checkType pamar:(NSString *)pamar uniqueID:(NSString*)uniqueID{
    if (![CommonFunctions functionsIsStringValidAfterTrim:pamar] ) {
        return nil;
    }
    NSString *calendarToDateTimeString = [CommonFunctions functionsStringFromDate];
    NSString *aesEncryptStr = [SecurityUtil encryptAESDataToBase64AndKey:pamar key:calendarToDateTimeString];
    
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    [mudic addEntriesFromDictionary:@{KEY_REQUESTFROM:@"ios"}];
    [mudic addEntriesFromDictionary:@{KEY_TIMESTAMP:calendarToDateTimeString}];
    NSString *strType = [OrganizedParams getStringFormEnum:checkType];
    
      [mudic addEntriesFromDictionary:@{strType:aesEncryptStr}];
    NSString *aesEncryptStr1 = [SecurityUtil encryptAESDataToBase64AndKey:[NSString stringWithFormat:@"%d",checkType] key:calendarToDateTimeString];
    [mudic addEntriesFromDictionary:@{@"CheckType":aesEncryptStr1}];
    if (checkType ==EMPLOYEE_NUMBER) {
        NSString *aesEncryptStr2 = [SecurityUtil encryptAESDataToBase64AndKey:uniqueID key:calendarToDateTimeString];
    [mudic addEntriesFromDictionary:@{@"UniqueID":aesEncryptStr2}];
    }
    return  mudic;

}

/**
* 指定登录方式：
* <em style='color:green'>
* <br>使用情景：
* <br>客户端登录时，用来指定是由用户界面输入登录，还是APP后台发送的登录包;
* </em>
* @param bUserInterface - true - 前台登录，有校验码； false - 后台登录，无校验码
*/

-(void)addLoginVarCodeFlag:(BOOL)bUserInterface{
    NSString *str ;
    if (bUserInterface == YES) {
        str =@"YES";
    }else{
        str =@"NO";
    }
    [_m_argmentsmap addEntriesFromDictionary:@{@"LOGIN_HAS_VARCODE":str}];
    
}
-(NSString *)getCompanyBaseInfoString{
    NSString *COMPANY_BASE_INFOstr = [self getKeyNameForArgument:ORGANIZEDCOMPANY];
    if(_m_argmentsmap != nil && [[_m_argmentsmap allKeys] containsObject:COMPANY_BASE_INFOstr]){
        return _m_argmentsmap[COMPANY_BASE_INFOstr];
    }else{
        return nil;
    }
}

/**
 * 读取单个公司属性value;
 * @param id	- 公司属性{@linkplain COMPANY_STAT_ID};
 * @return	String - 无效或者不含指定的公司属性信息时，返回NULL；
 */
-(NSString *)getCompanyInfoStatString:(COMPANy_STAT_ID)ID{
    NSMutableDictionary *valuehash = [self getCompanyInfoStat];
    NSString *uniqueStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:ID];
    if(valuehash != nil && [[valuehash allKeys] containsObject:uniqueStr]){
        return valuehash[uniqueStr];
    }
    return nil;
}
/**
 * 读取公司基本信息对象;
* @return	UserCompanyBase - 无效或者不含有该信息时，返回NULL；
*/
-(UserCompanyBase*)getCompanyBaseObject{
    NSString *szBaseinfo = [self getCompanyBaseInfoString];
    if([CommonFunctions functionsIsStringValid:szBaseinfo]){
        @try {
            return [[UserCompanyBase alloc]initWithJsonString:szBaseinfo];
        } @catch (NSException *exception) {
               NSString *COMPANY_BASE_INFOstr = [self getKeyNameForArgument:ORGANIZEDCOMPANYBASE];
            NSLog(@"%@--%@",COMPANY_BASE_INFOstr,exception);
        }
    }
    return nil;
}

-(UserCompanyBase*)getCompanyBaseVercityObject{
    NSString *COMPANY_BASE_INFOstr = [self getKeyNameForArgument:ORGANIZEDCOMPANYBASE];
    NSString *szBaseinfo ;
    if(_m_argmentsmap != nil && [[_m_argmentsmap allKeys] containsObject:COMPANY_BASE_INFOstr]){
        szBaseinfo = _m_argmentsmap[COMPANY_BASE_INFOstr];
    }
    
    if([CommonFunctions functionsIsStringValid:szBaseinfo]){
        @try {
            return [[UserCompanyBase alloc]initWithJsonString:szBaseinfo];
        } @catch (NSException *exception) {
            NSString *COMPANY_BASE_INFOstr = [self getKeyNameForArgument:ORGANIZEDCOMPANYBASE];
            NSLog(@"%@--%@",COMPANY_BASE_INFOstr,exception);
        }
    }
    return nil;
}



/**
 * 读取用户基本信息对象;
 * @return	UserBean - 无效或者不含有该信息时，返回NULL；
 */
-(NSString *)getUserBeanString{
    if(_m_argmentsmap != nil && [[_m_argmentsmap allKeys] containsObject:@"ORGANIZEDMEMBER"]){
        return _m_argmentsmap[@"ORGANIZEDMEMBER"];
    }else{
        return nil;
    }
}

-(UserBean*)getUserBeanObject{
    NSString *szBaseinfo = [self getUserBeanString];
    if([CommonFunctions functionsIsStringValid:szBaseinfo]){
        @try{
            return [[UserBean alloc]initWith:szBaseinfo];
        }@catch(NSException *exception){
            NSLog(@"ORGANIZEDMEMBER --%@",exception);
        }
    }
    return nil;
}

/**
 * 读取用户完整客户端信息对象;
 * @return	OrganizedCompanyMember - 无效或者不含有该信息时，返回NULL；
 */

-(OrganizedMember *)getClientUserObject{
    NSString *szBaseinfo = [self getClientUserString];
    if([CommonFunctions functionsIsStringValid:szBaseinfo]){
        @try {
            return  [[OrganizedMember alloc]initWith:szBaseinfo];
        } @catch (NSException *exception) {
            NSLog(@"%@",exception.reason);
        }
        
        
    }
    
    return nil;
}


-(NSString *)getClientUserString{
    NSString *str = [self getKeyNameForArgument:ORGANIZEDMEMBER];
    if (_m_argmentsmap != nil &&[[_m_argmentsmap allKeys] containsObject:str]) {
        return _m_argmentsmap[str];
    }
    return nil;
    
}

-(NSString *)getClientCompanyString{
    NSString *str = [self getKeyNameForArgument:ORGANIZEDCOMPANY];
    if (_m_argmentsmap != nil &&[[_m_argmentsmap allKeys] containsObject:str]) {
        return _m_argmentsmap[str];
    }
    return nil;
    
}
/**
 * 读取公司完整客户端信息对象;
 * @return	OrganizedUserCompany - 无效或者不含有该信息时，返回NULL；
 */
-(OrganizedCompany*)getClientCompanyObject{
    NSString *szBaseinfo = [self getClientCompanyString];
    if([CommonFunctions functionsIsStringValid:szBaseinfo]){
        @try {
            return  [[OrganizedCompany alloc]initWithJsonString:szBaseinfo];
        } @catch (NSException *exception) {
            NSLog(@"%@",exception.reason);
        }
     
    
    }

    return nil;
}

//
-(AdminManagementOperation *) getAdminManagementOperationObject{
    
    
    NSString *str = [self getKeyNameForArgument:ADMINMANAGEMENTOPERATION];
    NSString *jsonStr;
    if (_m_argmentsmap != nil &&[[_m_argmentsmap allKeys] containsObject:str]) {
        jsonStr = _m_argmentsmap[str];
    }
    if([CommonFunctions functionsIsStringValid:jsonStr]){
        @try {
            return  [[AdminManagementOperation alloc]initWithJsonString:jsonStr];
        } @catch (NSException *exception) {
            NSLog(@"%@",exception.reason);
        }
        
        
    }
    
    return nil;
   
}

-(AdminManagementOperationResult *) getAdminManagementOperationResultObject{
    
    
    NSString *str = [self getKeyNameForArgument:ADMINMANAGEMENTOPERATIONRESULT];
    NSString *jsonStr;
    if (_m_argmentsmap != nil &&[[_m_argmentsmap allKeys] containsObject:str]) {
        jsonStr = _m_argmentsmap[str];
    }
    if([CommonFunctions functionsIsStringValid:jsonStr]){
        @try {
            return  [[AdminManagementOperationResult alloc]initWithJsonString:jsonStr];
        } @catch (NSException *exception) {
            NSLog(@"%@",exception.reason);
        }
        
        
    }
    
    return nil;
}

//
//-(FunctionOperation *)getFunctionOperationObject{
//    NSString *str = [self getKeyNameForArgument:ADMINMANAGEMENTOPERATIONRESULT];
//    NSString *jsonStr;
//    if (_m_argmentsmap != nil &&[[_m_argmentsmap allKeys] containsObject:str]) {
//        jsonStr = _m_argmentsmap[str];
//    }
//    if([CommonFunctions functionsIsStringValid:jsonStr]){
//        @try {
//            return  [[AdminManagementOperationResult alloc]initWithJsonString:jsonStr];
//        } @catch (NSException *exception) {
//            NSLog(@"%@",exception.reason);
//        }
//        
//        
//    }
//    
//    return nil;
//    
//    ArgumentObject object =  _getObject(FunctionOperation.class);
//    return object == null ? null : (FunctionOperation)object;
//}

//public FunctionOperationResult getFunctionOperationResultObject(){
//    ArgumentObject object =  _getObject(FunctionOperationResult.class);
//    return object == null ? null : (FunctionOperationResult)object;
//}
//

/**
 * 读取发送而来的激活码对;
 * @return	String[] - 无效或者不含ActivatonCodePair信息时，返回NULL；
 * 否则 <br>[0] - 管理员激活码<br>
 * [1] - 员工激活码
 */
-(NSArray*) getActivatonCodePair{
    NSString *szValue = [self getCompanyInfoStatString:Activationcode];
    if(![CommonFunctions functionsIsStringValid:szValue]) return nil;
    NSArray *ActivationCodes = [szValue componentsSeparatedByString:@" "];
    if([CommonFunctions functionsIsArrayValid:ActivationCodes] && ActivationCodes.count == 2){
        return ActivationCodes;
    }
    return nil;
}


-(NSString *)getErrorCode{
    if(_m_argmentsmap != nil && [[_m_argmentsmap allKeys] containsObject:@"ERRORCODE"]){
        return _m_argmentsmap[@"ERRORCODE"];
    }else{
        return nil;
    }

}

-(NSString *)testString{
    
    NSString *szResult = [CommonFunctions functionsFromObjectToJsonString:[self toJson]];
    return szResult;
}

-(NSString *)toString{
    NSDictionary *dic = [self toJson];
    NSString *szResult = [CommonFunctions functionsFromObjectToJsonString:dic];
    @try {
        szResult = [self encrytMessageContent:szResult];
    
    } @catch (NSException *exception) {
        NSLog(@"NSException(Name:MESSAGE_ENCRYPTION_ERROR -- reason:%@)",exception);
    }
    return szResult;
}
/**
 *  加密
 */
-(NSString *)encrytMessageContent:(NSString *)szMessagecontent{
    if (![CommonFunctions functionsIsStringValidAfterTrim:szMessagecontent]) {
        [CommonFunctions functionsthrowExcentptionWith:@"MESSAGE_ENCRYPTION_ERROR" reason:nil];
    }
    return  [SecurityUtil encryptAESDataToBase64:szMessagecontent];

}

-(NSDictionary *)toJson{
    NSMutableDictionary  *jsonObject = [NSMutableDictionary dictionary];
    [jsonObject addEntriesFromDictionary:@{@"MSG_TYPE":[self getStringFormMESSAGE_TYPE:_m_msgMaintype]}];
    [jsonObject addEntriesFromDictionary:@{@"MSG_ID":@(_m_iMsgID)}];
        if(_m_argmentsmap != nil){
            NSDictionary *dic = [self argumentHashtoJsonObject:_m_argmentsmap];
        [jsonObject addEntriesFromDictionary:@{@"ARGS_HASH":dic}];
        }
    return jsonObject;
}


    
-(NSDictionary *)argumentHashtoJsonObject:(NSDictionary *)mpArguments{
        if(mpArguments == nil) return nil;
        
    NSMutableDictionary  *object = [NSMutableDictionary dictionary];
    for (NSString *str  in [mpArguments allKeys]) {
        if (mpArguments[str]) {
          [object addEntriesFromDictionary:@{str:@(_m_iMsgID)}];
        }
        
    }
    NSArray *arr= [mpArguments allKeys];
        for(NSString *str in arr){
            if(mpArguments[str] != nil){
                [object addEntriesFromDictionary:@{str:mpArguments[str]}];
                
            }
        }
        return object;
}

/**公司或者个人信息*/
-(NSString *)getStringFormMESSAGE_TYPE:(MESSAGE_TYPE)ID{
    NSArray *arr=  [self getMESSAGE_TYPE];
    return  [arr objectAtIndex:ID];
}

-(NSArray *)getMESSAGE_TYPE{
    return @[@"COMPANY",@"USER"];
}

/**一切小心*/
-(NSString *)getStringFormMESSAGE_ARGUMENTS:(MESSAGE_ARGUMENTS)ID{
    return  [self getKeyNameForArgument:ID];
    
}

+(NSMutableDictionary *)_argumentJsonObjectToHash:(NSDictionary *)objectArguments{
    if(objectArguments == nil) return nil;
    NSMutableDictionary *valuelist = [NSMutableDictionary dictionary];
    NSArray *messageArr =[OrganizedMessage getMESSAGE_ARGUMENTS];
    for(NSString *str in messageArr){
        if([[objectArguments allKeys] containsObject:str] == YES){
            NSString *szValue = objectArguments[str];
            if(szValue != nil){
                [valuelist addEntriesFromDictionary:@{str:szValue}];
                
            }
        }
    }
    return valuelist;
}



/**
 *
 * 判断用户是否能设置某些属性
 * @param valuepairs
 * @param bSet  true-设置模式； false - 读取模式；
 * @throws OrganizedException
 */

+(void)validateUserStatList:(NSArray *)valuepairs isSet:(BOOL)bSet{
    if(valuepairs == nil){
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"ClientHashList Validation Error: Hashmap is not initialiszed" userInfo:nil];
     [ce raise];
    }
    //TODO --- 集合到USER_STAT_ID中去；
    if(bSet == true){//不允许修改的
        NSString *uniqueStr = [USER_STAT_ID getKeyNameForCompanyStatID:UniqueAccount];
        NSString *companyIDStr = [USER_STAT_ID getKeyNameForCompanyStatID:MyCompanyID];
        NSString *registrationTimeStr = [USER_STAT_ID getKeyNameForCompanyStatID:RegistrationTime];
        NSString *lastLoginTimeStr = [USER_STAT_ID getKeyNameForCompanyStatID:LastLoginTime];
        NSString *currentLoginDeviceIDStr = [USER_STAT_ID getKeyNameForCompanyStatID:CurrentLoginDeviceID];
        NSString *ExceptionFunctionListStr = [USER_STAT_ID getKeyNameForCompanyStatID:ExceptionFunctionList];
        NSString *MySaltStr = [USER_STAT_ID getKeyNameForCompanyStatID:MySalt];
        NSString *AdminTypeStr = [USER_STAT_ID getKeyNameForCompanyStatID:AdminType];
        NSString *AdminOfFunctionStr = [USER_STAT_ID getKeyNameForCompanyStatID:AdminOfFunction];
        NSString *AdminSummaryStr = [USER_STAT_ID getKeyNameForCompanyStatID:AdminSummary];
        if([valuepairs  containsObject:uniqueStr]||
           [valuepairs  containsObject:companyIDStr]||
           [valuepairs  containsObject:registrationTimeStr] ||
           [valuepairs  containsObject:lastLoginTimeStr]||
           [valuepairs  containsObject:currentLoginDeviceIDStr]||
           [valuepairs  containsObject:ExceptionFunctionListStr]||
           [valuepairs  containsObject:MySaltStr]||
           [valuepairs  containsObject:AdminTypeStr]||
           [valuepairs  containsObject:AdminOfFunctionStr]||
           [valuepairs  containsObject:AdminSummaryStr]
           ){
            CodeException *ce =  [[CodeException alloc]initWithName:@"USER_SETINFO_CONTAINSNOTACCESSIBLESTAT" reason:@"ClientHashList Validation Error: hashMap contains illegal value which is not ok to set from client" userInfo:nil];
            [ce raise];
        }
        //可被管理员修改的参数；
        //			AdminType,
        //			AdminSummary,
        //			AdminOfFunction
        
    }
    
}

/**
 * 读取公司属性key-value的hashmap;
 * @return	- 无效或者不含公司属性信息时，返回NULL,否则返回key-value的hashmap;
 */
-(NSMutableDictionary *)getCompanyInfoStat{
    NSString *COMPANY_INFOIDStr = [self getKeyNameForArgument:COMPANY_INFOID];
    if (_m_argmentsmap == nil || ![[_m_argmentsmap allKeys] containsObject:COMPANY_INFOIDStr] || _m_argmentsmap[COMPANY_INFOIDStr]== nil) {
        return nil;
        
    }
    NSString *szValue = _m_argmentsmap[COMPANY_INFOIDStr];
     NSMutableArray *arrList = [CommonFunctions functionsFromJsonStringToObject:szValue];
    
   
    NSMutableDictionary *hashResult = [NSMutableDictionary dictionary];
    
    for(id object in arrList){
        NSDictionary *ob1 = (NSDictionary *) object;
        if (ob1 != nil &&[[ob1 allKeys] containsObject:@"COMPANY_STAT_ID"] &&[[ob1 allKeys] containsObject:@"VALUE"]) {
            NSString *str1 = ob1[@"COMPANY_STAT_ID"];
            NSString *str2 =  ob1[@"VALUE"];
            
            if([CommonFunctions functionsIsStringValid:str1] && str2 != nil){

                [hashResult addEntriesFromDictionary:@{str1:str2}];
                
            }
            
        }
     
    }
    
  
    return hashResult;
}



/**
 * 读取员工属性key-value的hashmap;
 * @return	 无效或者不含属性信息时，返回NULL,否则返回员工属性key-value的hashmap；
 */
-(NSDictionary *)getUserInfoStat{
    NSString *nameKey = [self getKeyNameForArgument:USER_INFOID];
    if(_m_argmentsmap == nil || ![[_m_argmentsmap allKeys] containsObject:nameKey] || _m_argmentsmap[nameKey] == nil ) return nil;
    NSString *szValue = _m_argmentsmap[nameKey];
    NSArray *arrList =[CommonFunctions functionsFromJsonStringToObject:szValue];
    NSMutableDictionary *hashResult = [NSMutableDictionary dictionary];
    
    for(NSDictionary *object in arrList){
        @try {
            if (object !=nil && [[object allKeys] containsObject:@"USER_STAT_ID"] && [[object allKeys] containsObject:@"VALUE"] ) {
                NSArray *strarrKeyValuePair  = @[object[@"USER_STAT_ID"],object[@"VALUE"]];
            
            if([CommonFunctions functionsIsStringValid:strarrKeyValuePair[0]]  && strarrKeyValuePair[1] != nil){
                NSString *str1=  strarrKeyValuePair[0];
                [hashResult addEntriesFromDictionary:@{str1:strarrKeyValuePair[1]}];
                
            }
            }
        } @catch (NSException *exception) {
            NSLog(@"读取员工属性key-value的hashmap;");
        }
        
    }
        return hashResult;
}	


/**
 * 判断用户是否在查询有效的联系方式；
 * @return
 */
+(BOOL)isCompanyQueryWithoutLoginValidCOMPANY_STAT_ID:(NSArray *) arrStatList {
    
    if(!arrStatList || (arrStatList.count != 3 && arrStatList.count != 1)){
        return false;
    }
   COMPANy_STAT_ID compamyOne = [COMPANY_STAT_ID getEnumFormStr:arrStatList[0]];
    if (arrStatList.count == 3) {
        
        COMPANy_STAT_ID compamyTwo = [COMPANY_STAT_ID getEnumFormStr:arrStatList[1]];
        COMPANy_STAT_ID compamyThree = [COMPANY_STAT_ID getEnumFormStr:arrStatList[2]];
    }
    
    if(arrStatList.count == 1 &&compamyOne!= Activationcode){
        return false;
    }
    
    return true;
}


/**
 * 根据传递的第二个参数，检查传入的第一个参数，
 * <br>用户要求的公司类参数，是否可以读/写；
 * @param valuepairs - 公司属性值
 * @param bSet true-用户尝试设置这些属性值； false -用户尝试读取这些属性值；
 * @throws OrganizedException - 检验失败（包含不可操作的属性）抛出异常；
 */

+(void)validateCompanyStatList:(NSArray *)valuepairs bset:(BOOL) bSet{
    if(valuepairs == nil){
    
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"公司值为空" userInfo:nil];
        [ce raise];
    
    }
    if(bSet == true){//不允许修改的
        NSString *uniqueStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Name];
        NSString *companyIDStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Activationcode];
        NSString *registrationTimeStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Activationtime];
        NSString *lastLoginTimeStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:uniqueID];
        NSString *currentLoginDeviceIDStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:CurrentPurchaseinfo];
        NSString *ExceptionFunctionListStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:MaxMember];
        NSString *MySaltStr = [COMPANY_STAT_ID getKeyNameForCompanyStatID:Functionlist];
        if([valuepairs  containsObject:uniqueStr]||
           [valuepairs  containsObject:companyIDStr]||
           [valuepairs  containsObject:registrationTimeStr] ||
           [valuepairs  containsObject:lastLoginTimeStr]||
           [valuepairs  containsObject:currentLoginDeviceIDStr]||
           [valuepairs  containsObject:ExceptionFunctionListStr]||
           [valuepairs  containsObject:MySaltStr]
           ){
            
            CodeException *ce =  [[CodeException alloc]initWithName:@"COMPANY_SETINFO_CONTAINSNOTACCESSIBLESTAT" reason:@"不允许修改" userInfo:nil];
            [ce raise];
        }
    }		
}




/**
 * 静态函数 - 利用interface中都支持是isvalid方法，进行对象有效性检测，如果无效则抛出异常
 * @param object 待测的对象
 *
 * @throws OrganizedException 非有效的对象（包括对象规定的参数不符合格式，值超出范围等），抛出异常
 */
+(void)checkValid:(id )object error:(NSString *) errorcode {
    if(object != nil && ![object isValid]){
        CodeException *ce =  [[CodeException alloc]initWithName:errorcode reason:nil userInfo:nil];
        [ce raise];
    }
}

/**
 * 添加管理操作对象
 * @param operation - 管理操作对象
 * @throws OrganizedException 参数错误抛出异常
 */

-(void)addAdminManagementOperation:(AdminManagementOperation *) operation{
    if(operation != nil && [operation isValid]){
        [_m_argmentsmap addEntriesFromDictionary:@{@"ADMINMANAGEMENTOPERATION":[operation toString]}];
    }else{
        CodeException *ce = [[CodeException alloc]initWithName:@"MESSAGE_CREATE_WRONGPARAM" reason:@"AddCompanyBaseInfo - Empty or invalid UserCompanyBase object" userInfo:nil];
        [ce raise];
    }
}



/**
 * 仅供修改密码时使用
 * <br>只有在使用旧密码认证来修改密码的情况下才使用；
 * @param szPassword - 旧密码-进行密码认证；
 * @throws OrganizedException - 无效的格式不正确的旧密码情况下，抛出异常；
 */


-(void)addUserOldPassword:(NSString *)szPassword {
    UserBean *user = [[UserBean alloc]initWithPasswod:szPassword];
    NSString *argsKey = [self getKeyNameForArgument:USER_OLDPASSWORD];
    [_m_argmentsmap addEntriesFromDictionary:@{argsKey:user.m_szPassword}];
//    //做HASH串；
//    szPassword = UserBean.doPasswordHash(szPassword);
//    m_argmentsmap.put(MESSAGE_ARGUMENTS.USER_OLDPASSWORD,
}

/**
 * 查询，获取用户属性时使用。
 * @param arrStatIDs - 需要查询的属性列表
 * @throws OrganizedException 参数为空或者有误抛出异常
 */

-(void)addUserStatKeyList:(NSArray *)arrStatIDs{
    if(arrStatIDs == nil){
    CodeException *ce =  [[CodeException alloc]initWithName:@"MESSAGE_ADDARGUMENT_WRONGPARAM" reason:@"empty " userInfo:nil];
    [ce raise];
       
    }
    if (arrStatIDs.count != 0) {
        NSString *arrStr =  [CommonFunctions functionsFromObjectToJsonString:arrStatIDs];
    NSString *str1 =[self getKeyNameForArgument:USER_STAT_KEYLIST];
        
        [_m_argmentsmap addEntriesFromDictionary:@{str1:arrStr}];
    }
    

}

+(NSArray *)getMESSAGE_ARGUMENTS{
    
    return @[@"ERRORCODE",@"ORGANIZEDCOMPANYBASE",@"USERBEAN",@"ORGANIZEDMEMBER",@"ORGANIZEDCOMPANY",@"ADMINMANAGEMENTOPERATION",@"ADMINMANAGEMENTOPERATIONRESULT",@"FUNCTIONOPERATION",@"FUNCTIONOPERATIONRESULT",@"COMPANY_INFOID",@"USER_INFOID",@"ACTIVATIONCODE_ISADMINCODE",@"LOGIN_HAS_VARCODE",@"USER_SUPERCODE",@"COMPANY_STAT_KEYLIST",@"USER_STAT_KEYLIST",@"INFO_QUERY_KEY",@"USER_ISLOGIN",@"USER_OLDPASSWORD",@"COMPANY_PLANCHANGE",@"PLANCHANGE_EXTENDDAYS",@"DATAQUERY",@"DATAQUERYRESULT",@"USER_ENABLED_FUNC"];
}


@end
