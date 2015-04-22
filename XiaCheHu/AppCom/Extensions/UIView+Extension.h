//
//  UIView+Extension.h
//  XiaCheHu
//
//  Created by cyan on 14/11/30.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//  封装了一些UIView的快捷方法

#import <UIKit/UIKit.h>

@interface UIView (Extension)

- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;
- (CGRect)rect;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (void)setSize:(CGSize)size;
- (void)setWidth:(CGFloat)w height:(CGFloat)h;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setX:(CGFloat)x y:(CGFloat)y;
- (void)setSize:(CGSize)size center:(CGPoint)center;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)halfWidth;
- (CGFloat)halfHeight;
- (void)fitLeft;
- (void)fitCenter;
- (void)fitRight;
- (void)fadeIn;
- (void)fadeOut;
- (void)dissolveIn;
- (void)dissolveOut;
- (UIImage *)capturedImage;
- (UIImage *)capturedLowQualityImage; // 截取低质量的图片用于做高斯模糊
- (UIImage *)capturedImageInRect:(CGRect)rect;
- (void)removeSubviews;
- (void)rasterize;
- (void)clipsToCircle;  // 裁剪成圆形

- (CGRect)rectInScale:(CGFloat)scale;
- (void)scaleTo:(CGFloat)scale;

- (CGFloat)scaleWidthTo:(CGFloat)width;
- (CGFloat)scaleHeightTo:(CGFloat)height;

- (void)showBorder:(UIColor *)color width:(CGFloat)width;
- (void)showShadow:(UIColor *)color radius:(CGFloat)radius;
- (void)removeShadow;

- (void)animateCornerRadiusTo:(CGFloat)radius;

- (void)shake;

@end
