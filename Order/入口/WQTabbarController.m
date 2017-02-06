//
//  WQTabbarController.m
//  Order
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "WQTabbarController.h"
#import "WQCompanyController.h"
#import "WQFuncdtionController.h"
#import "WQMeViewController.h"
#import "BaseNavigationController.h"

@interface WQTabbarController ()<UINavigationControllerDelegate>

@end

@implementation WQTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

//- (void)_createCustomBarView{
//    //自定义标签栏:隐藏系统的tabbar样式
//    self.tabBar.hidden = YES;
//    _tabbarView  = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, KScreenWidth - 55, KScreenHeight, 55)];
//    _tabbarView.userInteractionEnabled = YES;//不设置上面的按钮无法响应
//    _tabbarView.backgroundColor = [UIColor clearColor];
//    _tabbarView.imageName = @"mask_navbar";
//    [self.view addSubview:_tabbarView];
//    
//    NSArray *imageNames = @[@"home_tab_icon_1.png",
//                            @"home_tab_icon_2.png",
//                            @"home_tab_icon_3.png",
//                            @"home_tab_icon_4.png",
//                            @"home_tab_icon_5.png"];
//    
//    float width = KSCREEN_WIDTH / imageNames.count;
//    for ( int i =0; i< 5; i++) {
//        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(i * width, 0, width, 60);
//        button.tag = i;
//        //设置标题图片
//        button.imageName =imageNames[i];
//        //给按钮添加点击事件
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        //把按钮添加到背景图片
//        [_tabbarView addSubview:button];
//        
//        if (i == 0) {
//            //只创建一次跟随图片
//            _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
//            _selectedImageView.imageName = @"home_bottom_tab_arrow";
//            //防止_selectedImageView在button上，而拦截button点击事件
//            [_tabbarView insertSubview:_selectedImageView atIndex:0];
//            //设置第一次显示的位置
//            _selectedImageView.center = button.center;
//        }
//    }
//    
//    //创建badgeImageView:未读消息显示图标
//    badgeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(width - 32, 0, 32, 32)];
//    badgeImageView.imageName = @"number_notify_9";
//    badgeImageView.hidden = YES;
//    [_tabbarView addSubview:badgeImageView];
//    
//    //创建显示未读个数的文本
//    ThemeLabel *badgeLabel = [[ThemeLabel alloc] initWithFrame:badgeImageView.bounds];
//    badgeLabel.tag = 100;
//    badgeLabel.colorName = @"Timeline_Notice_color";
//    badgeLabel.textAlignment = NSTextAlignmentCenter;
//    badgeLabel.font = [UIFont systemFontOfSize:13];
//    badgeLabel.backgroundColor = [UIColor clearColor];
//    
//    [badgeImageView addSubview:badgeLabel];
//    
//}
//
//#pragma mark 标签按钮事件
//- (void)buttonAction:(UIButton *)button{
//    //自定义tabbar按钮，要实现原有的功能
//    self.selectedIndex = button.tag;
//    
//    [UIView animateWithDuration:0.35 animations:^{
//        _selectedImageView.center = button.center;
//    }];
//}
//

-(void)awakeFromNib{
    //1.获取标签控制其中的子试图控制器 (导航控制器)
        NSArray *viewControllers = self.viewControllers;
    for ( BaseNavigationController *navi in viewControllers) {
        navi.delegate = self;
    }
    self.selectedIndex = 1;
//    [self _createCustomBarView];
}
//
//- (void)_loadTabBar {
//    
//    //1.获取标签控制其中的子试图控制器 (导航控制器)
//    NSArray *viewControllers = self.viewControllers;
//    
//    //2.遍历标签控制其中的子试图控制器
//    for (UINavigationController *navigationVC in viewControllers) {
//        
//        //3.通过topViewController 拿到我需要的子控制器 判断子控制器
//        
//        if( [navigationVC.topViewController isKindOfClass:[NewsViewController class]]) {
//            
//            navigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image: [UIImage imageNamed:@"night_tabbar_icon_news_normal@2x"] selectedImage: [UIImage imageNamed:@"night_tabbar_icon_news_highlight@2x"]];
//        }else if([navigationVC.topViewController isKindOfClass:[FoundViewController class]]){
//            
//            navigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image: [UIImage imageNamed:@"night_tabbar_icon_found_normal@2x"] selectedImage: [UIImage imageNamed:@"night_tabbar_icon_found_highlight@2x"]];
//        }else if([navigationVC.topViewController isKindOfClass:[LiscentViewController class]]){
//            
//            navigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视听" image: [UIImage imageNamed:@"night_tabbar_icon_media_normal@2x"] selectedImage: [UIImage imageNamed:@"night_tabbar_icon_media_highlight@2x"]];
//        }
//        
//        
//    }
//    
//    //设置选中图片的颜色
//    self.tabBar.selectedImageTintColor = [UIColor colorWithRed:166.0 / 255.0 green:26.0 / 255.0 blue:30.0 / 255.0 alpha:1];
//    
//    
//}
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //当前显示的是rootViewVC
    if (navigationController.viewControllers.count == 1) {
        self.tabBar.hidden = NO;
    }
    //从显示第二个起，就隐藏
    else           {
        self.tabBar.hidden = YES;
    }
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
