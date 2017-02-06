//
//  UserSwipe.m
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserSwipe.h"

@implementation UserSwipe

-(instancetype)initUserSwipeWithUserBean:(UserBean *)userBean swipType:(SWIPENODETYPE)swipetype NodeName:(NSString *)szSwipeNodeName datatype:(SWIPEDATATYPE)datatype swipeName:(NSString *)szSwipeName cld:(NSCalendar *)clrSwipeTime{
    if (self = [super init]) {
        if(![userBean isValid] || !swipetype || !datatype || ![CommonFunctions functionsIsArrayValid:@[szSwipeNodeName,szSwipeName]]  ){
            
            CodeException *Ce =[[CodeException alloc]initWithName:@"FUNCTION_ATTENDANCE_WRONGARGUMENT" reason:@"nil" userInfo:nil];
            [Ce raise];

                }
        [self __addArgumentPairKey:@"USER_ACCOUNT" value:[self __getArgumentValue:@"LoginName"]];
        
        NSString *SWIPENODE_TYPEStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:SWIPENODE_TYPE];
        [self __addArgumentPairKey:SWIPENODE_TYPEStr value:[FunctionUserSwipePublic SwipenodeTypeString:swipetype]];
        
        NSString *SWIPENODE_NAMEEStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:SWIPENODE_NAME];
        [self __addArgumentPairKey:SWIPENODE_NAMEEStr value:szSwipeNodeName];
        
        NSString *SSWIPECONFIG_NAMEStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:SWIPECONFIG_NAME];
        [self __addArgumentPairKey:SSWIPECONFIG_NAMEStr value:szSwipeName];
        
        
        NSString *DATATYPEStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:DATATYPE];
        [self __addArgumentPairKey:DATATYPEStr value:[FunctionUserSwipePublic SWIPEDATATYPEString:datatype]];
        
        
        NSString *OSStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:OS];
        NSString *deviceStr = [self __getArgumentValue:@"DeviceID"];
        DeviceUniqueID *deID = [[DeviceUniqueID alloc]initDeviceWithJson:deviceStr];
        [self __addArgumentPairKey:OSStr value:deID.m_szOS];
        
        
        NSString *UUIDStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:UUID];
        [self __addArgumentPairKey:UUIDStr value:deID.m_szHostName];
#warning  -mark -------------------------------------------------------------------------------------------
        NSCalendar *swipetime =  clrSwipeTime ==nil ?[NSCalendar currentCalendar]:clrSwipeTime;
            
        
        NSString *DATEStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:DATE];
        [self __addArgumentPairKey:DATEStr value:[CommonFunctions calendarToTimeString:swipetime]];
        
            
                if(datatype == DOUBLEFIRST || datatype == SINGLE){
                    NSString *TIME_FIRSTStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:TIME_FIRST];
                     [self __addArgumentPairKey:TIME_FIRSTStr value:[CommonFunctions calendarToTimeString:swipetime]];
                }else{
                    NSString *TIME_LASTSTStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:TIME_LAST];
                    [self __addArgumentPairKey:TIME_LASTSTStr value:[CommonFunctions calendarToTimeString:swipetime]];

                }
                

    }
    
    if ([self  isValid]) {
        return self;
    }else{
        return nil;
    }
}


/**
 * 从USERSWIPE的JSONString形式恢复成为对象；
 * @param szJsonString - 对象的JSONString格式；
 * @throws JSONException - 不合法的JSONString
 * @throws OrganizedException - 合法的jsonstring但是不合法的对象；
 */

-(instancetype)initUserSwipWithJsonString:(NSString *)jsonStr{
    
    NSDictionary *dic = [CommonFunctions functionsFromJsonStringToObject:jsonStr];
    if (self = [super initWithDictionary:dic keysets:[SWIPE_DATA_STAT SWIPE_DATA_statAllKeys]]) {
        
    }
    return self;
 
}


/**
 * 从HASHMAP中读入对象；
 * <font style="color:red"><br>****仅供服务器使用***</font>
 * @param dbData HASHMAP的数据源
 * @throws OrganizedException hashmap为空或者其中包含非法数据；
 */

