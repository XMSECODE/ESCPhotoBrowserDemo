//
//  ESCNavigationControllerAnimation.h
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/12/5.
//  Copyright © 2018 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESCNavigationControllerAnimation : NSObject <UIViewControllerInteractiveTransitioning,UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)BOOL navigationBarIsHidden;

@end

NS_ASSUME_NONNULL_END
