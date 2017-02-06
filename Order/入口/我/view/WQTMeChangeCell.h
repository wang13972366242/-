//
//  WQTMeChangeCell.h
//  Order
//
//  Created by wang on 16/7/1.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WQTMeChangeCell;
@protocol WQTMeChangeCellDelegate <NSObject>

@optional
- (void)WQTMeChangeCell: (WQTMeChangeCell *)TMeChangeCell didEndEdit: (NSString *)fieldText;

@end
@interface WQTMeChangeCell : UITableViewCell
/** 背景图片 */
@property(nonatomic,strong) UIImageView *bgImageV;
/** 图标*/
@property(nonatomic,strong) UIImageView *titleImg;
/** 显示label*/
@property(nonatomic,strong) UILabel *titleLabel;
/** 显示内容label*/
@property(nonatomic,strong) UILabel *contentLabel;
/** 显示编辑label*/
@property(nonatomic,strong) UITextField *contentTextField;


/** 是否允许编辑label*/
@property(nonatomic,assign) BOOL allowEdit;
/** 验证 */
@property(nonatomic,assign) BOOL isVerif;
/** */
@property(nonatomic,weak) id<WQTMeChangeCellDelegate> delegate;
/** 验证图片*/
@property(nonatomic,strong) UIButton *verifBtn;
/** 第一组数据*/
@property(nonatomic,strong) NSMutableArray *oneArr;



-(instancetype)meChangeCell:(UITableView *)tableView WithIdentifier:(NSString *)ID initWithFrame:(CGRect )frame;
@end
