//
//  PositionFrameVC.h
//  SetDepartment
//
//  Created by wang on 16/7/24.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PositionFrameVC;
@protocol PositionFrameVCDelagate

-(void)completePositionViewPositionFrameVC:(PositionFrameVC *)positionFrameVC;

@end

@interface PositionFrameVC : UIViewController<NSCoding>

/** 临时数组*/
@property(nonatomic,strong) NSMutableArray *subDepartmentArr;


/** 代理*/
@property(nonatomic,weak) id<PositionFrameVCDelagate> delagate;
+(PositionFrameVC *)frameVC;
@end
