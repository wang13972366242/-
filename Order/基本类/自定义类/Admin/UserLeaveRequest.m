//
//  UserLeaveRequest.m
//  Order
//
//  Created by wang on 2016/12/2.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserLeaveRequest.h"

@implementation UserLeaveRequest


//========================================构造函数=======================================
/**
 * 构造函数，从jsonString恢复对象
 * @param szJsonString 对象的JSON格式的字符串；
 * @throws JSONException 参数字符串无法转换成JSON对象时，抛出异常
 * @throws OrganizedException 非有效的用户请假单对象，抛出异常；
 */


-(instancetype)initUserLeaveRequestWith:(NSString *)szJsonString{
    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:szJsonString];
    NSArray<NSString *> *swipeDate = [SWIPE_DATA_STAT SWIPE_DATA_statAllKeys];
    if (self = [super initWithDictionary:dic keysets:swipeDate]) {
        
    }
    
    if ([self isValid]) {
        return self;
    }else{
        return nil;
    }
    
}

/**
 * 构造函数 - 从属性键值对恢复对象；
 * <font style="color:red"><br>***仅供服务器使用***</font>
 * @param mapDBValueList 属性键值对恢复对象；
 * @throws OrganizedException 参数无效或者包含无效的键值对；
 */
-(instancetype)initUserLeaveRequestWithDic:(NSDictionary<NSString *,NSString*> *)mapDBValueList{
    if(mapDBValueList == nil || mapDBValueList.count == 0){
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_LEAVEORSHIFT_INITDATAERROR" reason:@"nil" userInfo:nil];
        [Ce raise];
    }
    if (self = [super init]) {
    for(NSString *ID in [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statAllKeys]){
        if([[mapDBValueList allKeys] containsObject:ID]){
            [self __addArgumentPairKey:ID value:mapDBValueList[ID]];

        }else{
             [self __addArgumentPairKey:ID value:@""];
            
        }
    }
  
    }
    return self;
}


/**
 * 创建一个不完整的请求对象，指定了申请人和请假调休的类型
 * @param szRequestorAccount 申请人账号
 * @param szRequestorRealName 申请人真名
 * @param type 请假调休的类型
 * @throws OrganizedException 参数错误抛出异常
 */

-(instancetype)initUserLeaveRequestWithAccount:(NSString *)szRequestorAccount realName:(NSString *)szRequestorRealName type:(LEAVEORSHIFT_TYPE)type{
    if (self = [super init]) {
    [self setLeaveRequestApplicant:szRequestorAccount realNmae:szRequestorRealName];
    [self setLeaveRequestType:type];
    
    //初始化请求的状态；
    [self _setLeaveRequestStatus:SUBMITTED];
#pragma -mark ================
    [self setLeaveRequestSubmitTime:nil];
//    setLeaveRequestSubmitTime(Calendar.getInstance());
    }
    return self;

}

/**
 * 获取本类支持的所有属性值
 * @return 本类支持的所有属性值；
 */
+(NSArray<NSString *> *)getStatKeySet{
    
    return [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statAllKeys];
}

/**
 * 设置请假或调休请求的申请人账号
 * @param szUserAccount 申请人账号
 * @param szUserRealName 申请人真实姓名
 * @throws OrganizedException 参数有误，跳出异常
 */
-(void)setLeaveRequestApplicant:(NSString *)szUserAccount realNmae:(NSString *)szUserRealName{
    NSString *acountStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPLICANT_ACOUNT];
    NSString *REALNAMEStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPLICANT_REALNAME];
    [self __addArgumentPairKey:acountStr value:szUserAccount];
    [self __addArgumentPairKey:REALNAMEStr value:szUserRealName];

}

/**
 * 设置请假或调休请求的类型
 * <br>{@linkplain LEAVEORSHIFT_TYPE}
 * @param type 请假或调休请求的类型
 * @throws OrganizedException 参数为空跳出异常；
 */
-(void)setLeaveRequestType:(LEAVEORSHIFT_TYPE) type{
    NSString *TYPEStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:TYPE];
#pragma -mark 有误
    [self __addArgumentPairKey:TYPEStr value:TYPEStr == nil ? nil :TYPEStr];
    
//    __addArgumentPair(LEAVEORSHIFT_DATA_STAT.TYPE, type == null ? null : type.name());
    
}

