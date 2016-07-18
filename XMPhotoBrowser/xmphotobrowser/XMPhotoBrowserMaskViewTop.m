//
//  XMPhotoBrowserMaskViewTop.m
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/17.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "XMPhotoBrowserMaskViewTop.h"

@interface XMPhotoBrowserMaskViewTop()

@property (nonatomic, strong) UIView *superView;

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UILabel *labelTitle;

@end
@implementation XMPhotoBrowserMaskViewTop

+ (instancetype)viewWithSuperView:(UIView *)superView{
    XMPhotoBrowserMaskViewTop *view = [[XMPhotoBrowserMaskViewTop alloc] init];
    view.superView = superView;
    
    [view initial];
    return view;
}

- (void)initial{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.viewHeight);
    self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.7];
    
    [self addSubview:self.btnLeft];
    
    [self addSubview:self.labelTitle];
    
    [self addSubview:self.btnRight];
    
    [self.superView addSubview:self];
}

- (void)onClickBtnLeft:(UIButton*)sender{
    if (self.delegateMaskView) {
        if ([self.delegateMaskView respondsToSelector:@selector(xmPhotoBrowserMaskViewTop:onClickBtnLeft:)]) {
            [self.delegateMaskView xmPhotoBrowserMaskViewTop:self onClickBtnLeft:sender];
        }
    }
}

- (void)onClickBtnRight:(UIButton*)sender{
    if (self.delegateMaskView) {
        if ([self.delegateMaskView respondsToSelector:@selector(xmPhotoBrowserMaskViewTop:onClickBtnLeft:)]) {
            [self.delegateMaskView xmPhotoBrowserMaskViewTop:self onClickBtnLeft:sender];
        }
    }
}

- (void)makeViewHidden:(BOOL)hidden{
    [UIView animateWithDuration:0.25 animations:^{
        if (hidden) {
            self.frame = CGRectMake(0, -self.viewHeight, [UIScreen mainScreen].bounds.size.width, self.viewHeight);
        }else{
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.viewHeight);
        }
        [self layoutIfNeeded];
    }];
}

- (void)setViewTitle:(NSString*)title{
    [self.labelTitle setText:title];
}

- (void)setBtnLeftWithImage:(UIImage *)image{
    [self.btnLeft setImage:image forState:UIControlStateNormal];
}

- (void)setBtnLeftWithTitle:(NSString *)title{
    [self.btnLeft setTitle:title forState:UIControlStateNormal];
}

- (void)setBtnRightWithImage:(UIImage *)image{
    [self.btnRight setImage:image forState:UIControlStateNormal];
}

- (void)setBtnRightWithTitle:(NSString *)title{
    [self.btnRight setTitle:title forState:UIControlStateNormal];
}

- (CGFloat)viewHeight{
    return 64;
}
//=============================================================================
#pragma mark - 懒加载控件
- (UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
        [_btnLeft addTarget:self action:@selector(onClickBtnLeft:) forControlEvents:UIControlEventTouchUpInside];
        [_btnLeft setImage:[UIImage imageNamed:@"xmphotobrowser_back"] forState:UIControlStateNormal];
        [_btnLeft setTitle:@"返回" forState:UIControlStateNormal];
        [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnLeft;
}

- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 20, 60, 44)];
        [_btnRight addTarget:self action:@selector(onClickBtnRight:) forControlEvents:UIControlEventTouchUpInside];
        [_btnRight setImage:[UIImage imageNamed:@"xmphotobrowser_more"] forState:UIControlStateNormal];
        [_btnRight setTitle:@"" forState:UIControlStateNormal];
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnRight;
}

- (UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, [UIScreen mainScreen].bounds.size.width-120, 44)];
        _labelTitle.text = @"0 of 0";
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:[UIColor whiteColor]];
    }
    return _labelTitle;
}

@end
