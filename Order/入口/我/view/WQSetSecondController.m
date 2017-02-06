//
//  WQSetSecondController.m
//  Order
//
//  Created by wang on 16/6/29.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQSetSecondController.h"
#import "WQSuggestions.h"
@interface WQSetSecondController ()
/** 意见反馈*/
@property(nonatomic,strong) WQSuggestions *suggesV;
@end

@implementation WQSetSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    //创建视图
    [self _configurationSubViews];
}

-(void)_configurationSubViews{
    if ([_titleStr isEqualToString:@"意见反馈"] ) {
        //姓名,电子邮箱,内容,发送) - 参考公司主页的联系我们页面
        //1.姓名
        _suggesV = [[[UINib nibWithNibName:@"WQSuggestions" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        _suggesV.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64);
        [self.view addSubview:_suggesV];
    }else{
    
    
    }
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
