//
//  PurchaseIASD.h
//  organizeClass
//
//  Created by wang on 16/9/26.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PurchaseIASD : NSObject
/** 内部的订单号*/
@property(nonatomic,strong) NSString *m_szInternalOrderNumber;
/** 第三方订单*/
@property(nonatomic,strong) NSString *m_szThirdPartyOrderNumber;
/** 其他信息*/
@property(nonatomic,strong) NSString *m_szOtherInfo;
/** 价格*/
@property(nonatomic,assign) CGFloat m_fPrice;
/** 日期*/
@property(nonatomic,strong) NSCalendar *m_clrdPurchaseTime;


/**
 * 客户端构造支付信息对象
 */
-(instancetype)initWithInternalOrder:(NSString *)szInternalOrder szOutOrder:(NSString*)szOutOrder clrTime:(NSCalendar *)clrTime fPrice:(CGFloat)fPrice szOtherInfo:(NSString *)szOtherInfo;

/**
 * 判断当前的支付信息对象是否为有效的对象；
 */
-(BOOL)isValid;
-(NSString *)toString;
-(NSString *)testObjectString;
@end
