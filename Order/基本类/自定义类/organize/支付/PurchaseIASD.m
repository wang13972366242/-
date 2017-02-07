//
//  PurchaseIASD.m
//  organizeClass
//
//  Created by wang on 16/9/26.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "PurchaseIASD.h"
#import "CommonFunctions.h"
@implementation PurchaseIASD
/**
 * 客户端构造支付信息对象
 * @param szInternalOrder - 有序APP的内部订单号
 * @param szOutOrder - 有序APP的外部订单号（第三方支付信息）
 * @param clrTime	- 购买时间
 * @param fPrice	- 支付的价格
 * @param szOtherInfo	- 其他的信息
 * @throws OrganizedException	- 输入信息有误则跳出异常；
 */
-(instancetype)initWithInternalOrder:(NSString *)szInternalOrder szOutOrder:(NSString*)szOutOrder clrTime:(NSDate *)clrTime fPrice:(CGFloat)fPrice szOtherInfo:(NSString *)szOtherInfo{
    if (self = [super init]) {
        _m_szInternalOrderNumber =szInternalOrder;
        _m_szThirdPartyOrderNumber = szOutOrder;
        _m_clrdPurchaseTime = clrTime;
        _m_fPrice = fPrice;
    }
    if(![self isValid]){
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_CONVERTION_ERROR" reason:@"PurchaseInfo: Not Valid Object"];
        
    }
    return self;
}

-(void)setM_fPrice:(CGFloat)m_fPrice{
    if (m_fPrice < 0) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"PurchaseInfo:SetPrice - price < 0"];
    }
    _m_fPrice = m_fPrice;
}
-(void)setM_clrdPurchaseTime:(NSDate *)m_clrdPurchaseTime{
    
    if (m_clrdPurchaseTime == nil) {
        [CommonFunctions functionsthrowExcentptionWith:@"ARGUMENT_OUTOFVALIDRANGE" reason:@"PurchaseInfo:SetTime - empty Calendar object"];
    }
    _m_clrdPurchaseTime = m_clrdPurchaseTime;
}

/**
 * 判断当前的支付信息对象是否为有效的对象；
 * @return 有效对象-true;无效对象-false;
 */
-(BOOL)isValid{
    NSArray *arrToCheck = @[_m_szInternalOrderNumber,_m_szThirdPartyOrderNumber];
    if(![CommonFunctions functionsIsArrayValid:arrToCheck] || _m_fPrice < 0 || _m_clrdPurchaseTime == nil){
        return false;
    }
    return true;
}

-(NSString *)testObjectString{
    NSString *szTestOutput;
    NSString * str = @"\r\n";
    if([self isValid]){
        NSString *strPrice = [NSString stringWithFormat:@"%.2f",_m_fPrice ];
        szTestOutput = [NSString stringWithFormat:@"内部订单号：%@%@第三方订单号：%@%@购买时间：%@%@购买价格：%@%@其他信息：%@%@",_m_szInternalOrderNumber,str,_m_szThirdPartyOrderNumber,str,@"30",str,strPrice,str,_m_szOtherInfo,str];
    }
    return szTestOutput;
    
}
-(NSString *)toString{
    if (![self isValid]) {
        return nil;
    }
    NSDictionary *dic = [self  toJsonObject];
    NSString *str =  [CommonFunctions functionsFromObjectToJsonString:dic];
    return  str;
}
-(NSDictionary *)toJsonObject{
    if(![self isValid]) return nil;
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
      
    if([CommonFunctions functionsIsStringValid:_m_szInternalOrderNumber]){
        [object addEntriesFromDictionary:@{@"Int_Order":_m_szInternalOrderNumber}];
    }
    
    if([CommonFunctions functionsIsStringValid:_m_szThirdPartyOrderNumber]){
        [object addEntriesFromDictionary:@{@"Out_Order":_m_szThirdPartyOrderNumber}];
    }
    if([CommonFunctions functionsIsStringValid:_m_szOtherInfo]){
        [object addEntriesFromDictionary:@{@"Other":_m_szOtherInfo}];
    }
    NSString *szTime =[CommonFunctions calendarToDateString:[NSDate date]];
    if([CommonFunctions functionsIsStringValid:szTime]){
        [object addEntriesFromDictionary:@{@"Time":szTime}];
    }
    
    NSString *szValue = [NSString stringWithFormat:@"%.2f",_m_fPrice];
    if([CommonFunctions functionsIsStringValid:szValue]){
        [object addEntriesFromDictionary:@{@"Price":szValue}];
    }
    return object;
}

@end
