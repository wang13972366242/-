//
//  UserOperationResult.m
//  Admint
//
//  Created by wang on 2016/11/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "UserOperationResult.h"

@implementation UserOperationResult



-(BOOL)isSucceeded{
    if([self getOperationResultErrorCode]) return true;
    return false;
}


/**
 * 获取错误代码；
 * 无错误的情况下无错误代码；
 */
-(BOOL )getOperationResultErrorCode{
   
    
    @try {
         NSString *szErrorCodeID =[self __getArgumentValue:[@"OrganizedErrorCode" uppercaseString]];
        if (szErrorCodeID) {
            return YES;
        }else{
            return NO;
        }
       
    } @catch (NSException *exception) {
        return NO;
    }
}

@end
