//
//  ScanPositionCell.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/12.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "ScanPositionCell.h"
#import "UIViewExt.h"
@implementation ScanPositionCell

-(instancetype)ScanPositionCell:(UITableView *)tableView WithIdentifier:(NSString *)ID; {
    ScanPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ScanPositionCell alloc] init];
    }
    return cell;
}
- (instancetype)init{
    if (self = [super init]) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews{
   
    _nameLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor blackColor] text:nil];
    [self.contentView addSubview:_nameLabel];
    
    
    _levelLabel = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:14.0] textColor:[UIColor blackColor] text:nil];
    [self.contentView addSubview:_levelLabel];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat levelLabelW = 60.0f;
    CGFloat  nameLabelY = 10;
    CGFloat  nameLabelH = self.height - 2*nameLabelY;
    CGFloat  nameLabelW = self.width - levelLabelW;
    
    self.nameLabel.frame = CGRectMake(0, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat levelLabelX =  self.width - levelLabelW;
    
    self.levelLabel.frame = CGRectMake(levelLabelX, nameLabelY, levelLabelW, nameLabelH);
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
