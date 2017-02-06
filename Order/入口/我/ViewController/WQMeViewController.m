
//
//  WQMeViewController.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQMeViewController.h"
#import "WQMeFirstTableView.h"
@interface WQMeViewController ()

/** tableview 内容视图*/
@property(nonatomic,strong) WQMeFirstTableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *adminLabel;

@end

@implementation WQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //加载内容tableview
    NSString  *isAdmin = [[NSUserDefaults standardUserDefaults] objectForKey:WISADMINCODE];
    if ([isAdmin isEqualToString:@"YES"]) {
        _adminLabel.hidden = NO;
    }else{
        _adminLabel.hidden = YES;
    }
}

/**
 *  详细按钮
 */
- (IBAction)detailBtn:(UIButton *)sender {
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
