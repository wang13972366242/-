//
//  SelectedView.m
//  copyWritePick
//
//  Created by wang on 2016/11/15.
//  Copyright © 2016年 Particlestechnology. All rights reserved.
//

#import "SelectedView.h"
#import "SelectedCollectionCell.h"
@interface SelectedView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** UICollectionView*/
@property(nonatomic,strong) UICollectionView *contentCollecttionView;

@end

@implementation SelectedView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self _configurationSubviews];
    }
    return self;
}

-(void)_configurationSubviews{
    //1.设置布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置滑动方式
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置单元格的间隔
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.minimumInteritemSpacing = 0;
    
    //创建collectionView
    self.contentCollecttionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [self addSubview:_contentCollecttionView];
    
    //隐藏滑动条
    self.contentCollecttionView.showsHorizontalScrollIndicator = NO;
    self.contentCollecttionView.showsVerticalScrollIndicator = NO;
    self.contentCollecttionView.pagingEnabled = YES;
        //注册单元格
    [_contentCollecttionView registerClass:[SelectedCollectionCell class] forCellWithReuseIdentifier:regisetCollectionCell];
    //4.设置代理
    _contentCollecttionView.delegate = self;
    _contentCollecttionView.dataSource = self;

}

-(void)setNumberArr:(NSArray *)numberArr{
    if (_numberArr != numberArr) {
        _numberArr = numberArr;
    }
    [self setNeedsDisplay];
}
 static  NSString *regisetCollectionCell = @"regisetCollectionCell";


#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _numberArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedCollectionCell *cell = (SelectedCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:regisetCollectionCell  forIndexPath:indexPath];
    cell.contentlabel.text = _numberArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width-10,self.frame.size.height /_numberArr.count);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//
////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 15;
//}



//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = _numberArr[indexPath.row];
    [_selectedDelegate clickCollection:self didSelected:str];
    
}

 
@end
