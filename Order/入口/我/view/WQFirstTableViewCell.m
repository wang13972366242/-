//
//  WQFirstTableViewCell.m
//  Order
//
//  Created by wang on 16/6/28.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQFirstTableViewCell.h"
@interface WQFirstTableViewCell()


@end
@implementation WQFirstTableViewCell


+(instancetype)firstTableViewCell:(UITableView *)tableView WithIdentifier:(NSString *)ID{
    WQFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WQFirstTableViewCell alloc]init];
    }
    return cell;
}

- (instancetype)init{
    if (self = [super init]) {
        [self _configurationSubviews];
    }
    return self;
}

-(void)_configurationSubviews{
    
    //3个子视图
    self.BGView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.BGView];
    self.label = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:15.0f] textColor:[UIColor blackColor] text:nil];
    [self.BGView addSubview:self.label];
    
    
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    
    [self.BGView addSubview:_imageV];
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGRect rect = self.frame;
    /*
        1.背景图片
        2.左边的视图
        3.右边的label
     */
    CGFloat BGViewX = 10.0;
    CGFloat BGViewY = 20.0;
    CGFloat BGViewW =  rect.size.width  - 2 *BGViewX;
    CGFloat BGViewH =  rect.size.height  - 2 *BGViewY;
    self.BGView.frame = CGRectMake(BGViewX, BGViewY, BGViewW, BGViewH);
    self.BGView.image = [UIImage imageNamed:@"chat_btn_recording_n"];
    
    //2.左边的视图
    CGFloat imageVX = 5.0;
    CGFloat imageVY = 5.0;
    CGFloat imageVH =  BGViewH - 2*imageVY;
    self.imageV.frame = CGRectMake(imageVX, imageVY, imageVH, imageVH);
    //  3.右边的label
    CGFloat labelX = imageVH+imageVX +10;
    CGFloat labelW = BGViewW -labelX -15.0;
    
    self.label.frame = CGRectMake(labelX, imageVY,labelW, imageVH);
    
  
    
}


-(void)setLabelStr:(NSString *)labelStr{
    if (_labelStr != labelStr) {
        _labelStr = labelStr;
    }
    _label.text = labelStr;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
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
