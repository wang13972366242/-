//
//  OrganizedCompany.h
//  Order
//
//  Created by wang on 2016/10/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserCompanyBase.h"
#import "UserCompanyBase.h"
#import "JobTitleStructure.h"
@interface OrganizedCompany : UserCompanyBase<NSCoding>




/** 地址数组*/
@property(nonatomic,strong) NSMutableArray *m_vcAddressArr;
/** 座机*/
@property(nonatomic,strong) NSString *m_szStaticPhoneNumber;

/** 公司类型*/
@property(nonatomic,strong) NSString *m_szCompanyType;
/** 公司描述*/
@property(nonatomic,strong) NSString *m_szCompanySummary;
@property(nonatomic,strong) JobTitleStructure *m_JobTitleStructure;
-(instancetype)initWithCompany:(UserCompanyBase *)baseinfo;
-(instancetype)initWithJsonString:(NSString*)szUserBeanJsonString;

/**
 * 获取公司的全部地址，多个地址之间以\t隔开
 */
-(NSString *)userCompanyAddressString;

/**
 * 添加公司的地址信息
 */
-(void)companyaddAddress:(NSString *)addStr;

-(BOOL)isValid;
-(NSString *)toString;
@end

