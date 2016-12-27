//
//  DismissAnimation.m
//  TransitionDemo
//
//  Created by yang on 2016/10/27.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "DismissAnimation.h"
#import "TransitionProtocol.h"

@implementation DismissAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController<TransitionProtocol> *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //    NSAssert([fromViewController isKindOfClass:[CTYBarCodeViewController class]], @"fromViewController MUST be 'CTYBarCodeViewController'");
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:fromViewController.dimmingBackgroundView belowSubview:fromViewController.view];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.dimmingBackgroundView];
    [fromViewController.snapshotBackgroundView removeFromSuperview];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    fromViewController.view.layer.transform = CATransform3DIdentity;
    [UIView animateWithDuration:duration animations:^{
        fromViewController.dimmingBackgroundView.alpha = 0.0f;
        fromViewController.view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        fromViewController.view.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
