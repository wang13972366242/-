//
//  SelectedPicker.m
//  SaveDataPositionVC
//
//  Created by wang on 16/8/10.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SelectedPicker.h"


@implementation SelectedPicker

-(NSMutableArray *)lastLV{
    
    if (_lastLV == nil) {
        _lastLV = [NSMutableArray array];
    }
    return _lastLV;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
    
}

-(NSMutableArray *)departmentArr{
    
    if (_departmentArr == nil) {
        _departmentArr = [NSMutableArray array];
        
        
    }
    return _departmentArr;
}

-(UILabel *)creatLabelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment )textAlignment font:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  self.departmentArr.count;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    NSString *str;
    if (_isDepartment == YES) {
    
    }else{
     
    }
    
    UILabel *label = [self creatLabelWithFrame:CGRectZero textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:14.0f] textColor:[UIColor blackColor] text:str];
    return label;

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    if (_isDepartment == YES) {
//        WQDepaetmnetClass *d =  _departmentArr[row];
//        [_selectDelegate selectedPicker:d];
//    }else{
//        Position *p =  _departmentArr[row];
//    [_selectDelegate selectedPicker:p];
//    }
//    

}

@end
