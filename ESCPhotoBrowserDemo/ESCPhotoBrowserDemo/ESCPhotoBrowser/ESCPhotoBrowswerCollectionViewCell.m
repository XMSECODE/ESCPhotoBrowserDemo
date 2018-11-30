//
//  ESCPhotoBrowswerCollectionViewCell.m
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/11/29.
//  Copyright © 2018 xiang. All rights reserved.
//

#import "ESCPhotoBrowswerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+ESCLoad.h"

@interface ESCPhotoBrowswerCollectionViewCell () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ESCPhotoBrowswerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentScrollView.delegate = self;
    self.contentScrollView.maximumZoomScale = 5;
    self.contentScrollView.minimumZoomScale = 1;
    
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 11) {
        self.contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
        
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(touchLongPress)];
    gesture.minimumPressDuration = 1.5;
    [self addGestureRecognizer:gesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGesture)];
    [self addGestureRecognizer:tapGesture];
}

- (void)didTapGesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ESCPhotoBrowswerCollectionViewCell:didTouchTapWithImagePath:)]) {
        if (self.imageLocalPath) {
            [self.delegate ESCPhotoBrowswerCollectionViewCell:self didTouchTapWithImagePath:self.imageLocalPath];
        }else {
            [self.delegate ESCPhotoBrowswerCollectionViewCell:self didTouchTapWithImagePath:self.imageURLPath];
        }
    }
}

- (void)touchLongPress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ESCPhotoBrowswerCollectionViewCell:didTouchLongpressWithImagePath:)]) {
        if (self.imageLocalPath) {
            [self.delegate ESCPhotoBrowswerCollectionViewCell:self didTouchLongpressWithImagePath:self.imageLocalPath];
        }else {
            [self.delegate ESCPhotoBrowswerCollectionViewCell:self didTouchLongpressWithImagePath:self.imageURLPath];
        }
    }
}


#pragma mark - UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)setImageURLPath:(NSString *)imageURLPath {
    self.contentScrollView.zoomScale = 1;
    _imageURLPath = [imageURLPath copy];
    NSURL *url = [NSURL URLWithString:imageURLPath];
    [self.imageView sd_setImageWithURL:url];
}

- (void)setImageLocalPath:(NSString *)imageLocalPath {
    _imageLocalPath = [imageLocalPath copy];
    self.contentScrollView.zoomScale = 1;
    [self.imageView local_imageViewWithImagePath:imageLocalPath];
}

@end
