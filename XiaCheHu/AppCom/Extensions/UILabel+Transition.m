//
//  UILabel+Transition.m
//  GifSender
//
//  Created by cyan on 15/2/15.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "UILabel+Transition.h"

@implementation UILabel (Transition)

- (void)updateText:(NSString *)text {
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.text = text;
    } completion:^(BOOL finished) {
    }];
}

@end
