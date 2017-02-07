//
//  CommonFunctions.m
//  organizeClass
//
//  Created by wang on 16/9/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CommonFunctions.h"
#import "NSString+NSString__RegualrVierty.h"
#import "DateCompent.h"
#import "CodeException.h"
#import "MJExtension.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>

 #include <sys/socket.h> // Per msqr

#include <sys/sysctl.h>

#include <net/if.h>

 #include <net/if_dl.h>

@implementation CommonFunctions
    static BOOL g_bTestMode = YES;
/**
 * 判断字符串是否为null或者空“”；
 * @param szInput - 待测字符串<br>
 *  {@link #IsStringValid(String[])} - 判断一个字符数组中所有的成员都非null或""
 * @return true - 若字符串非空也有定义。 false - 不满足true的条件定义；
 *
 */
+(BOOL)functionsIsStringValid:(NSString *)szInput{
    if (szInput == nil || !szInput) {
        NSLog(@"字符串为空");
        return false;
    }
    return true;

}



 /**
 * 判断字符串是否为null或""或全由空白字符组成。
 * @param szInput - 待测字符串<br>
 * @return  true - 若字符串非null,非全由空白字符组成，非""。 false - 不满足true的条件定义；
 */
+ (BOOL)functionsIsStringValidAfterTrim:(NSString *) str {
    
    if ([self functionsIsStringValid:str] == NO) {
        NSLog(@" string is empty");
        return false;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            NSLog(@"string is all trim");
            return false;
        } else {
            return true;
        }
    }
}

/**
 * 从指定的JSONObject中，取出对应key的String值。
 * @param object - 指定的需被读取的JSONObject
 * @param szKey - 指定的key
 * @return - 返回JSONObject中key对应的String值；key若不存在于JSONObject中，返回null;
 */

+(NSString *)getStringFromJsonObjectEvenKeyIsntExit:(NSDictionary *)object key:(NSString *)szKey{
    if(object == nil || ![self functionsIsStringValid:szKey ]) return nil;
    if([[object allKeys] containsObject:szKey]){
        return object[szKey];
    }
    return nil;
}


+(NSString *)functionsClearStringTrim:(NSString*)szPassword{
    
    
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [szPassword stringByTrimmingCharactersInSet:set];
    
    return trimedString;
}
/**
 * 判断一个字符数组中所有的成员都非null或""
 * @param arrInput - 待测字符串数组<br>
 * @return true - 若数组中所有字符串非空也有定义。 false - 数组中有字符串为""或null;
 */
+(BOOL)functionsIsArrayValid:(NSArray *)arrInput{
    if (arrInput.count <1) {
        return false;
    }
    for (NSString *str in arrInput) {
        if (![self functionsIsStringValidAfterTrim:str]) {
            return false;
        }
    }
    return true;
}


/**
 * 多个地址的串，分离出地址数组
 * @param szAddresses	- 地址的字符串（含多个地址）
 * @return 地址数组
 */
+(NSArray *)functionsStringToAddressArray:(NSString *)szAddresses{
    
    if([CommonFunctions functionsIsValidEmail:szAddresses]){
        return [szAddresses componentsSeparatedByString:@"\t"];
    }
    return nil;
    
}
/**
 * 地址数组结合为一个字符串
 * @param arrAddresses 地址数组
 * @return - 地址的字符串（含多个地址）
 */
+(NSString *)funstionAddressArrayToString:(NSArray *)arrAddresses{
    if(arrAddresses != nil && arrAddresses.count > 0){
        NSString *szAddresses =[self functionsJoinString:@"\t" arr:arrAddresses];
        return szAddresses;
    }
    return nil;
    
}


/**
 * 从指定的JSONObject中，取出对应key的String值。
 *  object - 指定的需被读取的JSONObject
 *  szKey - 指定的key
 * @return - 返回JSONObject中key对应的String值；key若不存在于JSONObject中，返回null;
 */

