//
//  OrganizedMember.m
//  organizeClass
//
//  Created by wang on 16/9/22.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "OrganizedMember.h"
#import "CommonFunctions.h"
#import "DateCompent.h"
#import "CodeException.h"



@implementation OrganizedMember
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.m_szUserAccount forKey:@"m_szUserAccount"];
    
    [aCoder encodeObject:self.m_szMobile forKey:@"m_szMobile"];
    [aCoder encodeObject:self.m_szLandLine forKey:@"m_szLandLine"];
    [aCoder encodeObject:self.m_szEmail forKey:@"m_szEmail"];
    
    [aCoder encodeObject:@(_m_validContact) forKey:@"m_validContact"];
    /** 真是名字 */
    [aCoder encodeObject:self.m_szRealName forKey:@"m_szRealName"];
    /** 性别*/
    [aCoder encodeObject:@(self.sex) forKey:@"sex"];
    /** 员工号*/
    [aCoder encodeObject:self.m_szEmployeeNumber forKey:@"m_szEmployeeNumber"];
    /** 部门名字*/
    [aCoder encodeObject:self.m_szDepartmentName forKey:@"m_szDepartmentName"];
    /** 职位*/
    [aCoder encodeObject:self.m_szJobTitle forKey:@"m_szJobTitle"];
    /** 生日*/
    [aCoder encodeObject:self.m_cldBirthday forKey:@"m_cldBirthday"];
    /** 工作地点*/
    [aCoder encodeObject:self.m_szOfficeAddress forKey:@"m_szOfficeAddress"];
    /** 家庭住址*/
    [aCoder encodeObject:self.m_szHomeAddress forKey:@"m_szHomeAddress"];
    /** 个人描述*/
    [aCoder encodeObject:self.m_szSummary forKey:@"m_szSummary"];
    
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.m_szUserAccount = [aDecoder decodeObjectForKey:@"m_szUserAccount"];
        self.m_szMobile = [aDecoder decodeObjectForKey:@"m_szMobile"];
         self.m_szLandLine = [aDecoder decodeObjectForKey:@"m_szLandLine"];
        self.m_szEmail = [aDecoder decodeObjectForKey:@"m_szEmail"];
        NSNumber *validC = [NSNumber numberWithInt:_m_validContact];
        validC = [aDecoder decodeObjectForKey:@"m_validContact"];
        /** 真是名字 */
        self.m_szRealName = [aDecoder decodeObjectForKey:@"m_szRealName"];
        /** 性别*/
        NSNumber *sexnumber = [NSNumber numberWithInt:self.sex];
        sexnumber = [aDecoder decodeObjectForKey:@"sex"];
        /** 员工号*/
        self.m_szEmployeeNumber = [aDecoder decodeObjectForKey:@"m_szEmployeeNumber"];
        /** 部门名字*/
        self.m_szDepartmentName = [aDecoder decodeObjectForKey:@"m_szDepartmentName"];
        /** 职位*/
        self.m_szJobTitle = [aDecoder decodeObjectForKey:@"m_szJobTitle"];
        /** 生日*/
        self.m_cldBirthday = [aDecoder decodeObjectForKey:@"m_cldBirthday"];
        /** 工作地点*/
        self.m_szOfficeAddress = [aDecoder decodeObjectForKey:@"m_szOfficeAddress"];
        /** 家庭住址*/
        self.m_szHomeAddress = [aDecoder decodeObjectForKey:@"m_szHomeAddress"];
        /** 个人描述*/
        self.m_szSummary = [aDecoder decodeObjectForKey:@"m_szSummary"];
        
    }
    return self;
}

/**
 * 构造函数 - 非完整，完整有效的用户对象需补全必要的属性信息
 * <pre style='color:blue'>
 * 客户端注册账户，修改账户信息时，对象的初步构造；
 * </pre>
 * @param szAccount - 用户的账户名
 * @param szMobile - 用户的移动电话
 * @param szEmail - 用户的邮件地址
 * @param vldct - 联系方式的验证情况
 */

-(instancetype)initWithAccount:(NSString *)m_szUserAccount szMobile:(NSString *)szMobile szEmail:(NSString *)szEmail vldct:(validContact)vldct{
    
    if (self = [super init]) {
        NSString *str = [NSString stringWithFormat:@"%d",vldct];
        [self setCurrentMemberStatValueWithUSER_STAT_ID:ValidContac ID: str];
        //m_szUserAccount
        [self setCurrentMemberStatValueWithUSER_STAT_ID:UniqueAccount ID:m_szUserAccount];
        //szMobile
        [self setCurrentMemberStatValueWithUSER_STAT_ID:mobile ID:szMobile];
        [self setCurrentMemberStatValueWithUSER_STAT_ID:email ID:szEmail];
    }
    return self;
}

