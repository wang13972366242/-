//
//  UserCompanyBase.h
//  organizeClass
//
//  Created by wang on 16/9/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidContact.h"
#import "COMPANY_STAT_ID.h"
@interface UserCompanyBase : NSObject

/** 公司名字*/
@property(nonatomic,strong) NSString *m_szName;
/** 公司电话*/
@property(nonatomic,strong) NSString *m_szMobile;
/** 公司邮箱*/
@property(nonatomic,strong) NSString *m_szEmail;
/** 连接*/
@property(nonatomic,assign) validContact m_ValidContact;

-(instancetype)initWithszName:(NSString *)szName szMobile:(NSString *)szMobile szEmail:(NSString*)szEmail validContact:(validContact)vat;

-(instancetype)initWithJsonString:(NSString*)szUserBeanJsonString;
/**
 * 设置公司的绑定移动电话号码
 */
-(void)baseSetCompanyMobile:(NSString *)szMobile bIsValidated:(BOOL)bIsValidated;

+(instancetype)test;
/**
 * 设置公司的绑定电子邮件地址
 */
-(void)baseSetCompanyEmail:(NSString *)szEmail bIsValidated:(BOOL)bIsValidated;
/**
 * 设置公司的验证情况信息
 
 */
-(void)setM_ValidContact:(validContact)m_ValidContac;
/**
 * 判断公司邮件是否通过验证
 * @return 邮件地址已经验证-true, 未验证通过-false;
 */
-(BOOL)baseIsCompanyEmailVerified;

/**
 * 判断公司手机号是否通过验证
 * @return 手机号已经验证-true, 未验证通过-false;
 */

-(BOOL)baseIsCompanyMobileVerified;

/**
 * 判断公司对象是否为有效对象
 */

-(BOOL)isValid;

/**
 * 判断两个对象是否为同一个抽象公司
 */
-(BOOL)baseCompanyEquals:(UserCompanyBase *)baseinput;
-(NSString *)toString;
-(NSString *)getCompanyStatValue:(COMPANy_STAT_ID)statid;

-(NSMutableDictionary *)toJson;

@end
