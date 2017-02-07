//
//  DateCompent.m
//  artapp
//
//  Created by xiaoyuyang on 16/2/16.
//  Copyright © 2016年 SJWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateCompent.h"

@implementation DateCompent

+ (NSDateComponents *)getDateWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
    
    
}

+ (NSDateComponents *)getDateWithTimevale: (long long)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;

}

+(NSCalendar*)dateStringToCalendar:(NSString *)szTime{

    NSCalendar *calendar = [NSCalendar currentCalendar];

    //设置日期输出的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //刚好符合mysql的datetime的格式
   
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [formatter dateFromString:szTime];
    
    return date;
    
}
+ (NSDateComponents *)getCurrentDate {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

+ (NSString *)getWeekday
{
    NSArray *arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDateComponents *components = [self getCurrentDate];
    if (components.weekday > 0 && components.weekday < 8)
    {
        return arrWeek[components.weekday - 1];
    }
    else
    {
        return @"";
    }
}

+ (unsigned long)timeStrToTimestamp:(NSString *)str
{
    if (str == nil) {
        return 0;
    }
    // str格式"2011-01-26 17:40:50"，格式校验暂不做
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *date = [formatter dateFromString:str];
    
    return (unsigned long)[date timeIntervalSince1970] * 1000;
}

+ (NSString *)getCurrentCalendar{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];

    
    return currentTime;
    
}

+ (unsigned long)getMondayTimestamp
{
    NSDateComponents *components = [self getCurrentDate];
    long dayOffset = 0;
    NSInteger today = components.weekday;
    switch (today)
    {
        case 1:
            dayOffset = 6;
            break;
        case 2:
            dayOffset = 0;
            break;
        default:
            dayOffset = today - 2;
            break;
    }
    components.day -= dayOffset;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *monday = [gregorian dateFromComponents:components];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return (unsigned long)monday.timeIntervalSince1970 * 1000;
}

@end
