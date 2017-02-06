//
//  FunctionUserSwipePublic.m
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "FunctionUserSwipePublic.h"

@implementation FunctionUserSwipePublic

+(NSString *)SwipenodeTypeString:(SWIPENODETYPE)type{
    switch (type) {
        case BAIDUMAP:
          return   @"BAIDUMAP";
            break;
        case WIFIGATEWAY:
            return   @"WIFIGATEWAY";
            break;
        case MANUAL:
            return   @"MANUAL";
            break;
        default:
            break;
    }
    
}


+(SWIPENODETYPE)SwipenodeTypeEnum:(NSString *)str{

    if ([str isEqualToString:@"BAIDUMAP"]) {
        return BAIDUMAP;
    }else if ([str isEqualToString:@"WIFIGATEWAY"]){
    
        return WIFIGATEWAY;
    }else if ([str isEqualToString:@"MANUAL"]){
        
        return MANUAL;
    }
    return 12345678;
}




+(NSString *)TimeValidAreaString:(TimeValidArea)type{
    switch (type) {
        case TIMEONLY:
            return   @"TIMEONLY";
            break;
        case DATETIME:
            return   @"WIFIGATEWAY";
            break;
    
        default:
            break;
    }
    
}


+(TimeValidArea)TimeValidAreaEnum:(NSString *)str{
    
    if ([str isEqualToString:@"TIMEONLY"]) {
        return TIMEONLY;
    }else if ([str isEqualToString:@"DATETIME"]){
        
        return DATETIME;
    }
    return 12345678;
}





+(NSString *)TimeCompareString:(TimeCompare)type{
    switch (type) {
        case BEFORE:
            return   @"BEFORE";
            break;
        case AFTER:
            return   @"AFTER";
            break;
            
        default:
            break;
    }
    
}


+(TimeCompare)TimeCompareEnum:(NSString *)str{
    
    if ([str isEqualToString:@"BEFORE"]) {
        return BEFORE;
    }else if ([str isEqualToString:@"AFTER"]){
        
        return AFTER;
    }
    return 12345678;
}



+(NSString *)TimeIntervalLimitString:(TimeIntervalLimit)type{
    switch (type) {
        case MIN:
            return   @"MIN";
            break;
        case MAX:
            return   @"MAX";
            break;
            
        default:
            break;
    }
    
}


+(TimeIntervalLimit)TimeIntervalLimitEnum:(NSString *)str{
    
    if ([str isEqualToString:@"MIN"]) {
        return MIN;
    }else if ([str isEqualToString:@"MAX"]){
        
        return MAX;
    }
    return 12345678;
}


+(NSString *)SWIPEDATATYPEString:(SWIPEDATATYPE)type{
    switch (type) {
        case SINGLE:
            return   @"SINGLE";
            break;
        case DOUBLEFIRST:
            return   @"DOUBLEFIRST";
            break;
        case DOUBLELAST:
            return   @"DOUBLELAST";
            break;
        case DOUBLECOMPLETE:
            return   @"DOUBLECOMPLETE";
            break;
            
        default:
            break;
    }
    
}


+(SWIPEDATATYPE)SWIPEDATATYPEEnum:(NSString *)str{
    
    if ([str isEqualToString:@"SINGLE"]) {
        return SINGLE;
    }else if ([str isEqualToString:@"DOUBLEFIRST"]){
        
        return DOUBLEFIRST;
    }else if ([str isEqualToString:@"DOUBLELAST"]){
        
        return DOUBLELAST;
    }else if ([str isEqualToString:@"DOUBLEFIRST"]){
        
        return DOUBLEFIRST;
    }
    
    return 12345678;
}


/**
 * 刷卡类型名字是否有效
 * <br>规则同用户名，公司名等，但长度小于或等于16个字节；
 * @param szName - 刷卡的名字，如“上班”,"午饭“，"晚饭"等；
 * @return
 */
+(BOOL)_isValidSwipeName:(NSArray<NSString *> *)arrName{
    if(arrName == nil) return false;
    for(int i= 0; i!= arrName.count; ++i){
        NSString *szName = arrName[i];
        if( szName.length <= MAXSWIPENAMELENGTH){
            continue;
        }
        return false;
    }
    return true;
}


@end
