//
//  WQAddPaidView.m
//  Order
//
//  Created by wang on 2016/11/14.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQAddPaidView.h"

@implementation WQAddPaidView

+(WQAddPaidView *)nibPaidView{
    WQAddPaidView *leaveNib = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] objectAtIndex:0];
    return leaveNib;
    
}
@end
