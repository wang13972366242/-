//
//  SonBtn.m
//  Digui
//
//  Created by wang on 16/7/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SonBtn.h"

@implementation SonBtn

-(NSMutableArray *)departmentID{
    if (_departmentID == nil) {
        _departmentID = [NSMutableArray array];
    }
    return _departmentID;

}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    return self;
}
@end
