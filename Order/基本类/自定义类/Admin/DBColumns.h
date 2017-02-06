//
//  DBColumns.h
//  Admint
//
//  Created by wang on 2016/11/18.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DBColumns <NSObject>

@optional
-(NSString *)getDBColumnName;
-(NSString *)getDBColumnType;
-(BOOL )isValueValidForKey:(NSString *)szValue;
@end
