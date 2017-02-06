//
//  WQRespondView.m
//  Order
//
//  Created by wang on 16/6/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQRespondView.h"

@implementation WQRespondView
- (UIViewController *)respondForController {
    
    UIResponder *next = self.nextResponder;
    
    // 只要响应者链上，还有下一级响应者，就一直查找
    do {
        // 判断获取的响应者对象是否是 视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            //
            // 返回查找到的视图控制器
            return (UIViewController *)next;;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    
    return nil;
}
@end
