//
//  WQActivationModel.m
//  Order
//
//  Created by wang on 16/8/13.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQActivationModel.h"

@implementation WQActivationModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.isSelected = NO;
        self.titleStr = dic[@"titleStr"];
    }
    return self;
 
}
@end
