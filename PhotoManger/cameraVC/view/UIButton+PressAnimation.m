//
//  UIButton+PressAnimation.m
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "UIButton+PressAnimation.h"

@implementation UIButton (PressAnimation)


- (void)pressAnimation
{
    CABasicAnimation *animtions = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animtions.fromValue = [NSNumber numberWithFloat:1];
    animtions.toValue = [NSNumber numberWithFloat:1.2];
    animtions.duration = 0.3;
    animtions.autoreverses = YES;
    
    [self.layer addAnimation:animtions forKey:@"pressAnimation"];
    
}

@end
