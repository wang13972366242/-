//
//  NSString+NSString__RegualrVierty.h
//  Order
//
//  Created by wang on 16/8/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString__RegualrVierty)
/**邮箱*/
+ (BOOL) validateEmail:(NSString *)email;

/**电话号码验证*/
+ (BOOL) validateMobile:(NSString *)mobile;
/**固定电话验证*/
+ (BOOL) validateHandset:(NSString *)mobile;
/**车牌号验证*/
+ (BOOL) validateCarNo:(NSString *)carNo;

/**车型*/
+ (BOOL) validateCarType:(NSString *)CarType;

/**用户名*/
+ (BOOL) validateUserName:(NSString *)name;


/**密码*/
+ (BOOL) validatePassword:(NSString *)passWord;

/**邮政编码*/
+ (BOOL) validatePostalcode:(NSString *)postalcode;


/**昵称*/
+ (BOOL) validateNickname:(NSString *)nickname;
/**数字*/
+ (BOOL) validateIntNumber:(NSString *)IntNumber;
/**身份证号*/
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
/**大写字母*/
+ (BOOL) validateIsUpCharr:(NSString *)upCharr;

//验证小写字母输入
+ (BOOL) validateIslowCharr:(NSString *)lowCharr;

//验证验证输入字母
+ (BOOL) validateIIsLetter:(NSString *)letter;

//验证验证输入汉字
+ (BOOL) validateIsChinese:(NSString *)chinese;

//验证验证输入字符串
+ (BOOL) validateIsLength:(NSString *)Length;
//是否在电脑上运行
+ (BOOL) validateIsRunningOnPC:(NSString *)Length;
/**
 *  验证IP地址（15位或18位数字）
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+(BOOL)validateIsIPAddress:(NSString *)patternStr;

/**
 *  验证输入的是否全为数字
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+(BOOL)validateIsAllNumber:(NSString *)patternStr;

/**
 *  验证输入的是否是URL地址
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+(BOOL)validateIsURL:(NSString *)patternStr;

@end
