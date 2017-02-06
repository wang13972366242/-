//
//  DepartModel.h
//  Order
//
//  Created by wang on 16/7/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartModel : NSObject
/** 部门名字*/
@property(nonatomic,strong) NSString *departmentName;
/** ID*/
@property(nonatomic,strong) NSArray *departmentID;
/** 数组*/
@property(nonatomic,strong) NSArray *positionArr;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
