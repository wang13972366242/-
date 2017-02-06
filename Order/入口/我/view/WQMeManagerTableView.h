//
//  WQMeManagerTableView.h
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PositionFrameVC;
@interface WQMeManagerTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
/** 数据*/
@property(nonatomic,strong) NSArray *managerArr;
@end
