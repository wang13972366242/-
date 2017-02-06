//
//  WQSignController.h
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^signBlock)(NSString *userName,NSString *passWord);


@interface WQSignController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


/** block*/
@property(nonatomic,strong) signBlock block;
@end
