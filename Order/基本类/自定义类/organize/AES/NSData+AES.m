//
//  NSData+AES.h
//  Smile
//
//  Created by 蒲晓涛 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

#define gIv          @"0000000000000000" //可以自行修改
#define KEY @"Qilikeji_2016_cipher0829"

@implementation NSData (Encryption)


//(key和iv向量这里是16位的) 这里是CBC加密模式，安全性更高

- (NSData *)AES128EncryptWithKey:(NSString *)key {//加密
    
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCKeySizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    //==============================for debug only================
    
    char keyPtr[kCCKeySizeAES128+1];
    /**"P\x02\373\312\323\x7f"*/
    bzero(keyPtr, sizeof(keyPtr));//结构体初始化到零
    [self MD5AESkey :key keyPtr:keyPtr];
    
    char ivPtr[kCCKeySizeAES128+1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
 
    
    CCCryptorStatus cryptStatus = CCCrypt(
                                                  kCCEncrypt,
                                                  kCCAlgorithmAES128,
                                                  kCCOptionPKCS7Padding,
                                                  keyPtr,
                                                  kCCKeySizeAES128,
                                                  ivPtr,
                                                   [ self bytes],
                                                   [self length],                                     buffer,                                      bufferSize,                               &numBytesEncrypted
                                                  );
    
    if (cryptStatus == kCCSuccess){
                    NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
                    return data;
                }
    
     //==============================for debug only================
    
//    CCCryptorRef myCryptor = [self GetAESCryptor: key :YES];
//    
//    if (myCryptor != nil) {
//        CCCryptorStatus cryptStatus1 = CCCryptorUpdate(
//                                                       myCryptor,
//                                                       [self bytes],
//                                                       [self length],
//                                                       buffer,
//                                                       bufferSize,
//                                                       &numBytesEncrypted
//                                                       );
//    
//  
//    if (cryptStatus1 == kCCSuccess){
//        
//        size_t iSize = CCCryptorGetOutputLength(myCryptor,                                              [self length],true);
//        
//        cryptStatus1 = CCCryptorFinal(
//        myCryptor,
//                                      buffer,
//                                      bufferSize,
//                                      &numBytesEncrypted
//        );
//        
//        
//        if (cryptStatus1 == kCCSuccess){
//            NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//            return data;
//        }
//    }
//    }
    
    free(buffer);
    return nil;
    
}



- (NSString*)testAESEncrytionandDecrytion:(NSString *)key{
    NSData* afterencryption = [self AES128EncryptWithKey:key];
    NSData* afterdecryption = [afterencryption AES128DecryptWithKey:key];
    NSString *str = [[NSString alloc]initWithData:afterdecryption encoding:NSUTF8StringEncoding];
    return str;
    
}


- (NSData*)AES128DecryptWithKey:(NSString *)key {//解密
   

    /*aYKMUjfSYwDR+uQ9EMv0zmZTZHoiaZf1J/r9hTmqYxQ8t0qQulrm1JwLUvmxYsNXNbydE/2y9xG/iBTL3fzIDSV7TkhO67f+hQyFmhrv4TY=
     */
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCKeySizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted  = 0;
    
    
    
    //==============================for debug only================
    
    char keyPtr[kCCKeySizeAES128+1];
    /**"P\x02\373\312\323\x7f"*/
    bzero(keyPtr, sizeof(keyPtr));//结构体初始化到零
    [self MD5AESkey :key keyPtr:keyPtr];
    
    char ivPtr[kCCKeySizeAES128+1];
    
    memset(ivPtr, 0, sizeof(ivPtr));
    
    
    CCCryptorStatus cryptStatus = CCCrypt(
                                          kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          [ self bytes],
                                          [self length],                                     buffer,                                      bufferSize,                               &numBytesEncrypted
                                          );
    
    if (cryptStatus == kCCSuccess){
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return data;
    }

//
//    CCCryptorRef myCryptor = [self GetAESCryptor: key :NO];
//
//    if (myCryptor != nil) {
//        CCCryptorStatus cryptStatus1 = CCCryptorUpdate(
//        myCryptor,
//                                                       [self bytes],
//                                                       [self length],
//                                                       buffer,
//                                                       bufferSize,
//                                                       &numBytesEncrypted
//        );
//        
//        if (cryptStatus1 == kCCSuccess){
//            cryptStatus1 = CCCryptorFinal(
//                                          myCryptor,
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesEncrypted
//                                          );
//        
//            if (cryptStatus1 == kCCSuccess){
//                NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//                return data;
//            }
//        }
//    }
//
    
    free(buffer);
    return nil;
    
}

-(CCCryptorRef) GetAESCryptor: (NSString *)key : (BOOL)bEncrytion{
    char keyPtr[kCCKeySizeAES128+1];
    /**"P\x02\373\312\323\x7f"*/
    bzero(keyPtr, sizeof(keyPtr));//结构体初始化到零
    [self MD5AESkey :key keyPtr:keyPtr];
    
    char ivPtr[kCCKeySizeAES128+1];
    
    memset(ivPtr, 1, sizeof(ivPtr));

    CCCryptorRef myCryptor = NULL;
    
    CCOperation optionMode = bEncrytion ? kCCEncrypt:kCCDecrypt;
    
    CCCryptorStatus cryptStatus = CCCryptorCreate(
                                                  optionMode,
                                                  kCCAlgorithmAES128,
                                                  kCCOptionPKCS7Padding,
                                                  keyPtr,
                                                  kCCKeySizeAES128,
                                                  ivPtr,
                                                  &myCryptor);
    if(cryptStatus == kCCSuccess) {
        return myCryptor;
    }
    return nil;
}

-(void)MD5AESkey:(NSString *)key keyPtr: (char*)outputbytes {

    bzero(outputbytes, sizeof(outputbytes));//结构体初始化到零
   
    const char *password=[key UTF8String];
    char mdc[16];
    CC_MD5(password,(CC_LONG)strlen(password),(unsigned char*)mdc);
    strcpy(outputbytes, mdc);
   }
@end
