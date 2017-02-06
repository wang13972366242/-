//
//  RightTableView.h
//  SaveDataPositionVC
//
//  Created by wang on 16/8/6.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JobTitleStructure;
@interface RightTableView : UITableView <UITableViewDelegate,UITableViewDataSource>
/** 职位管理*/
@property(nonatomic,strong) JobTitleStructure *jobManager;
@property(nonatomic,strong) NSMutableArray *departmentID;
@property(nonatomic,assign) BOOL isFirst;
/** 是否是右边*/
@property(nonatomic,assign) BOOL isRight;

/** 接受的数组*/
@property(nonatomic,strong) NSMutableArray *data;

/** level*/
@property(nonatomic,strong) NSMutableArray<NSNumber *> *leverArr;

@property(nonatomic,strong) NSString *titlStr;

@end
