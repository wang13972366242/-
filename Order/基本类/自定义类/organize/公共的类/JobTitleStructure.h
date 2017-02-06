//
//  JobTitleStructure.h
//  Order
//
//  Created by wang on 2016/10/25.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrganedDepartmentID.h"
@class OrganizedJobTitle;
@class OrganizedDepartment;

@interface JobTitleStructure : NSObject<NSCoding>


@property(nonatomic,strong) NSMutableArray *m_rootJobTitles;

@property(nonatomic,strong) NSMutableDictionary *m_hashDepartments;

-(instancetype)initWithJbold:(JobTitleStructure *)jbold;
-(instancetype)initWithJsonString:(NSString*)szInputString;
+ (JobTitleStructure *)sharedJobTitleStructure;
/**
 * 添加部门 - 支持添加根级部门
 */

-(void)addDepartment:(NSString *)szNewDepartmentName szParentDepartment:(NSString*)szParentDepartment;

/**
 * 添加根级部门
 */

-(void)addDepartment:(NSString *)szNewDepartmentName;
/**
 * 删除指定部
 */
-(void)removeDepartment:(NSString *) szDepartmentName;


/**
 * 添加根级职位
 * @param jbtitle - 职位对象
 */

-(void)addRootJobTitle:(OrganizedJobTitle *) jbtitle;


/**
 * 给指定的部门重命名
 */
-(void)renameDepartment:(NSString *)szCurrentName newStr:(NSString *) szNewName;
/**按名字删除部门职位
 *
 * @param szJobTitle  - 职位名字
 * @param szDepartment - 指定职位所属部门<br>
 * 部门为空则删除根级职位, 等同于{@link #removeJobTitle(String szJobTitleName)}
 * @throws OrganizedException - <br>部分非null时，找不到指定部门，抛出异常
 * <br>找不到要删除的职位，抛出异常
 */

-(void)removeJobTitle:(NSString *) szJobTitle departName:( NSString *) szDepartment;

/**
 * 按名字删除根部门的职位
 */
-(void)removeJobTitle:(NSString *) szJobTitleName;
/**
 * 添加根级职位
 * @param szJobName - 职位名字
 */

-(void)addRootJobTitle:(NSString *)szJobName  iLevel:(int) iLevel;
/**
 * 为指定部门添加新职位 - 支持添加根级职位

 */

-(void)addJobTitle:(OrganizedJobTitle *)jbtitle szDepartment:(NSString *) szDepartment;

-(NSString *)testObjec;
/**
 * 添加职位 - 支持根级和指定部门
 *
 */

-(void)addJobTitle:(NSString *)szJobTitle iJobLevel:(int) iJobLevel szDepartment:(NSString *) szDepartment;

-(NSString *)toString;


-(NSMutableArray *)getJobtitle;
@end