-(instancetype)initWith:(NSString*)szMemeberJsonString{
    
    if (self = [super init]) {
        
        NSDictionary *dic = (NSDictionary *)[CommonFunctions functionsFromJsonStringToObject:szMemeberJsonString];
        NSArray *arr = [dic allKeys];
        for (NSString *str in arr) {
            if (str) {
                [self MemberShuxing:str dic:dic];
            }
        }
    }
    return self;
}


-(void)MemberShuxing:(NSString *)str dic:(NSDictionary*)dic{
    if ([str isEqualToString:@"UniqueAccount"]) {
        _m_szUserAccount = dic[@"UniqueAccount"];
    }else if ([str isEqualToString:@"Mobile"]){
        _m_szMobile = dic[@"Mobile"];
    }else if ([str isEqualToString:@"LandLine"]){
        _m_szLandLine = dic[@"LandLine"];
    }else if ([str isEqualToString:@"Email"]){
        _m_szEmail = dic[@"Email"];
    }else if ([str isEqualToString:@"ValidContact"]){
        _m_validContact = [dic[@"ValidContact"] intValue];
    }else if ([str isEqualToString:@"RealName"]){
        _m_szRealName = dic[@"RealName"];
    }else if ([str isEqualToString:@"Sex"]){
        _sex = [dic[@"Sex"] intValue];
    }else if ([str isEqualToString:@"EmployeeNumber"]){
        _m_szEmployeeNumber = dic[@"EmployeeNumber"];
    }else if ([str isEqualToString:@"Department"]){
        _m_szDepartmentName = dic[@"Department"];
    }else if ([str isEqualToString:@"JobTitle"]){
        _m_szJobTitle = dic[@"JobTitle"];
    }else if ([str isEqualToString:@"Birthday"]){
        
        _m_cldBirthday = dic[@"Birthday"];
    }
    else if ([str isEqualToString:@"OfficeAddress"]){
        _m_szOfficeAddress = dic[@"OfficeAddress"];
    }else if ([str isEqualToString:@"HomeAddress"]){
        _m_szHomeAddress = dic[@"HomeAddress"];
    }else if ([str isEqualToString:@"Summary"]){
        _m_szSummary = dic[@"Summary"];
    }
}


#warning -mark  NSCalendar转化成字符串
-(NSString *)getUserBirthdayString:(NSCalendar *)cld{
    
    return nil;
}

/**
 * 更改设置用户的邮件地址
 * @param szEmail - 邮件地址
 * @param bIsValidated - 是否已经通过验证
 * @throws OrganizedException - 参数不合格；
 */
-(void)changeUserEmail:(NSString *)szEmail bIsValidated:(BOOL)bIsValidated{
    [self setCurrentMemberStatValueWithUSER_STAT_ID:email ID:szEmail];
    if(bIsValidated){
        _m_validContact = [ValidContact addEmailContact:_m_validContact];
    }else{
        _m_validContact = [ValidContact deleteEmailContact:_m_validContact];
    }
}
/**
 * 设置更改用户的手机号
 * @param szMobile	- 手机号
 * @param bIsValidated - 是否通过验证
 * @throws OrganizedException - 输入号码无效，抛出异常；
 */
-(void)changeUserMobile:(NSString *)szMobile bIsValidated:(BOOL)bIsValidated{
    [self setCurrentMemberStatValueWithUSER_STAT_ID:mobile ID:szMobile];
    if(bIsValidated){
        _m_validContact = [ValidContact addMobileContact:_m_validContact];
    }else{
        _m_validContact = [ValidContact deleteMobileContact:_m_validContact];
    }
}

/**
 * 设置用户座机
 * @param szLandLine - 座机号
 * @throws OrganizedException - 输入参数无效时跳出异常；
 */
-(void )setM_szLandLine:(NSString *)m_szLandLine{
    
    [self setCurrentMemberStatValueWithUSER_STAT_ID:LandLine ID:m_szLandLine];
}

/**
 * 设置绑定号码验证情况
 * @param vldct - {@linkplain ValidContact}
 * @throws OrganizedException - 无效的验证值时，抛出异常；
 */

