
//
//  SelectedDepartPosition.m
//  SelectDepartmentPosition
//
//  Created by wang on 16/7/21.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SelectedDepartPosition.h"
#import "SelectedPicker.h"
#import "JobTitleStructure.h"


@interface SelectedDepartPosition()<SelectedPickerDelegate>

/** UIcolllectView*/
@property(nonatomic,strong) UIScrollView *scrollView;

/** SelectedPicker*/
@property(nonatomic,strong) NSMutableArray *departArr;
@property(nonatomic,strong) NSMutableArray *positionArr;

@end
@implementation SelectedDepartPosition

-(NSMutableArray *)departArr{
    if (_departArr == nil) {
        _departArr = [NSMutableArray array];
    }
    return _departArr;
}
-(NSMutableArray *)positionArr{
    if (_positionArr == nil) {
        _positionArr = [NSMutableArray array];
    }
    return  _positionArr;
}
-(NSMutableArray *)data{

    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

/**
 *  初始化方法
 *  创建  1，一个label "职位" 宽度40 高度40 X 5 Y5
 *
 *       2.UIScrollView
 */

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
       
        
        [self _configuration];
    }

    return self;
}

-(void)_configuration{
    
    CGFloat  H = self.bounds.size.height;
    CGFloat  W = self.bounds.size.width;
    CGFloat hight = 30.0f;
    CGFloat  labelWidth = 60.0f;
    
    self.label = [self creatLabelWithFrame:CGRectMake(10, 10, labelWidth, hight) textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:17.0f] textColor:[UIColor blackColor] text:nil];
    [self addSubview:self.label];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(labelWidth +10+2, 0, W - 50, H)];
    _scrollView.contentSize = CGSizeMake(80 * 10, H );
    
    [self addSubview:_scrollView];
  
   
}

-(void)willMoveToSuperview:(UIView *)newSuperview{

   
}

//-(void)creatSeletedPickerDepartment:(WQDepaetmnetClass *)department withArr:(NSMutableArray*)arr{
//    SelectedPicker *d = [[SelectedPicker alloc]initWithFrame:CGRectMake(100 *(department.ID.count - 1), 0, 100, self.bounds.size.height)];
//    d.isDepartment = YES;
//    d.selectDelegate = self;
//    d.departmentArr = arr ;
//    d.ID = department.ID;
// 
//    [self.departArr  addObject:d];
//    [self.scrollView addSubview:d];
//}
//
//
//-(void)creatSeletedPickerPosition:(Position *)position withArr:(NSMutableArray*)arr {
//    
//    
//    SelectedPicker *p = [[SelectedPicker alloc]initWithFrame:CGRectMake(100 *(position.ID.count - 1), 0, 100, self.bounds.size.height)];
//    p.isDepartment = NO;
//    p.selectDelegate = self;
//    p.departmentArr = arr;
//    p.ID = position.ID;
//    
//   [self.positionArr  addObject:p];
//    [self.scrollView addSubview:p];
//}
//
//
//-(void)selectedPicker:(id)selecteID{
//    
//    if ([selecteID isKindOfClass:[Position class]]) {
//        NSMutableArray *data = [NSMutableArray array];
//        Position *cp =  (Position *)selecteID;
//     
//        for (Position *p in _manager.positiontArr) {
//            NSMutableArray *arr= [NSMutableArray array];
//            arr = [p.ID mutableCopy];
//            [arr removeLastObject];
//          
//            
//            if ([arr isEqual:cp.ID]) {
//                [data addObject:p];
//            }
//        }
//        
//        if (data.count >0) {
//            [self creatSeletedPickerPosition:data[0] withArr:data];
//        }else{
//            [_delegate selectPosition:cp.name];
//            for (SelectedPicker *DP in self.positionArr) {
//                
//                if ([DP.ID isEqualToArray:cp.ID]) {
//                    return;
//                }else{
//                    
//                    if (DP.ID.count >cp.ID.count) {
//                        [DP removeFromSuperview];
//                    }else{
//                        
//                    }
//                    
//                }
//            }
//        
//        }
//        
//    }else{
//        
//        NSMutableArray *data = [NSMutableArray array];
//        WQDepaetmnetClass *cp =  (WQDepaetmnetClass *)selecteID;
//        for (WQDepaetmnetClass *p in _manager.departmentArr) {
//            NSMutableArray *arr= [NSMutableArray array];
//            arr = [p.ID mutableCopy];
//            [arr removeLastObject];
//            if ([arr isEqual:cp.ID]) {
//                [data addObject:p];
//            }
//        }
//        
//        if (data.count >0) {
//            [self creatSeletedPickerDepartment:data[0] withArr:data];
//        }else{
//            [_delegate selectDepartment:cp.name];
//            for (SelectedPicker *DP in self.departArr) {
//                
//                if ([DP.ID isEqualToArray:cp.ID]) {
//                    return;
//                }else{
//                    
//                    if (DP.ID.count >cp.ID.count) {
//                        [DP removeFromSuperview];
//                    }else{
//                        
//                    }
//                    
//                }
//            }
//        }
//    
//    
//    }
//}

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}

-(id)unarchverCustomClassFileName:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@.data",fileName ];
    //获取路径
    NSString *cachePath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //获取文件全路径
    NSString *fielPath = [cachePath stringByAppendingPathComponent:str];
    //把自定义对象解档
    id object= [NSKeyedUnarchiver unarchiveObjectWithFile:fielPath];
    return object;
}

@end
