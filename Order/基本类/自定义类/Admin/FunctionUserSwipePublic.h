//
//  FunctionUserSwipePublic.h
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SINGLE,
    DOUBLEFIRST,
    DOUBLELAST,
    DOUBLECOMPLETE,
}SWIPEDATATYPE;

typedef enum {
    BAIDUMAP,
    WIFIGATEWAY,
    MANUAL,
}SWIPENODETYPE;


typedef enum {
    TIMEONLY,
    DATETIME,
}TimeValidArea;

typedef enum {
    BEFORE,
    AFTER,
}TimeCompare;

typedef enum {
    MIN,
    MAX,
}TimeIntervalLimit;


static 	int 			MAXSWIPENAMELENGTH			= 16;
@interface FunctionUserSwipePublic : NSObject

+(NSString *)SwipenodeTypeString:(SWIPENODETYPE)type;


+(SWIPENODETYPE)SwipenodeTypeEnum:(NSString *)str;



+(NSString *)TimeValidAreaString:(TimeValidArea)type;

+(TimeValidArea)TimeValidAreaEnum:(NSString *)str;




+(NSString *)TimeCompareString:(TimeCompare)type;

+(TimeCompare)TimeCompareEnum:(NSString *)str;



+(NSString *)TimeIntervalLimitString:(TimeIntervalLimit)type;

+(TimeIntervalLimit)TimeIntervalLimitEnum:(NSString *)str;



+(NSString *)SWIPEDATATYPEString:(SWIPEDATATYPE)type;


+(SWIPEDATATYPE)SWIPEDATATYPEEnum:(NSString *)str;

/**
 * 刷卡类型名字是否有效
 */
+(BOOL)_isValidSwipeName:(NSArray<NSString *> *)arrName;
@end
