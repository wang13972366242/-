//
//  WQActivationModel.h
//  Order
//
//  Created by wang on 16/8/13.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQActivationModel : NSObject

/** 是否选*/
@property(nonatomic,assign) BOOL isSelected;
/** title*/
@property(nonatomic,strong) NSString *titleStr;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end

