//
//  AppDelegate.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "AppDelegate.h"

#import "WQSignController.h"
#import "WQSignNaviController.h"
@interface AppDelegate ()
/** 注册*/
@property(nonatomic,strong) WQSignController *signVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    [self _voluntarilyLogin];
  
 
   
    return YES;
}


/**
 *  注册界面
 */
-(void)goLoginViewController{

    //2.加载注册页面
    _navi = [[UIStoryboard storyboardWithName:@"WQSignController" bundle:nil] instantiateInitialViewController];
    
    _window.rootViewController = _navi;

}

- (void)_voluntarilyLogin {
    
    //2-----取软件版本号
    NSString* key=@"CFBundleShortVersionString";
    NSString* lastVersion=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString* currentVersion=[NSBundle mainBundle].infoDictionary[key];
    
    [self goLoginViewController];
    
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        //读取NSString类型的数据
        NSString *phoneNumber = [userDefaultes stringForKey:@"phoneNumber"];
        NSString *passWord = [userDefaultes stringForKey:@"passWord"];
        //self.isTeacher = [[userDefaultes stringForKey:@"isTeacher"] integerValue];
        
        
        if (phoneNumber.length == 0 || passWord.length == 0) {
            [self goLoginViewController];
        }else {
            
            
            //开始拼接Json字符串
            NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:
                                           phoneNumber,@"mobile", nil];
            NSString *str = @"user/login";
            NSString *urlStr = [NSString stringWithFormat:urlString, str];
            
    
            
            //添加定时器
            _launchTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_logLaunchTime:) userInfo:nil repeats:YES];
            
            //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    }

}

#pragma mark -- 进入主界面
- (void)goMain{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = @"CFBundleShortVersionString";
    NSString* currentVersion=[NSBundle mainBundle].infoDictionary[key];
    [userDefaults setObject:currentVersion forKey:key];
    //给标签控制添加根控制器
    _window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
                       if (name && ![name isKindOfClass:NSNull.class] && [name length])
                       {
                           
                       }
                   });
}

#pragma mark -- 记录启动时长
- (void)_logLaunchTime:(NSTimer *)time {
    _logLaunchTime ++;
    NSLog(@"mmkmkmkmkm");
    if (_logLaunchTime>=5)
    {
        [_launchTime invalidate];
        [self goLoginViewController];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