//-(instancetype)init
//
//public UserSwipe(HashMap<String, String> dbData) throws OrganizedException {
//    if(dbData == null || dbData.isEmpty()){
//        throw new OrganizedException(OrganizedErrorCode.FUNCTION_ATTENDANCE_SWIPEDATA_INITERROR,"Empty HashMap<String, String> ");
//    }
//    for(SWIPE_DATA_STAT id:SWIPE_DATA_STAT.values()){
//        
//        if(dbData.containsKey(id.getDBColumnName())){
//            __addArgumentPair(id, dbData.get(id.getDBColumnName()));
//        }else{
//            __addArgumentPair(id,null);
//        }
//    }
//    checkValid(this);
//}

/**
 * 判断对象是否有效；
 * <pre>判断规则：
 * 1. 除了打卡时间点数据（第一次，最后一次刷卡时间）可以根据类型，其中之一为null之外，其他所有参数不可为null或者无效格式；
 * 2. SWIPEDATATYPE 为 单次打卡SWIPEDATATYPE.SINGLE，和成对打卡-第一次时SWIPEDATATYPE.DOUBLEFIRST， 打卡时间点数据只能第一次有数据，第二次为null;
 * 3. 成对打卡-第二次时SWIPEDATATYPE.DOUBLELAST， 打卡时间点数据只能第二次有数据，第一次为null;
 * 4. 成对打卡-完整数据时，打卡时间点数据两次都必须有正确的时间数据；
 * </pre>
 */
-(SWIPEDATATYPE)getUserSwipeDataType{
    NSString *dataStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:DATATYPE];
    NSString *szDataType =[self  __getArgumentValue:dataStr];
    
    return  [FunctionUserSwipePublic SWIPEDATATYPEEnum:szDataType];

}

-(BOOL)isValid{
    SWIPEDATATYPE swipedatatype =[self  getUserSwipeDataType];
    NSString *szSwipeName =[self __getArgumentValue:[SWIPE_DATA_STAT SWIPE_DATA_STATString:SWIPECONFIG_NAME]];
//    if(getUserSwipeTime == nil || getUserSwipeNodeType() == null || swipedatatype == null){
//        return false;
//    }
//    if((swipedatatype != SWIPEDATATYPE.SINGLE && !isValidVirtualNameFormat(szSwipeName) )||
//       (swipedatatype == SWIPEDATATYPE.SINGLE && !_isValidSwipeName(szSwipeName)) ||
//       ((swipedatatype == SWIPEDATATYPE.SINGLE || swipedatatype == SWIPEDATATYPE.DOUBLEFIRST) && getUserLastSwipeTime() != null) ||
//       ((swipedatatype == SWIPEDATATYPE.DOUBLELAST) && getUserFirstSwipeTime() != null)){
//        return false;
//    }
    
    return true;
}

/**
 * 返回用户第一次刷卡时间；
 * <br><font style="color:red">***此处没有做类型检测***</font>
 * @return 用户第一次刷卡时间；
 */
-(NSCalendar *) getUserFirstSwipeTime{
    return [self _getUserSingleSwipeTime:true];
}

/**
 * 返回用户最后一次刷卡时间；
 * <br><font style="color:red">***此处没有做类型检测***</font>
 * @return 用户第一次刷卡时间；
 */

-(NSCalendar *) getUserLastSwipeTime{
    return [self _getUserSingleSwipeTime:false];
}



-(NSCalendar *)_getUserSingleSwipeTime:(BOOL) bFirstTime{
    NSString *dateStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:DATE];
    NSString *szDate = [self __getArgumentValue:dateStr];
    if(szDate == nil) return nil;
    
    NSString *TIME_FIRSTStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:TIME_FIRST];
    NSString *TIME_LASTStr = [SWIPE_DATA_STAT SWIPE_DATA_STATString:TIME_LAST];
    NSString  *szTime = bFirstTime ? [self __getArgumentValue:TIME_FIRSTStr] :
				[self __getArgumentValue:TIME_LASTStr];
    if(szTime != nil){
        NSString *szFulldatetime =[CommonFunctions functionsJoinString:@" " arr:@[szDate,szTime]];
#warning -mark ------------------------------
        NSCalendar *clrd;
//        NSCalendar *clrd = [CommonFunctions dateTimeStringToCalendar:szFulldatetime];
        return clrd;
    }
    return nil;
}


-(NSString *) toString{
    
    NSDictionary *dci = [self toJsonObject];
    return [CommonFunctions functionsFromObjectToJsonString:dci];
}

/**
 * 将对象转换为JSONObject格式；
 * @return 对象的JSONObject形式
 */
-(NSDictionary *)toJsonObject{
    return   [super toJsonWithArr:[SWIPE_DATA_STAT SWIPE_DATA_statAllKeys]];

}



@end
