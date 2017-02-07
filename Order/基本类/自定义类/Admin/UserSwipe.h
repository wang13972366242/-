//
//  UserSwipe.h
//  Order
//
//  Created by wang on 2016/11/30.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "BaseArgumentList.h"
#import "UserBean.h"
#import "FunctionUserSwipePublic.h"
#import "SWIPE_DATA_STAT.h"
@interface UserSwipe : BaseArgumentList

-(instancetype)initUserSwipeWithUserBean:(UserBean *)userBean swipType:(SWIPENODETYPE)swipetype NodeName:(NSString *)szSwipeNodeName datatype:(SWIPEDATATYPE)datatype swipeName:(NSString *)szSwipeName cld:(NSDate *)clrSwipeTime;


-(NSDate *) getUserFirstSwipeTime;
-(NSDate *) getUserLastSwipeTime;

-(NSString *) toString;
@end
