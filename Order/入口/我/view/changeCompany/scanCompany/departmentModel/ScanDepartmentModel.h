
//
//  ScanDepartmentModel.h
//  CompanyInfoChange
//
//  Created by wang on 16/8/12.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanDepartmentModel : NSObject
@property(nonatomic,assign) BOOL isOpen;
/** 主题*/
@property(nonatomic,strong) NSString *themmeStr;
@property(nonatomic,strong) NSString *detailStr;
@property(nonatomic,strong) NSMutableArray *ID;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
