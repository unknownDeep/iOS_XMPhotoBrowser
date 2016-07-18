//
//  XMPhotoBrowserCell.m
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMPhotoBrowserCell.h"

@interface XMPhotoBrowserCell()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat imageMargin;

@property (nonatomic, strong) UIImageView *viewImage;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewWrap;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
@implementation XMPhotoBrowserCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.scrollViewWrap = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self addSubview:self.scrollViewWrap];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.scrollView.contentSize = [UIScreen mainScreen].bounds.size;
        self.scrollView.maximumZoomScale=3.0;
        self.scrollView.minimumZoomScale=1;
        self.scrollView.delegate = self;
        [self.scrollViewWrap addSubview:self.scrollView];
        
        self.viewImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.viewImage.userInteractionEnabled = YES;
        self.viewImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:self.viewImage];
    }
    return self;
}

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x image:(UIImage*)image{
    [self initialWithIndexPath:indexPath scrollX:x];
    [self.viewImage setImage:image];
}

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x imageURL:(NSString*)imageURL{
    [self initialWithIndexPath:indexPath scrollX:x];
}

- (void)initialWithIndexPath:(NSIndexPath *)indexPath scrollX:(CGFloat)x{
    self.indexPath = indexPath;
    [self collectionViewScrollToX:x];
    
    self.scrollView.contentOffset = CGPointZero;
    [self.scrollView setZoomScale:1.0 animated:NO];
    self.viewImage.frame = [UIScreen mainScreen].bounds;
}

- (void)collectionViewScrollToX:(CGFloat)x{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat marginX = -(x - screenSize.width*self.indexPath.row)/screenSize.width*self.imageMargin;
    self.scrollViewWrap.frame = CGRectMake(marginX, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.viewImage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (CGFloat)imageMargin{
    return 15;
}

@end