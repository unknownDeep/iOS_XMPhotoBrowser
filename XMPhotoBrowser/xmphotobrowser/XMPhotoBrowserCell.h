//
//  XMPhotoBrowserCell.h
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  XMPhotoBrowserCellDelegate;

@interface XMPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, weak) id<XMPhotoBrowserCellDelegate> delegateCell;

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x image:(UIImage*)image;

- (void)initialWithIndexPath:(NSIndexPath*)indexPath scrollX:(CGFloat)x imageURL:(NSString*)imageURL;

- (void)collectionViewScrollToX:(CGFloat)X;

@end
@protocol XMPhotoBrowserCellDelegate <NSObject>
- (void)xmPhotoBrowserCell:(XMPhotoBrowserCell*)cell onTapSingleImageView:(UIImageView*)imgView;

@end