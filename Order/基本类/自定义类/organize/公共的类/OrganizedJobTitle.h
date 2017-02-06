//
//  OrganizedJobTitle.h
//  Order
//
//  Created by wang on 2016/10/31.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobTitleFunctions.h"
@interface OrganizedJobTitle : NSObject<NSCoding>
/** 职位*/
@property(nonatomic,strong) NSString *m_myTitle;

@property(nonatomic,assign) int m_imyLevel;


-(instancetype)initWithNameAndLevel:(NSString *)szTitleName iLevel:(int)iLevel;
-(instancetype)initWthJson:(NSString *)szJBStr;

/**
 * 判断职位对象是否相同
 */
-(BOOL)equals:(OrganizedJobTitle *)jbtitle;

/**
 * 判断当前职位是否具备指定的名字
 */
-(BOOL)nameIs:(NSString *) szName;
-(NSString *)toString ;

+(NSString *)TestStringForJobTitleArray:(NSArray *)arrJobs;
@end
