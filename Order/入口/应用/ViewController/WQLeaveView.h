//
//  WQLeaveView.h
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQLeaveView : UIView
@property (weak, nonatomic) IBOutlet UIButton *longLabel;

@property (weak, nonatomic) IBOutlet UITextField *timeTF;
+(WQLeaveView *)nibLeaveView;
@end
