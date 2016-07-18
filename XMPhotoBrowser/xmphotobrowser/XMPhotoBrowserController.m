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

typedef NS_ENUM(NSInteger, XMPhotoBrowserType) {
    XMPhotoBrowserTypeImg,
    XMPhotoBrowserTypeUrl
};

@interface XMPhotoBrowserController()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XMPhotoBrowserCellDelegate, XMPhotoBrowserMaskViewTopDelegate>

@property (nonatomic, assign) XMPhotoBrowserType photoBrowserType;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *imagesUrl;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XMPhotoBrowserMaskViewTop *maskViewTop;

@property (nonatomic, assign) BOOL navigationViewHidden;

@end
@implementation XMPhotoBrowserController

+ (instancetype)controllerWithImages:(NSArray *)images{
    XMPhotoBrowserController *controller = [[XMPhotoBrowserController alloc] init];
    controller.images = images;
    controller.photoBrowserType = XMPhotoBrowserTypeImg;
    
    return controller;
}

+ (instancetype)controllerWithImagesUrl:(NSArray *)imagesUrl{
    XMPhotoBrowserController *controller = [[XMPhotoBrowserController alloc] init];
    controller.imagesUrl = imagesUrl;
    controller.photoBrowserType = XMPhotoBrowserTypeUrl;
    
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
    self.maskViewTop.delegateMaskView = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return self.navigationViewHidden;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (self.photoBrowserType == XMPhotoBrowserTypeImg) {
        count = self.images.count;
    }else if (self.photoBrowserType == XMPhotoBrowserTypeUrl){
        count = self.imagesUrl.count;
    }
    {
        //设置顶部视图title
        int index = (self.collectionView.contentOffset.x/[UIScreen mainScreen].bounds.size.width+0.5) + 1;
        [self.maskViewTop setViewTitle:[NSString stringWithFormat:@"%i of %li", index, count]];
    }
    return count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //设置顶部视图title
    NSInteger count = 0;
    if (self.photoBrowserType == XMPhotoBrowserTypeImg) {
        count = self.images.count;
    }else if (self.photoBrowserType == XMPhotoBrowserTypeUrl){
        count = self.imagesUrl.count;
    }
    int index = (self.collectionView.contentOffset.x/[UIScreen mainScreen].bounds.size.width+0.5) + 1;
    [self.maskViewTop setViewTitle:[NSString stringWithFormat:@"%i of %li", index, count]];
    
    //设置图片视图的偏移量
    for (XMPhotoBrowserCell *cell in self.collectionView.visibleCells) {
        [cell collectionViewScrollToX:scrollView.contentOffset.x];
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XMPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (self.photoBrowserType == XMPhotoBrowserTypeImg) {
        [cell initialWithIndexPath:indexPath scrollX:collectionView.contentOffset.x image:self.images[indexPath.row]];
    }else{
        [cell initialWithIndexPath:indexPath scrollX:collectionView.contentOffset.x imageURL:self.imagesUrl[indexPath.row]];
    }
    
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

//===============================================
#pragma mark - 顶部视图代理方法
- (void)xmPhotoBrowserMaskViewTop:(XMPhotoBrowserMaskViewTop *)view onClickBtnLeft:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)xmPhotoBrowserMaskViewTop:(XMPhotoBrowserMaskViewTop *)view onClickBtnRight:(UIButton *)sender{

}
@end
