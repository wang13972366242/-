//
//  CommonFunctions.h
//  organizeClass
//
//  Created by wang on 16/9/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonFunctions : NSObject
/**判断字符串是否为null或者空“”*/
+(BOOL)functionsIsStringValid:(NSString *)szInput;
/**判断字符串是否为null或""或全由空白字符组成*/
+ (BOOL)functionsIsStringValidAfterTrim:(NSString *) str;
/**判断一个字符数组中所有的成员都非null或""*/
+(BOOL)functionsIsArrayValid:(NSArray *)arrInput;

/** 从指定的NSDictionary中，取出对应key的String值*/
+(id)functionsgetStringKeyIsntExitDic:(NSDictionary *)dic key:(NSString *)key;
/**判断当前模式是否为测试模式*/
+(BOOL)functionsIsTestMode;
/**验证邮箱是否合法*/
+(BOOL)functionsIsValidEmail:(NSString *)email;
/**判断用户名是否合法*/
+(BOOL)functionsIsValidUserName:(NSString *)userName;
/**判断手机号码是否合法*/
+(BOOL)functionsIsMobile:(NSString *)phoneStr;
/**判断密码是否合法*/
+(BOOL)functionsIsPassword:(NSString *)str;
/**判断邮政是否合法*/
+(BOOL)functionsIsPostalcode:(NSString *)str;
/**判断座机号码是否合法*/
+(BOOL)functionsIsHandset:(NSString *)str;
/**判断身份证是否合法*/
+(BOOL)functionsIsIDcard:(NSString *)str;
/**判断数字是否合法*/
+(BOOL)functionsIsNumber:(NSString *)str;
/**判断大写字母是否合法*/
+(BOOL)functionsIsUpChar:(NSString *)str;
/**判断小写字母是否合法*/
+(BOOL)functionsIsLowChar:(NSString *)str;
/**
 * 验证验证输入字母
 */
+(BOOL)functionsIsLetter:(NSString *)str;
/**
 * 验证验证输入汉字

 */


/**
 * 清除字符串中的空格

 */
+(NSString *)functionsClearStringTrim:(NSString*)szPassword;


/**
 * 开启倒计时效果
 
 */
+(void)functionsOpenCountdown:(UIButton *)authCodeBtn time:(int )intervalTime;
/**
 * 多个地址的串，分离出地址数组
 */

+(NSArray *)functionsStringToAddressArray:(NSString *)szAddresses;

+(BOOL)functionsIsChinese:(NSString *)str;
/**
 * 地址数组结合为一个字符串

 */
+(NSString *)funstionAddressArrayToString:(NSArray *)arrAddresses;
/**
 * 验证验证输入字符串
 */
+(BOOL)functionsIsLength:(NSString *)str;
/**
 * 判断当前是否运行在电脑上
 */

+(BOOL)functionsIsRunningOnPC;

+(NSString *)getStringFromJsonObjectEvenKeyIsntExit:(NSDictionary *)object key:(NSString *)szKey;
/**
 * 获取操作系统信息
 */
+(NSString *)functionGetOSinfo;



/**
 * 获取字符串的长度
 */
+(int)functionsgetStrLength:(NSString *)value;
/**
 *  抛出异常
 *
 *  @param 异常code
 *  @param 原因
 */
+(void)functionsthrowExcentptionWith:(NSString *)code reason:(NSString *)reason;
/**自定义拼接字符串*/
+(NSString *)functionsJoinString:(NSString *)delim arr:(NSArray *)arr;
/**
 *  自定义对象转成JsonString
 */
+(NSString *)functionsFromObjectToJsonString:(id)classObject;
/**
 *  String -- >自定义对象
 */
+(id )functionsFromJsonStringToObject:(NSString*)jsonString;

/**
 *  自定义对象归档
 *
 
 */
+(void)functionArchverCustomClass:(id)object fileName:(NSString *)fileName;
/**
 *  自定义对象解档
 *
 
 */
+(id)functionUnarchverCustomClassFileName:(NSString *)fileName;

+(NSString *)functionsHostName;

/**
 *  公共IP地址
 */
+ (NSString *)deviceIPAdress;
/**
 *  网卡的MAC地址
 */

+(NSString *) getMacAddress;







/**
 * 判断字符串是否为有效的24小时制时间字符串；
 * @param szTimeString - 待检测字符串
 * @return false-无效时间字符串；true-有效格式化的时间字符串；
 */
+(BOOL)isValidDayTimeFormat:(NSString *) szTimeString;


+(NSString *)calendarToDateTimeString:(NSDate *)cld;


/**
 * 把Calendar对象转化为日期时间字符串（格式"yyyy-MM-dd");
 * @param cld - Calendar对象
 * @return 日期时间字符串。
 */
+(NSString *)calendarToDateString:(NSDate *)cld;
  

/**
 * 把Calendar对象转化为日期时间字符串（HH:mm:ss");
 */
+(NSString *)calendarToTimeString:(NSDate *)cld;


/**
 * 把日期时间字符串（格式"yyyy-MM-dd HH:mm:ss") 转化为Calendar对象
 * @param szTime - 符合格式的字符串
 * @return 转化后的Calendar对象；（若字符串参数进行{@linkplain CommonFunctions#isStringValid(String...)}判断失败，或者不符合规定格式，则返回null）;
 */
+(NSDate *)dateTimeStringToCalendar:(NSString *) szTime;

/**
 * 把日期字符串（格式"yyyy-MM-dd") 转化为Calendar对象
 */
+(NSDate *)dateStringToCalendar:(NSString *) szTime;

/**
 * 把日期字符串（格式"HH:mm:ss") 转化为Calendar对象
 */
+(NSDate *)dateStringToTime:(NSString *) szTime;
@end
