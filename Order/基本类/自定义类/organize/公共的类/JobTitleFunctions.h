//
//  JobTitleFunctions.h
//  Order
//
//  Created by wang on 2016/11/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
static int MAXDEPARTMENTS	= 10;
static int MAXLEVEL	= 10;
static 	int 	MAXJOBTITLES		= 20;

@interface JobTitleFunctions : NSObject
+(BOOL)_s_isValidLevel:(int)iLevel limitMax:(int)LimitMax;
@end
