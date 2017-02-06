//
//  DeviceUniqueID.h
//  organizeClass
//
//  Created by wang on 16/9/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUniqueID : NSObject<NSCoding,NSCopying>

@property(nonatomic,strong) NSString *m_szOS;
@property(nonatomic,strong) NSString *m_szIP;
@property(nonatomic,strong) NSString *m_szMacAddress;
@property(nonatomic,strong) NSString *m_szHostName;

-(instancetype)initWithIP:(NSString *)szIP szMac:(NSString *)szMac szOS:(NSString *)szOS szHostName:(NSString *)szHostName;

/**
 * 从JSONString解析时的构造函数
 */

-(instancetype)initDeviceWithJson:(NSString *)json;
/**
 * 测试用函数 - 格式化显示DeviceuniqueID的内容信息
 */

-(NSDictionary *)testObjectString;
-(BOOL)isValid;


-(NSString *)toString;
@end
