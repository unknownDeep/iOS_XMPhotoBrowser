//
//  XMPhotoBrowserController.m
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMPhotoBrowserController.h"

#import "XMPhotoBrowserMaskViewTop.h"
#import "XMPhotoBrowserMaskViewCenter.h"
#import "XMPhotoBrowserMaskViewBottom.h"

#import "XMPhotoBrowserCell.h"

#define CellReuseIdentifier @"CellReuseIdentifierImages"

@interface XMPhotoBrowserController()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XMPhotoBrowserCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XMPhotoBrowserMaskViewTop *maskViewTop;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, assign) BOOL navigationViewHidden;

@end
@implementation XMPhotoBrowserController

+ (instancetype)controller{
    XMPhotoBrowserController *controller = [[XMPhotoBrowserController alloc] init];
    
    return controller;
}

- (void)viewDidLoad{
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    [self.collectionView registerClass:[XMPhotoBrowserCell class] forCellWithReuseIdentifier:CellReuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    self.maskViewTop = [XMPhotoBrowserMaskViewTop viewWithSuperView:self.view];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return self.navigationViewHidden;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (XMPhotoBrowserCell *cell in self.collectionView.visibleCells) {
        [cell collectionViewScrollToX:scrollView.contentOffset.x];
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XMPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    [cell initialWithIndexPath:indexPath scrollX:collectionView.contentOffset.x image:self.images[indexPath.row]];
    cell.delegateCell = self;
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size;
}

- (NSArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"img_%i", i]];
            [_images addObject:img];
        }
    }
    return _images;
}

//===============================================
#pragma mark - Cell代理方法
//单击图片
- (void)xmPhotoBrowserCell:(XMPhotoBrowserCell *)cell onTapSingleImageView:(UIImageView *)imgView{
    self.navigationViewHidden = !self.navigationViewHidden;
    if (self.navigationViewHidden) {
        //当隐藏导航栏时，需要先隐藏状态栏
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    [self.maskViewTop makeViewHidden:!self.maskViewTop.getHiddenState animationCompletion:^(BOOL finish) {
        if (!self.navigationViewHidden){
            //当显示导航栏时，需要导航栏动画完毕后，再显示状态栏
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }];
    
    
}
@end
