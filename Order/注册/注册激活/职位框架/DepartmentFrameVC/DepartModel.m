//
//  DepartModel.m
//  Order
//
//  Created by wang on 16/7/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "DepartModel.h"

@implementation DepartModel


-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