+(id)functionsgetStringKeyIsntExitDic:(NSDictionary *)dic key:(NSString *)key{
    if (dic.count == 0 ||[self functionsIsStringValid:key]== NO) {
        NSLog(@"键值对错误");
        return nil;
    }
    if ([[dic allKeys] containsObject:key]) {
        return dic[key];
    }else{
        NSLog(@"字典没有对应的key");
        return nil;
    }
}
/**
 * 判断当前模式是否为测试模式；
 * @return - true:测试模式（默认）；false: 非测试模式
 */
+(BOOL)functionsIsTestMode{
    return g_bTestMode;
}
/**
 * 设置当前测试模式
 * @param bTest - true - 设置为测试模式；false - 设置为非测试模式
 */
+(void)functionsSetTestMode:(BOOL)isTest{
    if (g_bTestMode != isTest) {
        g_bTestMode = isTest;
    }
}
/**
 * 检测邮箱地址是否合法
 * @param email -待校验字符串
 * @return true合法 false不合法
 */
+(BOOL)functionsIsValidEmail:(NSString *)email{
    if ( [NSString validateEmail:email] == YES) {
        return YES;
    }else{
        NSLog(@"邮箱格式错误");
        return false;
    }
}
/**
 * 验证用户名，支持中英文（包括全角字符）、数字、下划线和减号 （全角及汉字算两位）,长度为4-20位,中文按二位计数
 * @author www.sangedabuliu.com
 * @param userName -待校验字符串
 * @return true合法 false不合法
 */
+(BOOL)functionsIsValidUserName:(NSString *)userName{
   return  [NSString validateUserName:userName];

}
/**
 * 验证手机号码
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsMobile:(NSString *)phoneStr{
    return [NSString validateMobile:phoneStr];
}

/**
 * 验证输入密码条件(字符与数据同时出现)
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */

+(BOOL)functionsIsPassword:(NSString *)str{
    return [NSString validatePassword:str];
}
/**
 * 验证输入邮政编号
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsPostalcode:(NSString *)str{
    return  [NSString validatePostalcode:str];
}
/**
 * 验证输入手机号码
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsHandset:(NSString *)str{
    return  [NSString validateHandset:str];
}
/**
 * 验证输入身份证号
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsIDcard:(NSString *)str{
    return  [NSString validateIdentityCard:str];
}
/**
 * 验证数字输入
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsNumber:(NSString *)str{
    
    
    if ([NSString validateIntNumber:str]) {
        return YES;
    } else{
        NSLog(@"数字格式错误");
        return NO;
    }
}
/**
 * 验证大写字母
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsUpChar:(NSString *)str{

 return  [NSString validateIsUpCharr:str];
}
/**
 * 验证小写字母
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsLowChar:(NSString *)str{
    
    return  [NSString validateIslowCharr:str];
}
/**
 * 验证验证输入字母
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsLetter:(NSString *)str{
    
    return  [NSString validateIIsLetter:str];
}
/**
 * 验证验证输入汉字
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsChinese:(NSString *)str{
    
    return  [NSString validateIsChinese:str];
}
/**
 * 验证验证输入字符串
 *
 * @param str 待验证的字符串
 * @return 如果是符合格式的字符串,返回 <b>true </b>,否则为 <b>false </b>
 */
+(BOOL)functionsIsLength:(NSString *)str{
    
    return  [NSString validateIsLength:str];
}


/**
 * 获取操作系统信息
 * @return 操作系统信息
 */
+(NSString *)functionGetOSinfo{
    
    
   return [[UIDevice currentDevice]systemName];
}

/**
 * 判断当前是否运行在电脑上
 * @return 是-true, 否-false;
 */

+(BOOL)functionsIsRunningOnPC{
    NSString *str = [self functionGetOSinfo];
    return  [NSString validateIsRunningOnPC:str];
}


/**
 * 获取字符串的长度，对双字符（包括汉字）按两位计数
 *
 * @param value -待校验字符串
 * @return 字符串的长度
 */
+(int)functionsgetStrLength:(NSString *)value{
    int valueLength = 0;
    for (int i = 0; i < value.length; i++) {
        NSRange range = NSMakeRange(i,i+1);
    NSString *temp = [value substringWithRange:range];
        const char *cString=[temp UTF8String];
        if (strlen(cString) == 1 ) {
            valueLength += 1;
        } else {
            valueLength += 2;
        }
    }
    return valueLength;
}
/**
 *  自定义对象归档
 *

 */
