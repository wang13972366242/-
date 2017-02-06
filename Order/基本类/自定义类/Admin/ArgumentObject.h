//
//  ArgumentObject.h
//  Admint
//
//  Created by wang on 2016/11/18.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArgumentObject <NSObject>
@optional
-(BOOL)isValid;
-(NSString *)testObjectString;
-(NSString *)toString;
@end
