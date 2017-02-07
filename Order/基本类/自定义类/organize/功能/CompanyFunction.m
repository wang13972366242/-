//
//  CompanyFunction.m
//  organizeClass
//
//  Created by wang on 16/9/8.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CompanyFunction.h"
#import "DateCompent.h"
#import "CodeException.h"
#import "CommonFunctions.h"
@implementation CompanyFunction
     static 	float	DISCOUNT_PRICE  = 0.8f;
-(instancetype)initWithFunctionID:(FunctionID)fcid Calendar:(NSDate *)cldactivatetime daycount:(int)idaycount{
    
    if (self = [super init]) {
        
        self.m_FunctionID = fcid;
        if (cldactivatetime == nil) {
            self.m_ActivatedTime = [ NSDate date];
            
        }
        self.m_iPurchasedDayCount = idaycount;
    }
    return self;

}
+(instancetype)test:(FunctionID)ID{

    CompanyFunction *cf = [[CompanyFunction alloc]init];
    cf.m_FunctionID = ID;
    cf.m_iPurchasedDayCount = 7;
    return cf;
}
-(instancetype)initWithFunctionID:(FunctionID)fcid  daycount:(int)idaycount{
    if (self = [super init]) {
    
    self.m_FunctionID = fcid;
 
    self.m_iPurchasedDayCount = idaycount;
    }
    return self;

}


/**
 * 构造函数 - 收到的消息中提取String转换成对象时用到。
 * @param szCompanyFunc 	- JSONString
 * @throws JSONException 传递参数非有效JSONString
 * @throws OrganizedException 传递参数非有效CompanyFunction String
 */
//
//-(CompanyFunction *)formSzCompanyFunToObject:(NSString *)szCompanyFunc {
//    NSDictionary *functionDic = [CommonFunctions functionsFromJsonStringToObject:szCompanyFunc];
//    CompanyFunction * comfunctionS = [[CompanyFunction alloc]init];
//    
//    
//    NSMutableDictionary *object = [NSMutableDictionary dictionary];
//    [object addEntriesFromDictionary:@{@"ID":[CompanyFunction getStringFormEnum:_m_FunctionID]}];
//    
//    if (_m_ActivatedTime != nil) {
//        [object addEntriesFromDictionary:@{@"ACTTIME":[CommonFunctions functionsStringFromDate]}];
//    }
//    
//    [object addEntriesFromDictionary:@{@"DAYLEN":@(_m_iPurchasedDayCount)}];
//}

/**
 * 计算并判断功能是否已经过期 - 已经激活的状态下判断；
 * @return 过期-TRUE, 未过期-FALSE
 */
-(BOOL)isExpired{
    
    if(_m_ActivatedTime == nil){
        return true;
    }
    
//    NSCalendar *clrExpiredate = (Calendar) m_ActivatedTime.clone();
//    clrExpiredate.add(Calendar.DATE,  m_iPurchasedDayCount);
//    
//    Calendar clrnow = Calendar.getInstance();
//    if(clrnow.before(clrExpiredate)) return false;
////    return true;
    return NO;
}

/**
 * 计算价格
 */
-(CGFloat)calculatePrice{
    CGFloat fPrice = 0.0;
    if(_m_iPurchasedDayCount >= 180){
        int iMonth = _m_iPurchasedDayCount / 30;
        fPrice = [self getMonthPrice]* iMonth;
    }else if(_m_iPurchasedDayCount >= 30){
        int iMonth = _m_iPurchasedDayCount / 30;
        int iDay = _m_iPurchasedDayCount % 30;
        fPrice = [self getMonthPrice]* iMonth + [self getDayPrice] * iDay;
    }else if(_m_iPurchasedDayCount > 0){
        fPrice =[self getDayPrice] * _m_iPurchasedDayCount;
    }
    return fPrice;
}
/**
 * 取功能的月定价 xx rmb/month
 * @return 功能的月定价
 */
-(CGFloat)getMonthPrice{
    return [CompanyFunction getPricePerFunctionPerMonth:_m_FunctionID];
}

/**
 * 取功能的日定价 xx rmb/day
 * @return 功能的日定价
 */
-(CGFloat)getDayPrice{
    return [CompanyFunction getPricePerFunctionIDPerDay:_m_FunctionID];
}

//======================静态的方法===================
/**
 * 判断整个功能列表数组是否有效
 * @param bCheckExpired - 是否检测过期与否，检测-true,否则-false;
 * @param functions - a arrayList of CompanyFunctions
 * @return true if it's valid; false if it's "null" or not valid(such as expired etc.)
 */
+(BOOL)isFunctionListValid:(NSArray*)functions bCheckExpired:(BOOL)bCheckExpired{
    if(functions == nil) return false;
    for(CompanyFunction *fc in functions){
        if(!fc|| ![fc isValid]) return false;
    }
    return true;
}

/**
 * 激活时使用，更新整个功能列表的激活时间。
 * @param arrCompanyFunc	- 指定的功能列表数组
 * @param clrtime	- 指定的激活时间
 * @throws OrganizedException - 激活时间为null时，跳出 OrganizedErrorCode.ARGUMENT_EMPTY_ERROR
 */
