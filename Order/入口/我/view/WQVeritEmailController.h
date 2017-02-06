//
//  WQVeritEmailController.h
//  Order
//
//  Created by wang on 16/7/20.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol veritEmailDelegate <NSObject>

-(void)veritEmailControllerClickSureBtn:(NSString *)Email;

@end

@interface WQVeritEmailController : UIViewController

/** 代理*/
@property(nonatomic,weak) id<veritEmailDelegate> delagate;

+(WQVeritEmailController *)shareStortyEmial;
@end
