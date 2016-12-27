//
//  PresentAnimation.m
//  TransitionDemo
//
//  Created by yang on 2016/12/27.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "PresentAnimation.h"
#import "TransitionProtocol.h"

@implementation PresentAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController<TransitionProtocol> *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //    NSAssert([toViewController isKindOfClass:[CTYBarCodeViewController class]], @"toViewController MUST be 'CTYBarCodeViewController'");
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromViewController.view];
    
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:YES];
    snapshotView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *dimmingView = [[UIView alloc] init];
    dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    dimmingView.alpha = 0.0;
    dimmingView.frame = containerView.bounds;
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [containerView insertSubview:dimmingView aboveSubview:fromViewController.view];
    
    [containerView addSubview:toViewController.view];
    [UIView animateWithDuration:0.25 animations:^{
        dimmingView.alpha = 1.0f;
    }];
    
    toViewController.view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
    toViewController.view.alpha = 0.0f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            
            toViewController.view.alpha = 1.0f;
            toViewController.view.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            snapshotView.frame = toViewController.view.bounds;
            [toViewController.view insertSubview:snapshotView atIndex:0];
            [toViewController.view insertSubview:dimmingView aboveSubview:snapshotView];
            toViewController.snapshotBackgroundView = snapshotView;
            toViewController.dimmingBackgroundView = dimmingView;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    });
}

@end