-(void)_setLeaveRequestStatus:(REQUEST_STATUS )status {
    NSString *leaveStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:STATUS];
    NSString *statusStr = [UserLeaveRequest REQUEST_STATUSString:status];
    
    NSString *stuStr = [statusStr isEqualToString:@""]?@"":statusStr;
    [self __addArgumentPairKey:leaveStr value:stuStr];
    
}



/**
 * 设置请假或调休请求的审批人
 * @param szApproverAccount 审批人的账号；
 * @param szApproverRealName 审批人的真实姓名；
 * @throws OrganizedException   参数有误，跳出异常
 */

-(void)setLeaveRequestApprover:(NSString *)szApproverAccount realName:(NSString *)szApproverRealName{
       NSString *APPROVER_ACOUNTStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPROVER_ACOUNT];
    [self __addArgumentPairKey:APPROVER_ACOUNTStr value:szApproverAccount];
    
    NSString *APPROVER_REALNAMEStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPROVER_REALNAME];
    [self __addArgumentPairKey:APPROVER_REALNAMEStr value:szApproverRealName];
    
}

/**
 * 设置请假调休的起止时间
 * @param clrFrom 起始时间
 * @param clrTo 终止时间
 * @throws OrganizedException  参数有误，跳出异常
 */

-(void)setLeaveRequestTime:(NSDate *)clrFrom timeTo:(NSDate *) clrTo{
    
    NSString *STARTStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:START];
    
    [self __addArgumentPairKey:STARTStr value:nil];
    
    NSString *SENDStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:END];
    [self __addArgumentPairKey:SENDStr value:nil];

//    __addArgumentPair(LEAVEORSHIFT_DATA_STAT.START,CommonFunctions.calendarToDateTimeString(clrFrom));
//    __addArgumentPair(LEAVEORSHIFT_DATA_STAT.END,CommonFunctions.calendarToDateTimeString(clrTo));
  
}


/**
 * 设置调休补偿的起止时间
 * @param clrStart 起始时间
 * @param clrEnd 终止时间
 * @throws OrganizedException  参数有误，跳出异常
 */
-(void)setOffDutyShiftTime:(NSDate *)clrStart clrEnd:(NSDate *)  clrEnd{
    NSString *SHIFT_STARTStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:SHIFT_START];
    [self __addArgumentPairKey:SHIFT_STARTStr value:nil];
    
    NSString *SHIFT_ENDStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:SHIFT_END];
    [self __addArgumentPairKey:SHIFT_ENDStr value:nil];
    
//    __addArgumentPair(LEAVEORSHIFT_DATA_STAT.SHIFT_START,CommonFunctions.calendarToDateTimeString(clrStart));
//    __addArgumentPair(LEAVEORSHIFT_DATA_STAT.SHIFT_END,CommonFunctions.calendarToDateTimeString(clrEnd));
}


/**
 * 设置请假或调休请求的原因
 * @param szReason  请假或调休请求的原因
 */
-(void)setLeaveRequestReason:(NSString *)szReason{
    NSString *REASONStr =  [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:REASON];
    [self __addArgumentPairKey:REASONStr value:szReason];
  
}



/**
 * 获取请假或者调休请求条的状态；
 * @return 请假或者调休请求条的状态；
 */
-(REQUEST_STATUS)getLeaveRequestStatus{
    NSString *statusStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:STATUS];
   NSString *szMyStatus = [self __getArgumentValue:statusStr];
    REQUEST_STATUS type = [UserLeaveRequest REQUEST_STATUSEnum:szMyStatus];
    if(szMyStatus == nil) return -111;
    return type;

}

/**
 * 批准或者拒绝请假调休的请求；
 * <br> <font style ="color:red">***仅供审批人使用***</font>
 * @param bApprove true - 批准， false - 拒绝
 * @param szComments 审批意见； 可为null;
 * @throws OrganizedException 参数错误抛出异常；
 */

-(void)approveOrRejectLeaveRequest:(BOOL)bApprove comment:(NSString *) szComments{
    if([self getLeaveRequestStatus] != SUBMITTED){
        CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_LEAVEORSHIFT_REQUESTSTATUSMISMATCH" reason:@"nil" userInfo:nil];
        [Ce raise];
    
    }
    REQUEST_STATUS bstaus = bApprove == true ? APPROVED : REJECTED;
    [self _setLeaveRequestStatus:bstaus];
    [self _setLeaveRequestComment:szComments];
    
}


-(void)_setLeaveRequestComment:(NSString *) szComments{
    NSString *COMMENTStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:COMMENT];
    [self  __addArgumentPairKey:COMMENTStr value:szComments];
    
}


