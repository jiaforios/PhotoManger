//
//  CustomPopAnimation.m
//  PhotoManger
//
//  Created by foscom on 16/6/21.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "CustomPopAnimation.h"

@implementation CustomPopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 目的VC
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 起始VC
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 添加 toview  到上下文
    [[transitionContext containerView] insertSubview:toVc.view belowSubview:fromVc.view];
    
    // 自定义动画
    
    //    toVc.view.transform = CGAffineTransformMakeTranslation(375, 667);
    toVc.view.transform  = CGAffineTransformMakeScale(5, 5);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        
        //        fromVc.view.transform = CGAffineTransformMakeTranslation(-375, -667);
        
        fromVc.view.transform  = CGAffineTransformMakeScale(0, 0);
        
        toVc.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        toVc.view.transform = CGAffineTransformIdentity;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
    
}

@end
