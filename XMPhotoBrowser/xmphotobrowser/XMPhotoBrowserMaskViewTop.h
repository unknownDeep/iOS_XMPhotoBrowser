//
//  XMPhotoBrowserMaskViewTop.h
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMPhotoBrowserMaskViewTopDelegate;

@interface XMPhotoBrowserMaskViewTop : UIView

@property (nonatomic, weak) id<XMPhotoBrowserMaskViewTopDelegate> delegateMaskView;

+ (instancetype)viewWithSuperView:(UIView*)superView;

- (void)makeViewHidden:(BOOL)hidden;
//设置左边按钮标题，默认：@"返回"
- (void)setBtnLeftWithTitle:(NSString*)title;
//设置左边按钮图标，默认：@"xmphotobrowser_back"
- (void)setBtnLeftWithImage:(UIImage*)image;
//设置右边按钮标题，默认：@""
- (void)setBtnRightWithTitle:(NSString*)title;
//设置右边按钮图标，默认：@"xmphotobrowser_more"
- (void)setBtnRightWithImage:(UIImage*)image;
//设置title，默认：@"0 of 0"
- (void)setViewTitle:(NSString*)title;

@end
@protocol XMPhotoBrowserMaskViewTopDelegate <NSObject>
@optional
- (void)xmPhotoBrowserMaskViewTop:(XMPhotoBrowserMaskViewTop*)view onClickBtnLeft:(UIButton*)sender;

- (void)xmPhotoBrowserMaskViewTop:(XMPhotoBrowserMaskViewTop*)view onClickBtnRight:(UIButton*)sender;

@end