-(void)setM_validContact:(validContact)m_validContact{
    if (!m_validContact || m_validContact == CONTACT_NONE ) {
        NSLog(@"无效的验证");
    }
    _m_validContact =m_validContact;
    
    
    
}

/**
 * 设置或更改用户真实姓名
 * @param szName - 真实姓名
 * @throws OrganizedException - 姓名格式有误时抛出异常；
 */
-(void)setM_szRealName:(NSString *)m_szRealName{
    [self setCurrentMemberStatValueWithUSER_STAT_ID:RealName ID:m_szRealName];
}
/**
 * 设置用户性别
 * @param sx - {@linkplain Sex}
 * @throws OrganizedException - 性别为空，抛出异常
 */

-(void)setUserNameAndSex:(Sex)sex szName:(NSString *)szName{
    self.sex = sex;
    self.m_szRealName = szName;
}
/**
 * 设置用户的工号
 * @param szEmployeeNumber - 用户工号
 * @throws OrganizedException - 无效的工号信息会跳出异常；
 */

-(void)setM_szDepartmentName:(NSString *)m_szDepartmentName{
    [self setCurrentMemberStatValueWithUSER_STAT_ID:Department ID:m_szDepartmentName];
    
}
-(void)setM_szJobTitle:(NSString *)m_szJobTitle{
    [self setCurrentMemberStatValueWithUSER_STAT_ID:JobTitle ID:m_szJobTitle];
    
}

-(void)setM_szOfficeAddress:(NSString *)m_szOfficeAddress{
    
    [self setCurrentMemberStatValueWithUSER_STAT_ID:OfficeAddress ID:m_szOfficeAddress];
}
-(void)setM_szHomeAddress:(NSString *)m_szHomeAddress{
    
    [self setCurrentMemberStatValueWithUSER_STAT_ID:HomeAddress ID:m_szHomeAddress];
}


-(void)setM_szSummary:(NSString *)m_szSummary{
    
    [self setCurrentMemberStatValueWithUSER_STAT_ID:summary ID:m_szSummary];
    
}

/**
 * 判断当前对象是否完整有效
 * <pre style="color:blue">
 * - 检查必须非空属性是否都有值，非空属性包括：
 * <i style="color:green">-用户名
 * -邮件地址
 * -移动电话
 * -真实姓名
 * -性别
 * -生日
 * -工号
 * -所属部门
 * -所在职位
 * </i>
 * </pre>
 * @return true if valid,else false;
 */
-(BOOL)isValidAsCompanyMember{
    if(![self isValid]) return false;
    NSArray *arrTocheck = @[_m_szEmployeeNumber,_m_szDepartmentName,_m_szJobTitle];
    if(![CommonFunctions functionsIsArrayValid:arrTocheck]) return false;
    return true;
}
/**
 * 判断当前对象作为非公司对象是否完整有效
 * <pre style="color:blue">
 * - 检查必须非空属性是否都有值，非空属性包括：
 * <i style="color:green">-用户名
 * -邮件地址
 * -移动电话
 * -真实姓名
 * -性别
 * -生日
 * </i>
 * </pre>
 * @return true if valid,else false;
 */

-(BOOL)isValid{
    
    if(![self _isBasicInfoComplete]){
        return false;
    }
    
    if(  _m_cldBirthday == nil){
        return false;
    }
    return true;
    
    
}


-(NSString *)_getMD5Password:(NSString *)szPassword{
    return [NSString md5StringBest:szPassword];
}

/**
 *  获取属性值(根据枚举)
 *
 *  @param statid 枚举
 *  @param szValue id字符串或者对象
 */
