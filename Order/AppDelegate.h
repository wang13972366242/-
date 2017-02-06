//
//  AppDelegate.h
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WQSignNaviController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    //记录启动时长
    NSInteger _logLaunchTime;
    //启动时长定时器
    NSTimer *_launchTime;
}

@property (strong, nonatomic) UIWindow *window;

/** 注册界面的导航栏*/
@property(nonatomic,strong) WQSignNaviController *navi;
/**
 *  根控制器换成注册页面
 */
- (void)goMain;
- (void)goLoginViewController;


@end

