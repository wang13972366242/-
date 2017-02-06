//
//  BaseOperation.h
//  Admint
//
//  Created by wang on 2016/11/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"

@interface BaseOperation : BaseArgumentList
/** m_szOperatorAccount*/
@property(nonatomic,strong) NSString *m_szOperatorAccount;

-(instancetype)initWithJsonString:(NSString *)jsonString;
/**
 * 此处在构造对象时，不进行isValid的成员变量检查；
 */
-(instancetype)initWithszAccount:(NSString *)szAccount;
/**
 * 此处在构造对象时，不进行isValid的成员变量检查；
 */
-(instancetype)initWithDic:(NSDictionary *) object;
-(BOOL)isValid;
-(NSMutableDictionary *)  toJsonObject;
@end
