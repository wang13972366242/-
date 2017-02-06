//
//  DateCompent.h
//  artapp
//
//  Created by xiaoyuyang on 16/2/16.
//  Copyright © 2016年 SJWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateCompent : NSObject
+ (NSDateComponents *)getDateWithDate:(NSDate *)date;
/** 时间戳（单位是s）返回年月日 */
+ (NSDateComponents *)getDateWithTimevale: (long long)time;
+ (NSDateComponents *)getCurrentDate;
+ (NSString *)getCurrentCalendar;
+ (NSString *)getWeekday;
+ (unsigned long)timeStrToTimestamp:(NSString *)str;
+ (unsigned long)getMondayTimestamp;
+(NSCalendar*)dateStringToCalendar:(NSString *)szTime;
@end