+(void)functionArchverCustomClass:(id)object fileName:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@.data",fileName ];
    //获取路径
    NSString *cachePath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取文件全路径
    NSString *fielPath = [cachePath stringByAppendingPathComponent:str];
    //把自定义对象归档
    [NSKeyedArchiver archiveRootObject:object toFile:fielPath];
}

/**
 *  自定义对象解档
 *
 
 */
+(id)functionUnarchverCustomClassFileName:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@.data",fileName ];
    //获取路径
    NSString *cachePath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取文件全路径
    NSString *fielPath = [cachePath stringByAppendingPathComponent:str];
    //把自定义对象解档
    id object= [NSKeyedUnarchiver unarchiveObjectWithFile:fielPath];
    return object;
}


// 开启倒计时效果
+(void)functionsOpenCountdown:(UIButton *)authCodeBtn time:(int )intervalTime{
    
    __block NSInteger time = intervalTime-1; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                [authCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % intervalTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [authCodeBtn setTitle:[NSString stringWithFormat:@"%.2dS", seconds] forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

/**
 *  抛出异常
 *  @param 异常code
 *  @param 原因
 */
+(void)functionsthrowExcentptionWith:(NSString *)code reason:(NSString *)reason{
    CodeException *ce =  [[CodeException alloc]initWithName:code reason:reason userInfo:nil];
    NSLog(@"reason = %@",reason);
    [ce raise];

}

+(NSString *)functionsJoinString:(NSString *)delim arr:(NSArray *)arr{
    NSMutableString *szResult;
    int i=0;
    
    for(NSString *szinput in arr){
        if (i == 0) {
            szResult = [NSMutableString stringWithString:szinput];
        }else{
        NSString*str = [delim stringByAppendingString:szinput];
        [szResult stringByAppendingString:str];
        }
        i++;
    }
    return szResult;
    
}
/**
 *  自定义对象转成jsonStr
 *  classObject 必须是字典数组
 *
 */
+(NSString *)functionsFromObjectToJsonString:(id)classObject{
  
    
    return  [classObject JSONString];

}

/**
 *  String -- >自定义对象
 *  jsonString json累的字符串
 *
 */
+(id )functionsFromJsonStringToObject:(NSString*)jsonString{
    return  [jsonString JSONObject];
  
}
/**
 * 把Calendar对象转化为日期时间字符串（格式"yyyy-MM-dd HH:mm:ss");
 * @param cld - Calendar对象
 * @return 日期时间字符串。
 */
+(NSString *)calendarToDateTimeString:(NSDate *)cld{
    
    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //刚好符合mysql的datetime的格式
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *str = [formatter stringFromDate:cld];
    
    return str;
}


/**
 * 把Calendar对象转化为日期时间字符串（格式"yyyy-MM-dd HH:mm:ss");
 * @param cld - Calendar对象
 * @return 日期时间字符串。
 */
+(NSString *)calendarToDateString:(NSDate *)cld{
    
    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //刚好符合mysql的datetime的格式
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *str = [formatter stringFromDate:cld];
    
    return str;
}

/**
 * 把Calendar对象转化为日期时间字符串（格式"yyyy-MM-dd HH:mm:ss");
 * @param cld - Calendar对象
 * @return 日期时间字符串。
 */
+(NSString *)calendarToTimeString:(NSDate *)cld{
    
    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    //刚好符合mysql的datetime的格式
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *str = [formatter stringFromDate:cld];
    
    return str;
}

/**
 * 把日期时间字符串（格式"yyyy-MM-dd HH:mm:ss") 转化为Calendar对象
 * @param szTime - 符合格式的字符串
 * @return 转化后的Calendar对象；（若字符串参数进行{@linkplain CommonFunctions#isStringValid(String...)}判断失败，或者不符合规定格式，则返回null）;
 */
+(NSDate *)dateTimeStringToCalendar:(NSString *) szTime{
    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //刚好符合mysql的datetime的格式
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [formatter dateFromString:szTime];
        return date;

}

/**
 * 把日期字符串（格式"yyyy-MM-dd") 转化为Calendar对象
 * @param szTime - 符合格式的字符串
 * @return 转化后的Calendar对象；（若字符串参数进行{@linkplain #isStringValid(String...)}判断失败，或者不符合规定格式，则返回null）;
 */
+(NSDate *)dateStringToCalendar:(NSString *) szTime{

    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //刚好符合mysql的datetime的格式
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [formatter dateFromString:szTime];
    return date;



}

/**
 * 把日期字符串（格式"HH:mm:ss") 转化为Calendar对象
 * @param szTime - 符合格式的字符串
 * @return 转化后的Calendar对象；（若字符串参数进行{@linkplain #isStringValid(String...)}判断失败，或者不符合规定格式，则返回null）;
 */
+(NSDate *)dateStringToTime:(NSString *) szTime{
    
    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    //刚好符合mysql的datetime的格式
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [formatter dateFromString:szTime];
    return date;
    
    
    
}

/**
 * 获取网卡的MAC地址 - 仅支持windows
 * @return MAC地址串, 不支持的平台则返回空串
 */

//+(NSString *)getMACAddress{
//    NSString *address = @"";
//    NSString *os = [system getProperty:@"os.name"];
//    if (os != null && os.startsWith("Windows")) {
//        try {
//            String command = "cmd.exe /c ipconfig /all";
//            Process p = Runtime.getRuntime().exec(command);
//            BufferedReader br =new BufferedReader(new InputStreamReader(p.getInputStream()));
//            String line;
//            while ((line = br.readLine()) != null) {
//                if (line.indexOf("Physical Address") > 0) {
//                    int index = line.indexOf(":");
//                    index += 2;
//                    address = line.substring(index);
//                    break;
//                }
//            }
//            br.close();
//            return address.trim();
//        } catch (IOException e) {
//        }
//        
//    }
//    return address;
//    
//    
////}


/**
 *  设备唯一标识符
 *
 
 */
+(NSString *)functionsHostName{
//NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *identifierStr = [[NSUUID UUID] UUIDString];    return identifierStr;
}

/**
 *  公共IP地址
 */
+ (NSString *)deviceIPAdress
{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

/**
 *  网卡的MAC地址
 */

+(NSString *) getMacAddress
{
    int mib[6];
    
    size_t len;
    
    char *buf;
    
    unsigned char *ptr;
    
    struct if_msghdr *ifm;
    
    struct sockaddr_dl *sdl;
    
    
    mib[0] = CTL_NET;
    
    mib[1] = AF_ROUTE;
    
    mib[2] = 0;
    
    mib[3] = AF_LINK;
    
    mib[4] = NET_RT_IFLIST;
    
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        
        printf("Error: if_nametoindex error/n");
        
        return NULL;
        
    }
    
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 1/n");
        
        return NULL;
        
    }
    
    if ((buf = malloc(len)) == NULL) {
        
        printf("Could not allocate memory. error!/n");
        
        return NULL;
        
    }
    
    
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 2");
        
        return NULL;
        
    }
    
    
    ifm = (struct if_msghdr *)buf;
    
    sdl = (struct sockaddr_dl *)(ifm + 1);
    
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    
    return [outstring uppercaseString];
    
}









/**
 * 判断字符串是否为有效的24小时制时间字符串；
 * @param szTimeString - 待检测字符串
 * @return false-无效时间字符串；true-有效格式化的时间字符串；
 */
+(BOOL)isValidDayTimeFormat:(NSString *) szTimeString{
    NSString *szRegExp = @"^(([0-1]?[0-9])|(2[0-3])):[0-5]?[0-9](:[0-5]?[0-9])?$";
    return [CommonFunctions matcher:szRegExp timeString:szTimeString] ? true:false;
}





+ (BOOL) matcher:(NSString *)reg timeString:(NSString *)szTimeString
{
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:reg options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:szTimeString options:0 range:NSMakeRange(0, szTimeString.length)];
    return results.count > 0;
}
@end
