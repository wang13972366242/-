//
//  LeftTableView.h
//  SaveDataPositionVC
//
//  Created by wang on 16/8/6.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JobTitleStructure;
@interface LeftTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
/** 职位管理*/
@property(nonatomic,strong) JobTitleStructure *jobManager;
@property(nonatomic,strong) NSMutableArray *departmentID;

@property(nonatomic,assign) BOOL isFirst;
/** 接受的数组*/
@property(nonatomic,strong) NSMutableArray *data;
/**  修改*/
@property(nonatomic,strong)  UITextField *textField;
@property(nonatomic,strong) NSString *titlStr;
/** 新名字*/
@property(nonatomic,strong) NSString *NewName;
@end
