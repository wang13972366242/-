//
//  ScanDepartmentModel.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/12.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ScanDepartmentModel.h"

@implementation ScanDepartmentModel
-(NSMutableArray *)ID{
    if (_ID == nil) {
        _ID = [NSMutableArray array];
    }
    return _ID;
}
-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.themmeStr = dic[@"themmeStr"];
        self.detailStr = dic[@"detailStr"];
        self.ID = dic[@"ID"];
        self.isOpen = YES;
    }
    return self;
}
@end
