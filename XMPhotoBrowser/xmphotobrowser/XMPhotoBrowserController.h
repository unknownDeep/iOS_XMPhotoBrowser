//
//  XMPhotoBrowserController.h
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMPhotoBrowserControllerDelegate;
@protocol XMPhotoBrowserControllerDatasource;

@interface XMPhotoBrowserController : UIViewController

+ (instancetype)controller;

@end
@protocol XMPhotoBrowserControllerDelegate <NSObject>


@end
@protocol XMPhotoBrowserControllerDatasource <NSObject>


@end