/**
 * 获取当前请假调休请求的申请人账号
 * @return 当前请假调休请求的申请人账号
 */
-(NSString *)getLeaveRequestApplicantAccount{
    NSString *acountStr  = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPLICANT_ACOUNT];
    NSString *szType =[self  __getArgumentValue:acountStr];
    return szType;
}

/**
 * 获取当前请假调休请求的申请人姓名
 * @return 当前请假调休请求的申请人姓名
 */
-(NSString *)getLeaveRequestApplicantRealName{
    NSString *APPLICANT_REALNAMEStr  = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPLICANT_REALNAME];
    NSString *szType =[self  __getArgumentValue:APPLICANT_REALNAMEStr];
    return szType;
}


/**
 * 设置请假或调休请求的提交时间
 * @param clrSubmit 提交时间
 * @throws OrganizedException 时间为空跳出异常；
 */
-(void)setLeaveRequestSubmitTime:(NSDate *) clrSubmit{
    
    NSString *TYPEStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:SUBMITTIME];
#pragma -mark ==================
    [self __addArgumentPairKey:TYPEStr value:@" 有待 "];
//    __addArgumentPair(LEAVEORSHIFT_DATA_STAT.SUBMITTIME,CommonFunctions.calendarToDateTimeString(clrSubmit));
}


/**
 * 获取当前请假调休请求的起始时间
 * @return 当前请假调休请求的起始时间
 */

-(NSDate *)getLeaveStartTime{
    
    NSString *STARTStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:START];
    NSString *szStartTime =[self __getArgumentValue:STARTStr];
#pragma -mark ----------------------------------------
    return nil;
//    return CommonFunctions.dateTimeStringToCalendar(szStartTime);
}


-(BOOL)isValid{
 
    NSString *leaveOrShift = [UserLeaveRequest LEAVEORSHIFT_TYPEString:OFFDUTY_SHIFT];
    
    //调休请求但调休时间段未设置完全；- 判定为无效设置
    if([[self getLeaveRequestType] isEqualToString:leaveOrShift] && ([self getOffDutyShiftStartTime] == nil || [self getOffDutyShiftEndTime] == nil)){
        return false;
    }
    
    //非调休请求，但调休时间段进行了设置； - 判定为无效设置
    if(![[self getLeaveRequestType] isEqualToString:leaveOrShift]  && ([self getOffDutyShiftStartTime] != nil || [self getOffDutyShiftEndTime] != nil)){
        return false;
    }
    return true;
}

/**
 * 获取当前请求的ID
 * @return ID为null或者无效返回null; 否则返回ID的整数序号
 */
-(NSInteger)getLeaveRequestID{
     NSString *IDStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:iD];
    NSString *szID = [self __getArgumentValue:IDStr];
    if(szID !=nil){
       
        return [szID integerValue];
    
    }
    return -111;
}


/**
 * 获取当前请假调休请求的提交时间
 * @return 当前请假调休请求的提交时间
 */
-(NSDate *)getLeaveRquestSubmitTime{
     NSString *SUBMITTIMEStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:SUBMITTIME];
    NSString *szSubmitTime = [self __getArgumentValue:SUBMITTIMEStr];
#warning -mark ---------------------------------------
    return nil;
//    return CommonFunctions.dateTimeStringToCalendar(szSubmitTime);
}

/**
 * 获取当前请假调休请求的时间长度
 * @return 当前请假调休请求的时间长度
 */
#warning  -nark ---------------------------
//public TimeDifference getLeaveTimeLength(){
//    Calendar clrStart = getLeaveStartTime(), clrEnd = getLeaveEndTime();
//    return new TimeDifference(clrEnd,clrStart);
//}

-(NSDate *)getOffDutyShiftStartTime{
    NSString *str = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:SHIFT_START];
    NSString *szStartTime = [self  __getArgumentValue:str];
#pragma -mark ===============
    return nil;
//    return CommonFunctions.dateTimeStringToCalendar(szStartTime);
}

-(NSDate *)getOffDutyShiftEndTime{
    NSString *leaveStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:SHIFT_END];
    NSString *szEndTime =[self  __getArgumentValue:leaveStr];
 #pragma -mark ===============
    return nil;
//    return CommonFunctions.dateTimeStringToCalendar(szEndTime);
}


/**
 * 获取当前请假调休请求的结束时间
 * @return 当前请假调休请求的结束时间
 */
