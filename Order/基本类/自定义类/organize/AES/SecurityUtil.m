//
//  SecurityUtil.m
//  AESAddBase64
//
//  Created by wang on 16/9/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SecurityUtil.h"
#import "NSData+AES.h"
#import "GTMBase64.h"

#define KEY @"Qilikeji_2016_cipher0829"
@implementation SecurityUtil
/**
 *  加密
 *
 *  @param 需要加密的字符串
 *  @param key(隐藏)
 */
+(NSString*)encryptAESDataToBase64:(NSString*)string
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES128EncryptWithKey:KEY];
    return [GTMBase64 stringByEncodingData:encryptedData];
}

+(NSString*)encryptAESDataToBase64AndKey:(NSString*)string key:(NSString*)key{

    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES128EncryptWithKey:key];
    return [GTMBase64 stringByEncodingData:encryptedData];

}
/**
 *  解密
 *
 *  @param 需要解密的字符串
 *  @param key(隐藏)
 */

+(NSString*)decryptAESStringFromBase64:(NSString *)string{
    
    
    NSData *EncryptData = [GTMBase64 decodeString:string]; //解密前进行GTMBase64编码
    //使用密码对data进行解密
    NSData *decryData = [EncryptData AES128DecryptWithKey:KEY];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}
+(NSString*)decryptAESStringFromBase64AndKey:(NSString *)string key:(NSString *)key{
    
    NSData *EncryptData = [GTMBase64 decodeString:string]; //解密前进行GTMBase64编码
    //使用密码对data进行解密
    NSData *decryData = [EncryptData AES128DecryptWithKey:key];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;


}
@end
