//
//  WQMessageModel.m
//  Order
//
//  Created by wang on 16/7/18.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQMessageModel.h"

@implementation WQMessageModel


-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setKeyValues:dic];
    }
    return self;
}
@end
