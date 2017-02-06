//
//  CompanyFunction.h
//  organizeClass
//
//  Created by wang on 16/9/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum FunctionID{
    ERR_FUNC_INVALID,  //标注错误值:
    FUNC_WORK_ATTENDENCE, //考勤管理
    FUNC_INVENTORY_MANAGE,//物品管理
    FUNC_WORK_REPORT, //工作报告
    FUNC_WORK_PERFORMAGIC,//工作绩效考评
    FUNC_USER_REQUEST,//用户管理单
     FUNC_TASK_MANAGEMENT//工作任务管理：
}FunctionID;

@interface CompanyFunction : NSObject<NSCoding>

/** 功能ID*/
@property(nonatomic,assign) FunctionID m_FunctionID;
/** 时间*/
@property(nonatomic,strong) NSDate *m_ActivatedTime;
/** 购买时间*/
@property(nonatomic,assign) int m_iPurchasedDayCount;

/** 构造函数
 * @param fcid	- 功能ID（{@linkplain FunctionID})
 * @param cldactivatetime - 激活时间（Calendar对象）
 * @param idaycount - 功能套餐时长
 */
-(instancetype)initWithFunctionID:(FunctionID)fcid Calendar:(NSDate *)cldactivatetime daycount:(int)idaycount;
-(instancetype)initWithFunctionID:(FunctionID)fcid  daycount:(int)idaycount;
/**
 * 根据所需功能进行价格计算；
 */

+(CGFloat )getTheTotalPriceWithFunctionArr:(NSArray *)functionArr;
-(NSString *)toString;
-(BOOL)isExpired;
+(instancetype)test:(FunctionID)ID;
/**
 * 计算价格
 */
-(CGFloat)calculatePrice;

/**
 * 判断整个功能列表数组是否有效
 */
+(BOOL)isFunctionListValid:(NSArray*)functions bCheckExpired:(BOOL)bCheckExpired;
/**
 * 激活时使用，更新整个功能列表的激活时间。
 */
-(void)updateFunctionListActivationTime:(NSArray*)arrCompanyFunc clrtime:(NSDate*)clrtime;
/**CompanyFunction数组转换为String
 */

+(NSString *)functionArrayToString:(NSArray*)arrCompanyFunc;
/**
 * 免费激活码对应的功能套餐 - 天数可指定 - For Test
 */
+(NSArray *)getInstanceOfTrialFullFunctionList:(int)iDayLen;


/**符合格式的String转换为CompanyFunction数组
 */
+(NSArray *)stringToFunctionArray:(NSString *) szFuncList;

+(FunctionID)getEnumFormStr:(NSString *)str;

+(NSString *)getStringFormEnum:(FunctionID)ID;
@end
