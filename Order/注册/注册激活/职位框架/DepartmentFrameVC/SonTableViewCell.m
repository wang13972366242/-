//
//  SonTableViewCell.m
//  Digui
//
//  Created by wang on 16/7/4.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SonTableViewCell.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation SonTableViewCell

-(instancetype)SonTableViewCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame{
    SonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SonTableViewCell alloc] initWithFrame:frame];
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
 
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.contentBtn = [[SonBtn alloc] initWithFrame:CGRectZero];
    self.contentBtn.titleLabel.textColor = [UIColor blackColor];
    self.contentBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentBtn];
    self.contentBtn.backgroundColor = [UIColor purpleColor];
    [self.contentBtn addTarget:self action:@selector(pushActin:) forControlEvents:UIControlEventTouchUpInside];
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(0, 6,self.bounds.size.width - 40, self.bounds.size.height);
    CGFloat w = (self.bounds.size.height -30)/2;
    self.contentBtn.frame = CGRectMake(self.bounds.size.width - 35,w, 30, 30);
}
-(void)setIsRight:(BOOL)isRight{

    if (_isRight != isRight) {
        _isRight = isRight;
    }
    
    if (_isRight == YES) {
        _contentBtn.enabled = NO;
    }else{
        _contentBtn.enabled = YES;
    }
}

-(void)pushActin:(SonBtn *)sender{
    if (sender.departmentID.count >10) {
        [self alertControllerShowWithTheme:@"不能再添加子部门" suretitle:@"部门创建超过限制"];
    }else{
    NSDictionary *dic = @{@"index":self};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubcreatVC" object:self userInfo:dic];
    }
    
}
#pragma mark -UIAlertController
-(void)alertControllerShowWithTheme:(NSString *)themeTitle suretitle:(NSString *)suretitle{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:themeTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[self respondForController].navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [alertC addAction:sureAction];
    [[self respondForController].navigationController presentViewController:alertC animated:YES completion:nil];
    
}
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
