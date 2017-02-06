//
//  CodeException.m
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CodeException.h"

@implementation CodeException

int m_Code = 0;

static  NSMutableArray *arrCode;

+(void)arrCode{
    if (arrCode == nil) {
        NSArray *arr = @[@(10000),@(10001),@(10002),@(10003),@(10004),@(10005),@(10006),@(10007),@(10008),@(10009),@(10010),@(10011),@(10012),@(10013),@(10014),@(10015),@(10020),@(10021),@(10020),@(10021),@(10022),@(10023),@(10024),@(10025),@(10026),@(10030),@(10031),@(10032),@(10033),@(10034),@(10035),@(10036),@(10050),@(10051),@(10052),@(10053),@(10100),@(20000),@(20001),@(20002),@(20003),@(20004),@(20005),@(20006),@(20007),@(20008),@(20009),@(20010),@(20011),@(20012),@(20013),@(20014),@(20015),@(20016),@(20017),@(20100),@(30000),@(30001),@(30002),@(30003),@(30004),@(30005),@(30006),@(30100),@(40000),@(40001),@(40002),@(40003),@(50000),@(50001),@(50002),@(50003),@(50004),@(60000),@(60001),@(60002),@(60003),@(60004),@(60005),@(60006),@(60007),@(60008),@(60009)];
        arrCode = [NSMutableArray arrayWithArray:arr];
    }
    
}


-(void)OrganizedErrorCode:(int)iCode{
    
    m_Code = iCode;
}

/**
 * 返回错误代码的int形式
 * @return error code integer
 */
-(int)getCodeID{
    return m_Code;
}

/**
 * 返回错误代码的string形式
 * @return error code integer(converted to string)
 */
-(NSString *)getCodeIDString{
    
    return [NSString stringWithFormat:@"%d",m_Code ];
}



/**
 * 根据错误代码和附加信息构造一个项目异常类
 * @param code - 错误代码
 * @param szAdditional - 附加信息
 */

-(instancetype)initWithName:(NSExceptionName)aName reason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo{
    if (self = [super initWithName:aName reason:aReason userInfo:aUserInfo]) {
        _m_enumcode = [aName intValue];
        _m_szAdditional  = aReason;
    }
    return self;
}

/**
 * 添加附加debug信息
 * @param addition - 附加信息内容
 */
-(void)addAdditionalString:(NSString *)addition{
    
    NSString *str =  _m_szAdditional;
    NSString *formatStr = @"?:";
    NSString *str1 =  [formatStr stringByAppendingString:addition];
    _m_szAdditional = [str stringByAppendingString:str1];
    
}


+(NSString *)getStringFormEnum:(OrganizedErrorCode)ID{
    NSArray *arr=  [self getEnum];
  return  [self getNewIndex:ID arr:arr];
}

