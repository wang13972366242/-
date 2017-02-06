//
//  OrganizedDepartment.h
//  Order
//
//  Created by wang on 2016/10/31.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrganizedJobTitle.h"
@interface OrganizedDepartment : NSObject<NSCoding>

/** 部门名称*/
@property(nonatomic,strong) NSString *m_szDepartmentName;
@property(nonatomic,strong) NSMutableArray *m_myJobTitleList;


-(instancetype)initWithDepartName:(NSString *)name array:(NSArray *)jobTitles;
-(instancetype)initWthJson:(NSString *)szIDlist;

-(BOOL)hasJobTitles;
-(NSString *)TestString;

-(NSString *)toString;
/**
 * 添加职位
 * @param jbtobeadd - 职位不能为空，否则会报错
 * @throws OrganizedException
 */
-(void)AddJobTitle:(OrganizedJobTitle *)jbtobeadd;

-(void)AddJobTitleAndName:(NSString *)szTitleName iLevel:(int)iLevel;
/**
 * 删除指定名字的职位;
 *
 */
-(void)removeJobTitle:(NSString *) szTitleName;

-(BOOL)equals:(OrganizedDepartment *)dpt;
-(BOOL)nameIs:(NSString *)szName;

/**
 * 删除指定名字的职位;

 *
 */
-(void)RemoveJobTitle:(NSString *) szTitleName;
@end

