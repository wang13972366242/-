//
//  BaseArgumentList.h
//  Admint
//
//  Created by wang on 2016/11/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ArgumentObject.h"
#import "OrganizedMessage.h"
#import "CodeException.h"
#import "CommonFunctions.h"
#import "DBColumns.h"
#import "OrganizedMember.h"
#import "CompanyFunction.h"

@interface BaseArgumentList : NSObject<NSCoding,ArgumentObject,DBColumns>


/**
 * <br> 含有一个key,value都是String类型的hashmap成员；
 * <br> Key不可以为null或全空白字符串；value可以为null;
 
 */

/** 键值对*/

@property(nonatomic,strong) NSMutableDictionary *m_mapArguments;


/**
 * 只检查Key是否为空。不检查Value
 */

-(instancetype)initWithDictionary:(NSDictionary *)dic keysets:(NSArray *)keysets;
-(BOOL)isValid;

-(instancetype)initWithJson:(NSString *)json;

/**
 * 根据KEY返回参数的value;
 */
-(NSString *) 	__getArgumentValue:(NSString *) szKey;


/**
 * 设置DBColumn对应的键值对；
 *  mpValues
 * @throws OrganizedException
 */

-(void)__setDBColumsStatValue:(NSDictionary *)mpValues;

/**
 * 添加参数 - 类型为Interface DBColumns；
 */

-(void)__addArgumentPair:(NSString *)statid szValue:(NSString *)szValue;


/**
 * 增加参数对 - 键值对；
 */
-(void)__addArgumentPairKey:(NSString *)szKey value:(NSString *) szValue;


/**
 * 添加参数 - 类型为用户自定义类对象；
 */

-(void)__addArgumentObject:( BaseArgumentList *) object;


-(void)__addArgumentObject:(id)classKey szObject:(NSString  *)szObject;


/**
 * 根据ClassKey返回参数的value;
 */
-(id) __getArgumentObject:(id) classKey;

/**
 * 静态方法： 方便快捷的把一系列属性键值对，转化为json对象
 */
+(NSDictionary *)convertHashMapToJSONObject:(NSDictionary *) mpValues;

/**
 * 静态方法： 方便快捷的把一系列属性键值对，转化为
 */
+(NSDictionary *)convertJSONObjectToHashMap:(NSDictionary *)object;

-(BOOL) __hasArgument;

/**
 * 根据key移掉参数对；
 * <br>找不到KEY的情况下，什么也不做；
 *  szKey 用户指定的key;
 */
-(void)__removeArgumentPair:(NSString *)szKey;


/**
 * BaseArgumentList转换为jsonobject
 */
-(NSDictionary *)toJsonObject;



/**
 * 获取遍历的参数的KEY的合集
 */
-(NSArray *) __getArgumentKeySet;

-(OrganizedMember *)getOrganizedMember:(NSString *)member;


/**
 *  按指定的属性列表进行输出JSON；
 */
-(NSDictionary *)toJsonWithArr:(NSArray *)arrkeys;
@end
