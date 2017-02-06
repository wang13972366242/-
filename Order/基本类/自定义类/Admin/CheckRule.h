//
//  CheckRule.h
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionUserSwipePublic.h"

@interface CheckRule : NSObject
-(BOOL)isRuleCheckPass:(NSArray<NSDate *> *) clrlist;
-(BOOL)isRuleConflict:(CheckRule *)rule1;

@end;
