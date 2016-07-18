//
//  XMCurveProgressView.h
//  XMCurveProgressView
//
//  Created by zhanghao on 16/5/25.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMCurveProgressView;
@protocol XMCurveProgressViewDelegate <NSObject>

@optional

/**
 *  Progress report
 *
 *  @param progressView XMCurveProgressView
 *  @param progress     progress changed
 *  @param lastProgress progress last time
 */
-(void)progressView:(XMCurveProgressView *)progressView progressChanged:(CGFloat)progress lastProgress:(CGFloat)lastProgress;

@end


IB_DESIGNABLE

@interface XMCurveProgressView : UIView

//Curve background color
@property (nonatomic, strong) IBInspectable UIColor *curveBgColor;

//Enable gradient effect
@property (nonatomic, assign) IBInspectable CGFloat enableGradient;

//Gradient layer1［you can custom gradient effect by set gradient layer1's property］
@property (nonatomic, strong ,readonly) CAGradientLayer *gradientLayer1;

//Gradient layer2［you can custom gradient effect by set gradient layer2's property］
@property (nonatomic, strong ,readonly) CAGradientLayer *gradientLayer2;

//Progress color when gradient effect is disable [!!!do no use clearColor]
@property (nonatomic, strong) IBInspectable UIColor *progressColor;

//Progress line width
@property (nonatomic, assign) IBInspectable CGFloat progressLineWidth;

//Start angle
@property (nonatomic, assign) IBInspectable int startAngle;

//End angle
@property (nonatomic, assign) IBInspectable int endAngle;

//Progress [0.0-1.0]
@property (nonatomic, assign) IBInspectable CGFloat progress;

//Delegate
@property (nonatomic, weak) IBOutlet id<XMCurveProgressViewDelegate> delegate;

/**
 *  Set progress
 *
 *  @param progress progress[0.0-1.0]
 *  @param animated enbale animation?
 */
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
