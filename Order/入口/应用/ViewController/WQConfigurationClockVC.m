//
//  WQConfigurationClockVC.m
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQConfigurationClockVC.h"

@interface WQConfigurationClockVC ()

@end

@implementation WQConfigurationClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"配置";
}


+(WQConfigurationClockVC *)storyConfigurationClock{

    return [[UIStoryboard storyboardWithName:@"WQConfigurationClockVC" bundle:nil] instantiateInitialViewController];

}

@end
