//
//  CustomPushAnimation.m
//  PhotoManger
//
//  Created by foscom on 16/6/18.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "CustomPushAnimation.h"

@implementation CustomPushAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 3.f;
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
    
    toVc.view.transform = CGAffineTransformMakeTranslation(375, 667);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
       
        fromVc.view.transform = CGAffineTransformMakeTranslation(-375, -667);
        toVc.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        
        fromVc.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:[transitionContext transitionWasCancelled]];
        
    }];
    
    
}
@end
