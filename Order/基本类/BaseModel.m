//
//  BaseModel.m
//  ClassForm
//
//  Created by lx on 16/4/16.
//  Copyright (c) 2016年 wang. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setKeyValues:dic];
    }
    return self;
}

@end