+(NSString *)getNewIndex:(int)ID arr:(NSArray *)arrEnum{
    if ( ID>=10000 &&ID<=10015) {
        NSArray *arr = arrEnum[0];
        return  [arr objectAtIndex:ID -10000];
    }else if (ID>=10020 &&ID<=10026){
        NSArray *arr = arrEnum[1];
        return  [arr objectAtIndex:ID -10020];
    }else if (ID>=10030 &&ID<=10036){
        NSArray *arr = arrEnum[2];
        return  [arr objectAtIndex:ID -10030];
    }else if (ID>=10050 &&ID<=10100){
        NSArray *arr = arrEnum[3];
        if (ID<10100) {
        return  [arr objectAtIndex:ID -10050];
        }else{
        return  [arr lastObject];
        }
        
    }else if (ID>=20000 &&ID<=20100){
        NSArray *arr = arrEnum[4];
        if (ID<20100) {
            return  [arr objectAtIndex:ID -20000];
        }else{
            return  [arr lastObject];
        }
    }else if (ID>=30000 &&ID<=30100){
        NSArray *arr = arrEnum[5];
        if (ID<30100) {
            return  [arr objectAtIndex:ID -30000];
        }else{
            return  [arr lastObject];
        }
    }else if (ID>=40000 &&ID<=40003){
        NSArray *arr = arrEnum[6];
        return  [arr objectAtIndex:ID -40000];
    }else if (ID>=50000 &&ID<=50004){
        NSArray *arr = arrEnum[7];
        return  [arr objectAtIndex:ID -50000];
    }else{
    
     NSArray *arr = arrEnum[8];
        return  [arr objectAtIndex:ID - 60000];
    
    }
    
    

}
+(NSArray *)getEnum{
    NSArray *arr1 = @[@"USER_LOGIN_WRONGPARAM",@"USER_LOGIN_NOSUCHUSER",@"USER_LOGIN_WRONGPASSWORD",@"USER_LOGIN_DATABASEERROR",@"USER_LOGIN_WRONGPASSWORDFORMAT",@"USER_LOGIN_WRONGDEVICEID",@"USER_LOGIN_NOVARCODEFLAG",@"USER_LOGIN_DEVICECONFLICT",@"USER_LOGINTABLE_NOUSERTOUPDATE",@"USER_LOGOUT_WRONGPARAM",@"USER_LOGOUT_NOSUCHUSER",@"USER_LOGOUT_WRONGPASSWORD",@"USER_LOGOUT_WRONGDEVICE",@"USER_LOGOUT_WRONGSESSION",@"USER_LOGOUT_USERNOTLOGIN",@"USER_LOGOUT_USERDNOTINSESSIONTABLE"];
    NSArray *arr2 = @[@"USER_CREATE_WRONGPARAM",@"USER_CREATE_ALREADYEXIST",@"USER_CREATE_DUPLICATEDNAME",@"USER_CREATE_DUPLICATEDEMAIL",@"USER_CREATE_DUPLICATEDMOBILE",@"USER_CREATE_DUPLICATEDEMPLOYEENUMBER",@"USER_CREATE_DATABASEERROR"];
    NSArray *arr3 = @[@"USER_STATS_SETERROR",@"USER_SYNCDB_FAIL",@"USER_QUERY_NOTEXIST",@"USER_QUERY_DATAERROR",@"USER_ARUMENTS_INITERROR",@"USER_ADMINASSIGN_ARGUMENTSERROR",@"USER_REMOVEDB_FAIL"];
    NSArray *arr4 = @[@"USER_ACTIVATION_CODETYPEMISMATCH",@"USER_ACTIVATION_COMPANYNOTACTIVATED",@"USER_ACTIVATION_REACHEDLIMITEDSIZE",@"USER_ACTIVATIONCODE_NOTVALID",@"USER_UNKNOWN_ERROR"];
    NSArray *arr5 = @[@"COMPANY_CREATE_WRONGPARAM",@"COMPANY_CREATE_ALREADYEXIST",@"COMPANY_CREATE_DUPLICATEDNAME",@"COMPANY_CREATE_DUPLICATEDEMAIL",@"COMPANY_CREATE_DUPLICATEDMOBILE",@"COMPANY_CREATE_DATABASEERROR",@"COMPANY_QUERY_NOTEXIST",@"COMPANY_QUERY_DATAERROR",@"COMPANY_ACTIVATIONCODE_CREATERROR",@"COMPANY_SYNCDB_FAIL",@"COMPANY_REMOVEDB_FAIL",@"COMPANY_ACTIVATION_CODETYPEMISMATCH",@"COMPANY_ARUMENTS_INITERROR",@"COMPANY_ACTIVATIONCODE_ALREADYEXIST",@"COMPANY_ACTIVATION_ALREADYDONE",@"COMPANY_ACTIVATION_BASEINFOMISMATCH",@"COMPANY_BUYCODE_EMPTYPAYMENT",@"COMPANY_ACTIVATIONCODE_NOTVALID",@"COMPANY_UNKNOWN_ERROR"];
    NSArray *arr6 = @[@"MESSAGE_CREATE_WRONGPARAM",@"MESSAGE_INCOMINGCLIENT_WRONGPARAM",@"MESSAGE_ADDARGUMENT_WRONGPARAM",@"MESSAGE_ENCRYPTION_ERROR",@"MESSAGE_DECRYPTION_ERROR",@"MESSAGE_EMAIL_INITERROR",@"MESSAGE_EMAIL_SENDERROR",@"MESSAGE_UNKNOWN_ERROR"];
    NSArray *arr7 = @[@"ARGUMENT_CONVERTION_ERROR",@"ARGUMENT_EMPTY_ERROR",@"ARGUMENT_SET_ERROR",@"ARGUMENT_OUTOFVALIDRANGE"];
    NSArray *arr8 = @[@"DATABASE_INIT_ERROR",@"DATABASE_CREATETABLE_ERROR",@"DATABASE_EXECUTECMD_EMPTYCMD",@"DATABASE_EXECUTECMD_FAIL",@"DATABASE_QUERYSINGLEENTRY_NOTUNIQUEKEY"];
    NSArray *arr9 = @[@"VARCODE_ERROR",@"ACTVARCODE_ERROR",@"EMAILVARCODE_ERROR",@"MOBILEVARCODE_ERROR",@"COMPANYCHECKEMAIL_ARGUMENT_ERROR",@"COMPANYCHECKMOBILE_ARGUMENT_ERROR",@"USERCHECKEMAIL_ARGUMENT_ERROR",@"USERCHECKMOBILE_ARGUMENT_ERROR",@"ACTIVATIONCODE_NOTVALID",@"CHECKACCOUNTNAME_ARGUMENT_ERROR"];

    
    return@[arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8,arr9];
}

@end
