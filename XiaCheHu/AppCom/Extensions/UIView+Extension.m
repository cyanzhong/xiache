//
//  UIView+Extension.m
//  XiaCheHu
//
//  Created by cyan on 14/11/30.
//  Copyright (c) 2014年 FunCube. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGRect)rect
{
    return (CGRect){ 0, 0, self.width, self.height };
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)setSize:(CGSize)size center:(CGPoint)center
{
    self.frame = CGRectMake(center.x-size.width/2, center.y-size.height/2, size.width, size.height);
}

- (void)setWidth:(CGFloat)w height:(CGFloat)h
{
    [self setSize:CGSizeMake(w, h)];
}

- (void)setWidth:(CGFloat)width {
    [self setWidth:width height:self.height];
}

- (void)setHeight:(CGFloat)height {
    [self setWidth:self.width height:height];
}

- (void)setX:(CGFloat)x y:(CGFloat)y
{
    CGRect frame = { x, y, self.width, self.height };
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)halfHeight
{
    return self.height * 0.5;
}

- (CGFloat)halfWidth
{
    return self.width * 0.5;
}

- (CGFloat)left
{
    return self.x;
}

- (CGFloat)right
{
    return self.x + self.width;
}

- (CGFloat)top
{
    return self.y;
}

- (CGFloat)bottom
{
    return self.y + self.height;
}

- (void)fitCenter
{
    CGPoint rawCenter = self.center;
    [self sizeToFit];
    self.center = rawCenter;
}

- (void)fitLeft
{
    CGFloat x = self.x;
    CGFloat y = self.centerY;
    [self sizeToFit];
    [self setX:x y:y-self.halfHeight];
}

- (void)fitRight
{
    CGFloat x = self.right;
    CGFloat y = self.centerY;
    [self sizeToFit];
    [self setX:x-self.width y:y-self.halfHeight];
}

- (void)fadeOut
{
    if (self.alpha == 0.0f)
        return;
    
    [UIView animateWithDuration:.2f animations:^{
        self.alpha = 0.0f;
    }];
}

- (void)fadeIn
{
    if (self.alpha == 1.0f)
        return;
    
    [UIView animateWithDuration:.2f animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)dissolveIn {
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dissolveOut {
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (UIImage *)capturedImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)capturedLowQualityImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)capturedImageInRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)removeSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)rasterize {
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)clipsToCircle {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.width/2;
}

- (CGRect)rectInScale:(CGFloat)scale {
    return CGRectMake(self.center.x-self.width*scale/2.0, self.center.y-self.height*scale/2.0, self.width*scale, self.height*scale);
}

- (void)scaleTo:(CGFloat)scale {
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
}

- (CGFloat)scaleWidthTo:(CGFloat)width {
    CGFloat scale = (width / self.width);
    [self setWidth:width height:self.height*scale];
    return scale;
}

- (CGFloat)scaleHeightTo:(CGFloat)height {
    CGFloat scale = (height / self.height);
    [self setWidth:self.width*scale height:height];
    return scale;
}

- (void)showBorder:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)showShadow:(UIColor *)color radius:(CGFloat)radius {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 0.5;
}

- (void)removeShadow {
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.layer.shadowOpacity = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animateCornerRadiusTo:(CGFloat)radius {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.fromValue = [NSNumber numberWithFloat:self.layer.cornerRadius];
    anim.toValue = [NSNumber numberWithFloat:radius];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = 3;
    [self.layer addAnimation:anim forKey:@"cornerRadius"];
}

- (void)shake {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, -5.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 5.0f, 0.0f)]];
    anim.autoreverses = YES;
    anim.repeatCount = 1;
    anim.duration = 0.07f;
    [self.layer addAnimation:anim forKey:nil];
}


@end
