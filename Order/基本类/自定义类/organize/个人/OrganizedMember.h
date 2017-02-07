//
//  OrganizedMember.h
//  organizeClass
//
//  Created by wang on 16/9/22.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidContact.h"
#import "NSString+MD5String.h"
#import "USER_STAT_ID.h"

/**
 * 获取USERBEAN占用的属性
 * @return 属性数组
 */

/**
 性别
 */
typedef enum Sex{
    MALE, //男
    FEMALE
}Sex;


@interface OrganizedMember : NSObject

/** 账号*/
@property(nonatomic,strong) NSString *m_szUserAccount;
/** 电话*/
@property(nonatomic,strong) NSString *m_szMobile;
/** 固定电话*/
@property(nonatomic,strong) NSString *m_szLandLine;
/** 邮箱*/
@property(nonatomic,strong) NSString *m_szEmail;
/** 验证类型(模式电话和邮箱)*/
@property(nonatomic,assign) validContact m_validContact;
/** 真是名字 */
@property(nonatomic,strong) NSString *m_szRealName;
/** 性别*/
@property(nonatomic,assign) Sex sex;
/** 员工号*/
@property(nonatomic,strong) NSString *m_szEmployeeNumber;
/** 部门名字*/
@property(nonatomic,strong) NSString *m_szDepartmentName;
/** 职位*/
@property(nonatomic,strong) NSString *m_szJobTitle;
/** 生日*/
@property(nonatomic,strong) NSDate *m_cldBirthday;
/** 工作地点*/
@property(nonatomic,strong) NSString *m_szOfficeAddress;
/** 家庭住址*/
@property(nonatomic,strong) NSString *m_szHomeAddress;
/** 个人描述*/
@property(nonatomic,strong)  NSString *m_szSummary;



/**
 创建对象
 */
-(instancetype)initWithAccount:(NSString *)m_szUserAccount szMobile:(NSString *)szMobile szEmail:(NSString *)szEmail vldct:(validContact)vldct;
-(instancetype)initWith:(NSString*)szMemeberJsonString;
/**
 得到对应的生日字符串
 */
-(NSString *)getUserBirthdayString:(NSDate *)cld;
/**更改设置用户的邮件地址*/
-(void)changeUserEmail:(NSString *)szEmail bIsValidated:(BOOL)bIsValidated;
/**更改设置用户的手机号码*/
-(void)changeUserMobile:(NSString *)szMobile bIsValidated:(BOOL)bIsValidated;
/**设置用户姓名和性别*/
-(void)setUserNameAndSex:(Sex)sex szName:(NSString *)szName;
-(BOOL)isValidAsCompanyMember;
/**判断当前对象是否完整有效*/
-(BOOL)isValid;
-(NSString *)toString;
@end