-(NSCalendar *)getLeaveEndTime{
    NSString *ENDStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:END];
    NSString *szEndTime = [self __getArgumentValue:ENDStr];
    return nil;
//    return CommonFunctions.dateTimeStringToCalendar(szEndTime);
}

/**
 * 获取当前请假调休请求的类型
 * @return 当前请假调休请求的类型， 没有设置时，返回null;
 */
-(NSString *)getLeaveRequestType{
    
    NSString *swipeDate = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:TYPE];
    NSString *szType =[self  __getArgumentValue:swipeDate];
    if(szType == nil) return nil;
    return szType;
   
}

/**
 * 获取当前请假调休请求的审批人姓名
 * @return 当前请假调休请求的审批人姓名
 */
-(NSString *)getLeaveRequestApproverRealName{
    
    NSString *APPROVER_REALNAMEStr = [LEAVEORSHIFT_DATA_STAT LEAVEORSHIFT_DATA_statString:APPROVER_REALNAME];
    NSString *szType =[self  __getArgumentValue:APPROVER_REALNAMEStr];
    if(szType == nil) return nil;
    return szType;

}



-(NSDictionary *)toJsonObject{
    NSArray *arr = [UserLeaveRequest getStatKeySet];
    return  [super toJsonWithArr:arr];
    
}


-(NSString *)toString{
    NSDictionary *dic = [self toJsonObject];
    NSString *funStr = [CommonFunctions functionsFromObjectToJsonString:dic];
    return funStr;
}

+(NSString *)REQUEST_STATUSString:(REQUEST_STATUS)type{
    switch (type) {
        case SUBMITTED:
            return  @"SUBMITTED";
            break;
        case APPROVED:
            return  @"APPROVED";
            break;
        case REJECTED:
            return  @"REJECTED";
            break;
        default:
            break;
    }
    
}



+(REQUEST_STATUS)REQUEST_STATUSEnum:(NSString *)stat{
    
    if ([stat isEqualToString:@"SUBMITTED"]) {
        return SUBMITTED;
    }else if ([stat isEqualToString:@"APPROVED"]){
        return APPROVED;
        
    }else if ([stat isEqualToString:@"REJECTED"]){
        return REJECTED;
        
    }
    return 1234456;
}



+(NSArray *)REQUEST_STATUSAllKeys{
    NSArray *allkeys = @[@"SUBMITTED",@"APPROVED",@"REJECTED"];
    return allkeys;
}




+(NSString *)LEAVEORSHIFT_TYPEString:(LEAVEORSHIFT_TYPE)type{
    switch (type) {
        case CASUAL_LEAVE:
            return  @"CASUAL_LEAVE";
            break;
        case ANNUAL_LEAVE:
            return  @"ANNUAL_LEAVE";
            break;
        case SICK_LEAVE:
            return  @"SICK_LEAVE";
            break;
        case MARRIAGE_LEAVE:
            return  @"MARRIAGE_LEAVE";
            break;
        case BEREAVEMENT_LEAVE:
            return  @"BEREAVEMENT_LEAVE";
            break;
        case OFFDUTY_SHIFT:
            return  @"OFFDUTY_SHIFT";
            break;
                default:
            break;
    }
    
}



+(LEAVEORSHIFT_TYPE)LEAVEORSHIFT_TYPEEnum:(NSString *)stat{
    
    if ([stat isEqualToString:@"CASUAL_LEAVE"]) {
        return CASUAL_LEAVE;
    }else if ([stat isEqualToString:@"ANNUAL_LEAVE"]){
        return ANNUAL_LEAVE;
        
    }else if ([stat isEqualToString:@"SICK_LEAVE"]){
        return SICK_LEAVE;
        
    }else if ([stat isEqualToString:@"MARRIAGE_LEAVE"]){
        return MARRIAGE_LEAVE;
        
    }else if ([stat isEqualToString:@"BEREAVEMENT_LEAVE"]){
        return BEREAVEMENT_LEAVE;
        
    }else if ([stat isEqualToString:@"OFFDUTY_SHIFT"]){
        return OFFDUTY_SHIFT;
        
    }    return 1234456;
}



+(NSArray *)LEAVEORSHIFT_TYPEAllKeys{
    NSArray *allkeys = @[@"CASUAL_LEAVE",@"TYPE",@"START",@"END",@"SHIFT_START",@"SHIFT_END"];
    return allkeys;
}
@end
