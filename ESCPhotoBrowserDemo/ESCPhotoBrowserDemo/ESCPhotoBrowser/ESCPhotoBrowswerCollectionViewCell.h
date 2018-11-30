//
//  ESCPhotoBrowswerCollectionViewCell.h
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/11/29.
//  Copyright © 2018 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ESCPhotoBrowswerCollectionViewCellId = @"ESCPhotoBrowswerCollectionViewCellId";

@class ESCPhotoBrowswerCollectionViewCell;

@protocol ESCPhotoBrowswerCollectionViewCellDelegate <NSObject>

- (void)ESCPhotoBrowswerCollectionViewCell:(ESCPhotoBrowswerCollectionViewCell *)cell didTouchLongpressWithImagePath:(NSString *)imagePath;
- (void)ESCPhotoBrowswerCollectionViewCell:(ESCPhotoBrowswerCollectionViewCell *)cell didTouchTapWithImagePath:(NSString *)imagePath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ESCPhotoBrowswerCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)id delegate;

@property(nonatomic,copy)NSString* imageLocalPath;

@property(nonatomic,copy)NSString* imageURLPath;

@end

NS_ASSUME_NONNULL_END
