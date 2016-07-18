//
//  XMPhotoBrowserCell.h
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMPhotoBrowserCell : UICollectionViewCell

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x image:(UIImage*)image;

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x imageURL:(NSString*)imageURL;

- (void)collectionViewScrollToX:(CGFloat)X;

@end
@protocol XMPhotoBrowserCellDelegate <NSObject>


@end