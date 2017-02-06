//
//  SelectedCollectionCell.m
//  copyWritePick
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SelectedCollectionCell.h"

@implementation SelectedCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentlabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:15.0f] textColor:[UIColor blueColor] text:nil];
        [self.contentView addSubview:self.contentlabel];
    }
    
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat BGViewX = 5.0;
    CGFloat BGViewY = 2.0;
    CGFloat BGViewW =  self.frame.size.width  - 2 *BGViewX;
    CGFloat BGViewH =  self.frame.size.height  - 2 *BGViewY;
    self.contentlabel.frame = CGRectMake(BGViewX, BGViewY, BGViewW, BGViewH);



}
-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}
@end
