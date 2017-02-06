//
//  UserLeaveRequest.h
//  Order
//
//  Created by wang on 2016/12/2.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "SWIPE_DATA_STAT.h"
#import "LEAVEORSHIFT_DATA_STAT.h"
#import "FunctionUserSwipePublic.h"

typedef enum {
   	CASUAL_LEAVE,
    ANNUAL_LEAVE,
    SICK_LEAVE,
    MARRIAGE_LEAVE,
    BEREAVEMENT_LEAVE,
    OFFDUTY_SHIFT,
}LEAVEORSHIFT_TYPE;


typedef enum {
    SUBMITTED,
    APPROVED,
    REJECTED,
}REQUEST_STATUS;
@interface UserLeaveRequest : BaseArgumentList

/**
 * 获取当前请假调休请求的审批人姓名
 */
-(NSString *)getLeaveRequestApproverRealName;

-(NSString *)toString;
@end
