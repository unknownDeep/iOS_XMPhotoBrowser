//
//  XMPhotoBrowserCell.m
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMPhotoBrowserCell.h"
#import "XMCurveProgressView.h"
#import "UIImageView+WebCache.h"

@interface XMPhotoBrowserCell()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat imageMargin;

@property (nonatomic, strong) UIImageView *viewImage;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewWrap;
@property (nonatomic, strong) XMCurveProgressView *progressView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) CGFloat maximumZoomScale;

@end
@implementation XMPhotoBrowserCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        self.scrollViewWrap = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self addSubview:self.scrollViewWrap];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.scrollView.contentSize = screenSize;
        self.scrollView.maximumZoomScale=self.maximumZoomScale;
        self.scrollView.minimumZoomScale=1;
        self.scrollView.delegate = self;
        [self.scrollViewWrap addSubview:self.scrollView];
        
        self.viewImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.viewImage.userInteractionEnabled = YES;
        self.viewImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:self.viewImage];
        
        UITapGestureRecognizer *tapGestureRecognizerSingle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSingleImageView:)];
        [tapGestureRecognizerSingle setNumberOfTapsRequired:1];
        [self.viewImage addGestureRecognizer:tapGestureRecognizerSingle];
        UITapGestureRecognizer *tapGestureRecognizerDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapDoubleImageView:)];
        [tapGestureRecognizerDouble setNumberOfTapsRequired:2];
        [self.viewImage addGestureRecognizer:tapGestureRecognizerDouble];
        
        //当未识别或检测tapGestureRecognizerDouble失败时，tapGestureRecognizerSingle才有效
        [tapGestureRecognizerSingle requireGestureRecognizerToFail:tapGestureRecognizerDouble];
        
        self.progressView = [[XMCurveProgressView alloc] initWithFrame:CGRectMake(screenSize.width/2-25, screenSize.height/2-25, 50, 50)];
        self.progressView.startAngle = -90;
        self.progressView.endAngle = 270;
        self.progressView.progress = 0;
        self.progressView.progressLineWidth = 2;
        self.progressView.progressColor = [UIColor whiteColor];
        self.progressView.curveBgColor = [UIColor grayColor];
        [self addSubview:self.progressView];
        self.progressView.hidden = YES;
    }
    return self;
}

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x image:(UIImage*)image{
    [self initialWithIndexPath:indexPath scrollX:x];
    [self.viewImage setImage:image];
}

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x imageURL:(NSString*)imageURL{
    [self initialWithIndexPath:indexPath scrollX:x];
    self.progressView.progress = 0;
    [self.viewImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.progressView.progress = receivedSize/1.0/expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
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

- (void)onTapSingleImageView:(UITapGestureRecognizer*)sender{
    if (self.delegateCell) {
        if ([self.delegateCell respondsToSelector:@selector(xmPhotoBrowserCell:onTapSingleImageView:)]) {
            [self.delegateCell xmPhotoBrowserCell:self onTapSingleImageView:self.viewImage];
        }
    }
}

- (void)onTapDoubleImageView:(UITapGestureRecognizer*)sender{
    if (self.scrollView.zoomScale > 1.0) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }else{
        [self.scrollView setZoomScale:self.maximumZoomScale animated:YES];
    }
}

- (CGFloat)maximumZoomScale{
    return 3.0;
}


@end
