//
//  SecurityUtil.h
//  AESAddBase64
//
//  Created by wang on 16/9/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

/**
 *  加密
 *
 *  @param 需要加密的字符串
 *  @param key(隐藏)
 */
+(NSString*)encryptAESDataToBase64:(NSString*)string;
+(NSString*)encryptAESDataToBase64AndKey:(NSString*)string key:(NSString*)key;
/**
 *  解密
 *
 *  @param 需要解密的字符串
 *  @param key(隐藏)
 */
+(NSString*)decryptAESStringFromBase64:(NSString *)string;
+(NSString*)decryptAESStringFromBase64AndKey:(NSString *)string key:(NSString *)key;
@end
