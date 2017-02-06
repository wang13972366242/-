//
//  JobTitleFunctions.m
//  Order
//
//  Created by wang on 2016/11/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "JobTitleFunctions.h"

@implementation JobTitleFunctions
+(BOOL)_s_isValidLevel:(int)iLevel limitMax:(int)LimitMax{
    return (iLevel > 0 && iLevel <= LimitMax) ? true : false;
}




@end
