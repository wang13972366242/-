//
//  LEAVEORSHIFT_DATA_STAT.h
//  Order
//
//  Created by wang on 2016/12/2.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 请假，调休的数据库属性
 * <br><font style="color:red">***仅供服务器使用***</font>
 * @author Sophie_WS
 *
 */

typedef enum {
    iD,  	//数据库中请假条或者调休单的唯一序号，这个不提示给用户，本机保存；
    TYPE,   //请假类型 - 参考类型的枚举类 LEAVEORSHIFT_TYPE
    START,	//请假开始时间
    END,  	//请假结束时间
    SHIFT_START,  //仅在调休时使用，补假的起始日期
    SHIFT_END,		//仅在调休时使用，补假的终止日期
    SUBMITTIME,		//提交单子的时间；
    REASON,			//请假事由，原因
    APPLICANT_ACOUNT,	//不显示在界面 - 提交请假单的用户账号
    APPROVER_ACOUNT,	//不显示在界面 - 需要审批请假单的审批人账号
    APPLICANT_REALNAME,  //提交请假单的用户姓名
    APPROVER_REALNAME,	 //需要审批请假单的审批人姓名
    COMMENT,			 //审批意见
    STATUS,				 //请假单的状态
}LEAVEORSHIFT_DATA_stat;

@interface LEAVEORSHIFT_DATA_STAT : NSObject



+(NSString *)LEAVEORSHIFT_DATA_statString:(LEAVEORSHIFT_DATA_stat)type;


+(LEAVEORSHIFT_DATA_stat)LEAVEORSHIFT_DATA_statEnum:(NSString *)stat;



+(NSArray *)LEAVEORSHIFT_DATA_statAllKeys;


@end
