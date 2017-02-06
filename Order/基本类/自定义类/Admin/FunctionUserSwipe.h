//
//  FunctionUserSwipe.h
//  Order
//
//  Created by wang on 2016/11/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "PairSwipe.h"
#import "SingleSwipe.h"

@interface FunctionUserSwipe : BaseArgumentList

/** SWIPENODETYPE*/
@property(nonatomic,strong) NSMutableDictionary<NSString*,NSArray<NSString *> *> *m_mapSwipeNodeNames;

/** PairSwipe*/
@property(nonatomic,strong) NSMutableArray<PairSwipe *> *m_arrSwipePairConfig;

/** SingleSwipe*/
@property(nonatomic,strong) NSMutableArray<SingleSwipe *> *m_arrSingleSwipeConfig;


-(instancetype)initFunctionUserSwipe;

/**
 * 从json格式的字符串恢复成一个打卡功能的配置信息对象；
 */

-(instancetype)initFunctionUserSwipeWithJsonString:(NSString *)szJsonString;
@end