-(void)updateFunctionListActivationTime:(NSArray*)arrCompanyFunc clrtime:(NSDate*)clrtime{
    if(clrtime == nil){
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"UpdateFunctionListActivationTime:input calendartime is null" userInfo:nil];
        [ce raise];
    }
    
    for(CompanyFunction *cmfunctmp in arrCompanyFunc){ //foreach遍历
        cmfunctmp.m_ActivatedTime = clrtime;
    }
}

/**CompanyFunction数组转换为String
 *
 * @param arrCompanyFunc - CompanyFunction数组;
 * <br>反向转换函数：( {@link #stringToFunctionArray(String)})
 * @return 转换为的JSONArray.toString();
 * @throws OrganizedException - 参数数组为空或者数组中包含无效的CompanyFunction对象
 */

+(NSString *)functionArrayToString:(NSArray*)arrCompanyFunc{
    if(arrCompanyFunc == nil){
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"FunctionArrayToString:input is a empty array" userInfo:nil];
        [ce raise];
    }
    NSMutableArray *array = [NSMutableArray array];
    for(CompanyFunction *func in arrCompanyFunc){
        if(func != nil){
            NSMutableDictionary *dic = [func toJson];
            [array addObject:dic];
        }else{
            
           CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"FunctionArrayToString: array contains invalid CompanyFunction object" userInfo:nil];
            [ce raise];
        }
    }
    NSString *str =[CommonFunctions functionsFromObjectToJsonString:array];
    return str;
}


/**符合格式的String转换为CompanyFunction数组
 * <br>反向转换函数：( {@link #functionArrayToString(ArrayList)})
 * @param szFuncList - CompanyFunction数组之前转化为的JSONArray的string;
 * @return CompanyFunction数组
 * @throws OrganizedException - 字符串参数不符合规定格式 - 为空白字符串或者NULL或者非有效的json格式；
 */
+(NSArray *)stringToFunctionArray:(NSString *) szFuncList {
    if(![CommonFunctions functionsIsStringValidAfterTrim:szFuncList]){
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_EMPTY_ERROR" reason:@"功能为空" userInfo:nil];
        [ce raise];
        
    }
    NSArray *array;
    @try {
        szFuncList = [CommonFunctions functionsClearStringTrim:szFuncList];
        array = [CommonFunctions functionsFromJsonStringToObject:szFuncList];
    } @catch (NSException *exception) {
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"功能" userInfo:nil];
        [ce raise];
    }
    
    NSMutableArray *fcList = [NSMutableArray array];

    for(NSDictionary  *objtmp in  array){
        NSString *time =  objtmp[@"ACTTIME"];
        NSDate *cld = [CommonFunctions dateTimeStringToCalendar:time];
        NSString *functionsID =  objtmp[@"ID"];
        FunctionID ID = [CompanyFunction getEnumFormStr:functionsID];
         NSString *functionsTime =  objtmp[@"DAYLEN"];
        
        CompanyFunction *fc =  [[CompanyFunction alloc]initWithFunctionID:ID Calendar:cld daycount:[functionsTime intValue]];
        [fcList addObject:fc];
    }
    return fcList;
}

/**
 * 免费激活码对应的功能套餐 - 天数可指定 - For Test
 * @param iDayLen - 套餐时长
 * @return	功能套餐
 */
+(NSArray *)getInstanceOfTrialFullFunctionList:(int)iDayLen{
    NSMutableArray *arrayList = [NSMutableArray array];
    NSArray *arr= [self getFunctionIDEnum];
    for(NSNumber *num in arr){
        int en= [num intValue];
        if(en == ERR_FUNC_INVALID){
            continue;
        };
        CompanyFunction *companyfunc =[[CompanyFunction alloc]initWithFunctionID:en daycount:iDayLen];
        [arrayList addObject:companyfunc];
    }
    return arrayList;
}


+(CGFloat)getPricePerFunctionPerMonth:(FunctionID)ID{
    return [CompanyFunction getPricePerFunctionIDPerDay:ID * 30 * DISCOUNT_PRICE];
}
//获得价格
+(CGFloat )getPricePerFunctionIDPerDay:(FunctionID)functionName{
    float  fPrice = 0;
    switch (functionName) {
        case ERR_FUNC_INVALID:
            fPrice = 0;
            break;
        case FUNC_INVENTORY_MANAGE:
            fPrice = 0.16f;
            break;
        case FUNC_USER_REQUEST:
            fPrice = 0;
            break;
        case FUNC_WORK_ATTENDENCE:
            fPrice = 0.2f;
            break;
        case FUNC_WORK_PERFORMAGIC:
            fPrice = 0.1f;
            break;
        case FUNC_WORK_REPORT:
            fPrice = 0.2f;
            break;
#warning -mark 价格不清楚
//        case FUNC_TASK_MANAGEMENT:
//            fPrice = 0.2f;
//            break;
        default:
            break;
    }
    return fPrice;
    
}

