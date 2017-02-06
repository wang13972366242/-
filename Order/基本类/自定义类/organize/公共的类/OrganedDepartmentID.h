//
//  OrganedDepartmentID.h
//  Order
//
//  Created by wang on 2016/10/31.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobTitleFunctions.h"
@interface OrganedDepartmentID : NSObject<NSCoding,NSCopying>

/** 部门ID数组*/
@property(nonatomic,strong) NSMutableArray *m_arrayLevels;

-(instancetype)initWith:(NSMutableArray *)arrLevels;
-(instancetype)initWithCopyDepartmentID:(OrganedDepartmentID *)departid;
-(instancetype)initWthJson:(NSString *)szIDlist;
-(instancetype)initWithNewDepartIDNewLevel:(int)iNewLevel;

-(int)getIDAt:(int)iIndex;
-(void)setIDAt:(int)iIndex iValue:(int)iValue;
/**
 *  获取上一级部分的ID
 */
-(OrganedDepartmentID*)getParentLevelID;
/**
 *  2个类是否同一个
 */
-(BOOL)isChildOf:(OrganedDepartmentID *)idParent;
/**
 *  部门ID是否一样
 *
 */
-(BOOL)equals:(OrganedDepartmentID *)idinput;
/**
 * 针对职位框架中的职位后移出现的情况，把最后一位ID向前移动；
 */
-(void)moveAhead:(int)iDelSrcLevel;


-(BOOL)isRelatedDepartID:(OrganedDepartmentID *) idcompare;
-(int)compareTo:(OrganedDepartmentID *)id2;
-(NSString *)toString;
-(int)getLevelCount;
-(void)AddLevel:(int)iNewLevel ;
@end