-(void)setCurrentMemberStatValueWithUSER_STAT_ID:(USE_STAT_ID)statid ID:(NSString *)szValue{

    
   
    switch (statid) {
        case UniqueAccount:
        {
            [szValue lowercaseString];
//            if([CommonFunctions functionsIsValidUserName:szValue])
            if(szValue){
                _m_szUserAccount = szValue;
            }else{
                [self invalidPamas];
            }
        }
            break;
        case RealName:
            _m_szRealName = szValue;
            break;
        case LandLine:
//            if([CommonFunctions f:szValue]){
//                _m_szLandLine = szValue;
//            }else{
//                [self invalidPamas];
//            }
            _m_szLandLine = szValue;

            break;
        case mobile:
            if([CommonFunctions functionsIsMobile:szValue]){
                _m_szMobile = szValue;
            }else{
                [self invalidPamas];
            }
            break;
        case email://转小写。
            [szValue lowercaseString];
            if([CommonFunctions functionsIsValidEmail:szValue]){
                _m_szEmail = szValue;
            }else{
                [self invalidPamas];
            }
            break;
        case EmployeeNumber:
            _m_szEmployeeNumber = szValue;
            break;
            
        case Department:
            _m_szDepartmentName = szValue;
            break;
        case JobTitle:
            _m_szJobTitle = szValue;
            break;
        case Birthday:{
//            NSCalendar *cldbirth = [CommonFunctions functionsdateTimeStringToCalendar:szValue];
        }
            
            break;
        case OfficeAddress:
            _m_szOfficeAddress = szValue;
            break;
        case HomeAddress:
            _m_szHomeAddress	= szValue;
            break;
        case summary:
            _m_szSummary	= szValue;
            break;
        case sex:
            _sex = [szValue intValue];
            break;
        case ValidContac:
            _m_validContact = [szValue intValue];
            break;
        default:
            break;
    }
    
    
}
/**
 * 判断基本信息是否完整；
 * <br>基本信息包括:
 * <br>-用户名
 * <br>-邮件地址
 * <br>-移动电话
 * @return  true if info is complete, else false;
 */
-(BOOL)_isBasicInfoComplete{
    NSArray *arrInput = @[self.m_szUserAccount,self.m_szMobile,self.m_szEmail];
    for (NSString *str in arrInput) {
        if (![CommonFunctions functionsIsStringValidAfterTrim:str]) {
            return false;
        }
    }
    return true;
}


-(void)invalidPamas{
    
    NSString *reasonStr = @"CompanyMember?Set Error:Invalid";
    [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:reasonStr];
    
}


-(NSString *)toString{
    @try {
        NSDictionary *dic = [self toJson];
        return [CommonFunctions functionsFromObjectToJsonString :dic];
    } @catch (NSException *exception) {
        NSLog(@"NSException(Name:ARGUMENT_CONVERTION_ERROR -- reason:%@)",exception);
    } @finally {
    }
    
}

-(NSDictionary *)toJson{
    if (![self isValid]) {
        NSString *szMore = @"toJsonObject(): Not a valid member";
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:szMore];
    }
    NSArray *arr =[USER_STAT_ID getClientMemberStatList];
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    for(NSNumber *num in arr){
        int i = [num  intValue];
        USE_STAT_ID uid = [USER_STAT_ID getEnumFormInt:i];
        NSString *szValue = [self getCurrentMemberStatValue:uid];
        
        if([CommonFunctions functionsIsStringValid:szValue])
        {
            NSString *str = [USER_STAT_ID getKeyNameForCompanyStatID:uid];
            [muDic addEntriesFromDictionary:@{str:szValue}];
            
        }
    }
    
    if(muDic.count == 0){
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:@"OrganizedMember toJsonObject():Empty Object"];
    }
    return muDic;
}


/**
 * 获取当前用户的属性对应值
 * @param statid - 指定属性
 * @return 属性对应的值- 若当前属性并无对应值，则返回null;
 */

-(NSString *)getCurrentMemberStatValue:(USE_STAT_ID)statid{
    NSString *szResult = nil;

    switch (statid) {
        case UniqueAccount:
            szResult = _m_szUserAccount;
            break;
        case RealName:
            szResult = _m_szRealName;
            break;
        case mobile:
            szResult = _m_szMobile;
            break;
        case LandLine:
            szResult = self.m_szLandLine;
            break;
        case email:
            szResult = self.m_szEmail;
            break;
        case EmployeeNumber:
            szResult = self.m_szEmployeeNumber;
            break;
        case Department:
            szResult = self.m_szDepartmentName;
            break;
        case JobTitle:
            szResult = _m_szJobTitle;
            break;
        case Birthday:
//        szResult = [CommonFunctions functionscalendarToDateTimeString:_m_cldBirthday];
            break;
        case OfficeAddress:
            szResult = _m_szOfficeAddress;
            break;
        case HomeAddress:
            szResult = _m_szHomeAddress;
            break;
        case summary:
            szResult = _m_szSummary;
            break;
        case sex:
        szResult = [self formSexEnumString:_sex];
            break;
        case ValidContac:
            szResult = [ValidContact getStringFormEnum:_m_validContact];
            break;
        default:
            break;
    }
    return szResult;
}



-(NSString *)formSexEnumString:(Sex)sex{
    if (sex== MALE) {
    return @"MALE";
    }else if (sex== FEMALE){
    return @"FEMALE";
    
    }
    return nil;

}
@end
