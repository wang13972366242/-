//
//  NSString+NSString__RegualrVierty.m
//  Order
//
//  Created by wang on 16/8/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "NSString+NSString__RegualrVierty.h"

@implementation NSString (NSString__RegualrVierty)
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSString *pattern = @"^w+[-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:email options:0 range:NSMakeRange(0, email.length)];
    return results.count > 0;
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
   
    // 1.创建正则表达式
    NSString *pattern = @"^1[34578]\\d{9}$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:mobile options:0 range:NSMakeRange(0, mobile.length)];
    return results.count > 0;
}

//座机号码验证
+ (BOOL) validateHandset:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex =  @"^[1]+[3578]+\\d{9}$";
    return [self validate:phoneRegex str:mobile];
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
  return [self validate:carRegex str:carNo];

}
//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
  return [self validate:CarTypeRegex str:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"/^[\u4e00-\u9fa5]{6,32}$/";
  
  return [self validate:userNameRegex str:name];
}

//邮政编码
+ (BOOL) validatePostalcode:(NSString *)postalcode
{
    //    NSString *userNameRegex = @"^[A-Za-z0-9]{8,32}+$";
    NSString *userNameRegex = @"^\\d{6}$";
   return [self validate:userNameRegex str:postalcode];
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z]\\w.{7,32}$";
   return [self validate:passWordRegex str:passWord];
}

//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
 return [self validate:nicknameRegex str:nickname];

}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSString *regex2 = @"(^\\d{18}$)|(^\\d{15}$)";
 return [self validate:regex2 str:identityCard];
}
//验证数字输入
+ (BOOL) validateIntNumber:(NSString *)IntNumber
{
    NSString *nicknameRegex = @"^[0-9]*$";
    return [self validate:nicknameRegex str:IntNumber];
    
}
///验证大写字母输入
+ (BOOL) validateIsUpCharr:(NSString *)upCharr
{
    NSString *nicknameRegex = @"^[A-Z]+$";
    return [self validate:nicknameRegex str:upCharr];
    
}
///验证小写字母输入
+ (BOOL) validateIslowCharr:(NSString *)lowCharr
{
    NSString *nicknameRegex = @"^[a-z]+$";
    return [self validate:nicknameRegex str:lowCharr];
    
}

//验证验证输入字母
+ (BOOL) validateIIsLetter:(NSString *)letter
{
    NSString *nicknameRegex = @"^[A-Za-z]+$";
    return [self validate:nicknameRegex str:letter];
    
}
+(BOOL)validateIsURL:(NSString *)patternStr{
    NSString *pattern = @"[\u4e00-\u9fa5]+";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:patternStr options:0 range:NSMakeRange(0, patternStr.length)];
    return results.count > 0;
}
//验证验证输入汉字
+ (BOOL) validateIsChinese:(NSString *)chinese
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5],{0,}$";
    return [self validate:nicknameRegex str:chinese];
    
}
+(BOOL)validateIsAllNumber:(NSString *)patternStr{
    NSString *pattern = @"^[0-9]*$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:patternStr options:0 range:NSMakeRange(0, patternStr.length)];
    return results.count > 0;
}

+(BOOL)validateIsIPAddress:(NSString *)patternStr
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    NSString *pattern = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:patternStr options:0 range:NSMakeRange(0, patternStr.length)];
    return results.count > 0;
}

//验证字符串
+ (BOOL) validateIsLength:(NSString *)Length
{
    NSString *nicknameRegex = @"^.{8,}$";
    return [self validate:nicknameRegex str:Length];
    
}
//是否在电脑上运行
+ (BOOL) validateIsRunningOnPC:(NSString *)Length
{
    NSString *nicknameRegex = @".*?win[\\s\\w]+";
    return [self validate:nicknameRegex str:Length];
    
}


+(BOOL)validate:(NSString *)regex str:(NSString *)str{
    NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [Predicate evaluateWithObject:str];
}

@end
