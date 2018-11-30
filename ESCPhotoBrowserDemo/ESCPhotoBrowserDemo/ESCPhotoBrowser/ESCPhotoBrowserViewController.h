//
//  ESCPhotoBrowserViewController.h
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/11/29.
//  Copyright © 2018 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESCPhotoBrowserViewController;

typedef enum : NSUInteger {
    ESCPhotoBroswerImageTypeNet,
    ESCPhotoBroswerImageTypeLocal
} ESCPhotoBroswerImageType;


@protocol ESCPhotoBrowserViewControllerDataSource <NSObject>

- (NSInteger)numberOfItemsInPhotoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController;

- (ESCPhotoBroswerImageType)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController typeWithIndex:(NSInteger)index;

- (NSString *)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController pathWithIndex:(NSInteger)index;

- (void)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController didClickRightButtonItemIndex:(NSInteger)index;

- (void)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController didTouchLongIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_BEGIN

@interface ESCPhotoBrowserViewController : UIViewController

@property(nonatomic,weak)id<ESCPhotoBrowserViewControllerDataSource> dataSource;

@property(nonatomic,assign)int currentIndex;

@property(nonatomic,copy)NSString* rightButtonTitle;


@end

NS_ASSUME_NONNULL_END
