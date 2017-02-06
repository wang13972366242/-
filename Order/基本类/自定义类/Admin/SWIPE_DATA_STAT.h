//
//  SWIPE_DATA_STAT.h
//  Order
//
//  Created by wang on 2016/12/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ID,
    USER_ACCOUNT,
    DATE,
    TIME_FIRST,
    TIME_LAST,
    SWIPENODE_TYPE,
    SWIPENODE_NAME,
    SWIPECONFIG_NAME,
    DATATYPE,
    OS,
    UUID,
}SWIPE_DATA_stat;

@interface SWIPE_DATA_STAT : NSObject


+(NSString *)SWIPE_DATA_STATString:(SWIPE_DATA_stat)type;


+(SWIPE_DATA_stat)SWIPE_DATA_STATEnum:(NSString *)stat;


+(NSArray *)SWIPE_DATA_statAllKeys;
@end
