//
//  BWNetWorkToll.h
//  BWNews
//
//  Created by DuYang on 16/3/1.
//  Copyright © 2016年 DuYang. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "OrganizedParams.h"
@interface BWNetWorkToll : AFHTTPSessionManager
//含有基础url ==》BaseURL
+(instancetype)shareNetWorkTool;

//不含有基础URL
+(instancetype)shareNetWorkToolWithoutBaseURL;


//网络请求
+(void )AFNetWorkingPostWithUrlStr:(NSString*)urlStr params:(NSDictionary *)params viewC:(UIViewController *)viewC backBlack:( void(^)(NSDictionary *headerDic,NSString *bodyStr,NSDictionary *cookies))backBlock;

//邮箱验证的网络请求
+(void)AFNetCheck:(NSDictionary *)mudic verWay:(CheckType)verWay viewController:(UIViewController *)VC emialOrMobile:(NSString *)emialOrMobile;

@end
