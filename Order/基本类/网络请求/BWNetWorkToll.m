//
//  BWNetWorkToll.m
//  BWNews
//
//  Created by DuYang on 16/3/1.
//  Copyright © 2016年 DuYang. All rights reserved.
//

#import "BWNetWorkToll.h"

@implementation BWNetWorkToll


+(instancetype)shareNetWorkTool{
    
    static BWNetWorkToll *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        //创建baseURL
        NSURL *url = [NSURL URLWithString:baseUrl1];
        
        //设置配置信息
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSDictionary *dic =[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
        NSString *cookie = dic[@"Cookie"];
        [instance.requestSerializer setValue:cookie forHTTPHeaderField:KEY_SESSIONID];
        //设置Baseurl
        instance = [[BWNetWorkToll alloc] initWithBaseURL:url sessionConfiguration:configuration];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置响应数据格式化
        instance.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript",@"application/json",@"application/xml",@"application/x-javascript",@"text/css",@"text/plain",@"html/text",nil];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        instance.responseSerializer.stringEncoding = enc;

    });
    return instance;
}

//不含有基础URL
+(instancetype)shareNetWorkToolWithoutBaseURL{

    static BWNetWorkToll *instance = nil;
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //创建baseURL
        NSURL *url = [NSURL URLWithString:@""];
        
        //设置配置信息
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //设置Baseurl
        instance = [[BWNetWorkToll alloc] initWithBaseURL:url sessionConfiguration:configuration];
        
        //设置响应数据格式化
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript",@"application/json",@"application/xml",@"text/plain",@"text/css",@"text/plain",@"image/png",nil];
        
    });
    NSDictionary *dic =[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    NSString *cookie = dic[@"Cookie"];
    [instance.requestSerializer setValue:cookie forHTTPHeaderField:KEY_SESSIONID];
    
   
    return instance;
}

+(void )AFNetWorkingPostWithUrlStr:(NSString*)urlStr params:(NSDictionary *)params viewC:(UIViewController *)viewC backBlack:( void(^)(NSDictionary *headerDic,NSString *bodyStr,NSDictionary *cookies))backBlack{
    
    //设置网络请求工具
    BWNetWorkToll *newWorkTool = [BWNetWorkToll shareNetWorkToolWithoutBaseURL];
    //设置响应格式
    NSString * strUrl  =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
    if ([strUrl isEqualToString:urlStr]) {
        newWorkTool.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    newWorkTool.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //添加蒙版
    [MBProgressHUD showMessag:@"正在加载" toView:viewC.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 2.0), ^{
        [newWorkTool POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
               
            //1.cookie
//            NSArray *array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:urlStr]];
//           NSDictionary *cookie = [NSHTTPCookie requestHeaderFieldsWithCookies:array];
            //2.请求头
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *dic = response.allHeaderFields;
            //3.请求体
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSString *bodyStr = [SecurityUtil decryptAESStringFromBase64:str];
            backBlack(dic,bodyStr,nil);
            [MBProgressHUD hideAllHUDsForView:viewC.view animated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [BWNetWorkToll showHint:@"服务器请求超时！"];
            [NSThread sleepForTimeInterval:2.0f];
             [MBProgressHUD hideAllHUDsForView:viewC.view animated:YES];
        }];
        
        
    });
    
}



//邮箱验证的网络请求
+(void)AFNetCheck:(NSDictionary *)mudic verWay:(CheckType)verWay viewController:(UIViewController *)VC emialOrMobile:(NSString *)emialOrMobile{
    //url
    NSString * strUrl =[NSString stringWithFormat:@"%@CheckUniqueStatOccupied",baseUrl1];
   
    //设置参数
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:mudic viewC:VC backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        NSString *returnStr = headerDic[@"CheckType"];
        if ([returnStr isEqualToString:@"true"] ) {
            if (verWay==ACCOUNT_NAME  ) {
                return;
            }
            [BWNetWorkToll AFNetWorkingCheckEmalAndMob:verWay emialOrMobile:emialOrMobile VC:VC];
            
            
        }else{
            
            if (verWay == COMPANY_EMAIL ) {
                
                [BWNetWorkToll alertControllerShowWithTheme:@"邮箱不可用" suretitle:@"确认" viewController:VC];
            }else if(verWay == COMPANY_MOBILE){
                
                [self alertControllerShowWithTheme:@"手机不可用" suretitle:@"确认" viewController:VC];
            }else if (verWay == ACCOUNT_NAME){
                
                [self alertControllerShowWithTheme:@"名称不可用" suretitle:@"确认" viewController:VC];
                
            }
            
        }
    
    }];
}

//网络邮箱激活码
+(void)AFNetWorkingCheckEmalAndMob:(CheckType)verWay emialOrMobile:(NSString*)emialOrMobile VC:(UIViewController *)VC{
    
    
    //url
    NSString * strUrl  =[NSString stringWithFormat:@"%@ValidateEmailAccount",baseUrl1];
    NSDictionary*params;
    NSString *timeStr = [CommonFunctions functionsStringFromDate];
    if (verWay == COMPANY_EMAIL) {
        
        NSString *str = [SecurityUtil encryptAESDataToBase64AndKey:emialOrMobile key:timeStr];
        params = @{KEY_EMAILACCOUNT:str,KEY_REQUESTFROM:@"ios",KEY_TIMESTAMP:timeStr};
    }else{
        
        NSString *str = [SecurityUtil encryptAESDataToBase64AndKey:emialOrMobile key:timeStr];
        params = @{KEY_MOBILENUMBER:str,KEY_REQUESTFROM:@"ios",KEY_TIMESTAMP:timeStr};
    }
    
    //添加蒙版
    
    [BWNetWorkToll AFNetWorkingPostWithUrlStr:strUrl params:params viewC:VC backBlack:^(NSDictionary *headerDic, NSString *bodyStr, NSDictionary *cookies) {
        [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:kUserDefaultsCookie];
        
        
    }];
   
    
}
#pragma mark -UIAlertController
+(void)alertControllerShowWithTheme:(NSString *)themeTitle suretitle:(NSString *)suretitle viewController:(UIViewController *)VC{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:themeTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:suretitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [VC.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [alertC addAction:sureAction];
    [VC.navigationController presentViewController:alertC animated:YES completion:nil];
    
}

+(void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

@end
