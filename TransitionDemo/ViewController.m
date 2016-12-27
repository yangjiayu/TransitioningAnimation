//
//  ViewController.m
//  TransitionDemo
//
//  Created by yang on 2016/12/27.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "ViewController.h"
#import "ToViewController.h"
#import "DismissAnimation.h"
#import "PresentAnimation.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) DismissAnimation *dismissAnimation;
@property (nonatomic, strong) PresentAnimation *presentAnimation;

@end

@implementation ViewController

- (DismissAnimation *)dismissAnimation {
    if (!_dismissAnimation) {
        _dismissAnimation = [[DismissAnimation alloc] init];
    }
    return _dismissAnimation;
}

- (PresentAnimation *)presentAnimation {
    if (!_presentAnimation) {
        _presentAnimation = [[PresentAnimation alloc] init];
    }
    return _presentAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonClick:(id)sender {
    ToViewController *toViewController = [[ToViewController alloc] init];
    toViewController.transitioningDelegate = self;
    [self presentViewController:toViewController animated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}


@end