-(NSString *)toString{
    @try {
        NSDictionary *dic = [self toJson];
        return [CommonFunctions functionsFromObjectToJsonString:dic];
    } @catch (NSException *exception) {
        NSLog(@"ARGUMENT_CONVERTION_ERROR --%@",exception);
    }
   
}
-(NSMutableDictionary *)toJson{

    if(![self isValid] ){
    
        CodeException *ce =  [[CodeException alloc]initWithName:@"ARGUMENT_CONVERTION_ERROR" reason:@"toJsonObject:not a valid CompanyFunction" userInfo:nil];
        [ce raise];
    }
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    [object addEntriesFromDictionary:@{@"ID":[CompanyFunction getStringFormEnum:_m_FunctionID]}];

    if (_m_ActivatedTime != nil) {
    [object addEntriesFromDictionary:@{@"ACTTIME":[CommonFunctions calendarToDateString:[NSDate date]]}];
    }
  
    [object addEntriesFromDictionary:@{@"DAYLEN":@(_m_iPurchasedDayCount)}];
    return object;
}

/**
 * 判断对象是否为一个有效对象<br>判断了是否过期
 * @param bCheckExpired - 指定是否检测功能时间过期与否，true-检测过期(若过期，则无效), false-不检测是否过期
 * @return true - 有效对象； false - 无效对象
 */
-(BOOL)isValid{
    if(_m_FunctionID == ERR_FUNC_INVALID || _m_iPurchasedDayCount == 0){
        return false;
    }else{
        return true;
    }
}

/**
 * 根据所需功能进行价格计算；
 * @param arrFuncs - 所需功能列表
 * @return  计算所得的价格
 */
+(CGFloat )getTheTotalPriceWithFunctionArr:(NSArray *)functionArr{
    if (functionArr.count <1 ) {
        NSLog(@"The function  is not complete");
        return 0;
    }
    
    CGFloat allPrice = 0.0;
    for (CompanyFunction *function in functionArr) {
        
        CGFloat  price = [function calculatePrice];
        allPrice += price;
    }
    return allPrice;

}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    /** 功能ID*/
    
    [aCoder encodeObject:@(self.m_FunctionID) forKey:@"m_FunctionID"];
    /** 时间*/
    [aCoder encodeObject:self.m_ActivatedTime forKey:@"m_ActivatedTime"];
    /** 购买时间*/
    [aCoder encodeObject:@(self.m_iPurchasedDayCount) forKey:@"m_iPurchasedDayCount"];
    
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
         /** 功能ID*/
        NSNumber *numberID  = [NSNumber numberWithInt:self.m_FunctionID];
        numberID = [aDecoder decodeObjectForKey:@"m_vcAddressArr"];
        /** 时间*/
        self.m_ActivatedTime = [aDecoder decodeObjectForKey:@"m_ActivatedTime"];
           /** 购买时间*/
        NSNumber *numberDay  = [NSNumber numberWithInt:self.m_iPurchasedDayCount];
        numberDay = [aDecoder decodeObjectForKey:@"m_iPurchasedDayCount"];

    }
    return self;
}


+(NSString *)getStringFormEnum:(FunctionID)ID{
    NSArray *arr=  [self getFunctionIDString];
    return  [arr objectAtIndex:ID];
}


+(NSArray *)getFunctionIDString{
   
    return @[@"ERR_FUNC_INVALID",@"FUNC_WORK_ATTENDENCE",@"FUNC_INVENTORY_MANAGE",@"FUNC_WORK_REPORT",@"FUNC_WORK_PERFORMAGIC",@"FUNC_USER_REQUEST",@"FUNC_TASK_MANAGEMENT"];
}

+(NSArray *)getFunctionIDEnum{
    
    return @[@(ERR_FUNC_INVALID),@(FUNC_WORK_ATTENDENCE),@(FUNC_INVENTORY_MANAGE),@(FUNC_WORK_REPORT),@(FUNC_WORK_PERFORMAGIC),@(FUNC_USER_REQUEST),@(FUNC_TASK_MANAGEMENT)];
}



/**
 *  放回USE_STAT_ID
 *
 *  @param 枚举对应的字符串
 */
+(FunctionID)getEnumFormStr:(NSString *)str{
    
    if ([CommonFunctions functionsIsStringValidAfterTrim:str]) {
        if ([str isEqualToString:@"ERR_FUNC_INVALID"]) {
            return ERR_FUNC_INVALID;
        }else if ([str isEqualToString:@"FUNC_WORK_ATTENDENCE"]){
            return FUNC_WORK_ATTENDENCE;
        }else if ([str isEqualToString:@"FUNC_INVENTORY_MANAGE"]){
            return FUNC_INVENTORY_MANAGE;
        }else if ([str isEqualToString:@"FUNC_WORK_REPORT"]){
            return FUNC_WORK_REPORT;
        }else if ([str isEqualToString:@"FUNC_WORK_PERFORMAGIC"]){
            return FUNC_WORK_PERFORMAGIC;
        }else if ([str isEqualToString:@"FUNC_USER_REQUEST"]){
            return FUNC_USER_REQUEST;
        }else if ([str isEqualToString:@"FUNC_TASK_MANAGEMENT"]){
            return FUNC_TASK_MANAGEMENT;
        }
    }
    return  1000;
}

@end
