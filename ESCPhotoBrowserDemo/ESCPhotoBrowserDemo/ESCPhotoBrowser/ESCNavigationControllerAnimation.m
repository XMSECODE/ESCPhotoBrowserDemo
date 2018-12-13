//
//  ESCNavigationControllerAnimation.m
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/12/5.
//  Copyright © 2018 xiang. All rights reserved.
//

#import "ESCNavigationControllerAnimation.h"

@interface ESCNavigationControllerAnimation ()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, weak) UIViewController  *fromViewController;

@property (nonatomic, weak) UIViewController  *toViewController;

@property (nonatomic, weak) UIView            *containerView;

@end

@implementation ESCNavigationControllerAnimation

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];

    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    fromView.frame = CGRectMake(0, 0, screen_width / 2, screen_height);
    
    if (self.navigationBarIsHidden == YES) {
        self.fromViewController.navigationController.navigationBar.alpha = 0;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.frame = CGRectMake(0, screen_height, screen_width / 2, screen_height);
            fromView.alpha = 0;
        } completion:^(BOOL finished) {

        }];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] / 2 delay:[self transitionDuration:transitionContext] / 2 options:UIViewAnimationOptionTransitionNone animations:^{
            self.toViewController.navigationController.navigationBar.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] / 2 animations:^{
            fromView.frame = CGRectMake(0, screen_height, screen_width, screen_height);
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    
    
}


@end
