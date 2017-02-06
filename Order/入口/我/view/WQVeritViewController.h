//
//  WQVeritViewController.h
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol veritIphoneDelegate <NSObject>

-(void)veritViewControllerClickSureBtn:(NSString *)number;

@end


@interface WQVeritViewController : UIViewController

/** 代理*/
@property(nonatomic,assign) id<veritIphoneDelegate> delagate;

+(WQVeritViewController *)shareStortyMobile;
@end
