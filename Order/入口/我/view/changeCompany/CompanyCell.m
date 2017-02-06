//
//  CompanyCell.m
//  CompanyInfoChange
//
//  Created by wang on 16/8/11.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "CompanyCell.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation CompanyCell

-(instancetype)companyCell:(UITableView *)tableView WithIdentifier:(NSString *)ID {
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CompanyCell alloc]init];
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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.font = [UIFont systemFontOfSize:17];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGRect rect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width,50)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributes
                                                     context:nil];
    
    
    self.titleLabel.frame = CGRectMake(10, 6,rect.size.width, self.bounds.size.height- 12);
    
    
    CGRect textRect = CGRectMake(self.titleLabel.bounds.size.width+5+10, 6, KScreenWidth - CGRectGetMinX(self.titleLabel.frame)-20-10-3, self.bounds.size.height-12);

        self.contentLabel.frame = textRect;
    
    
}


@end
