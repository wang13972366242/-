//
//  WQMessageModel.h
//  Order
//
//  Created by wang on 16/7/18.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQMessageModel : NSObject

/** 图标*/
@property(nonatomic,strong) NSString *titleImg;

/** 显示内容label*/
@property(nonatomic,strong) NSString *content;
/** 显示编辑label*/
@property(nonatomic,strong) NSString *contentTF;
/** 是否允许编辑label*/
@property(nonatomic,assign) BOOL allowEdit;
/** 验证 */
@property(nonatomic,assign) BOOL isVerif;
/** 验证图片*/
@property(nonatomic,strong) NSString *verifStr;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
