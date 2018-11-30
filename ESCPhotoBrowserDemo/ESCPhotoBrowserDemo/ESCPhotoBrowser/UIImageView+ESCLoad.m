//
//  UIImageView+ESCLoad.m
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/11/30.
//  Copyright © 2018 xiang. All rights reserved.
//

#import "UIImageView+ESCLoad.h"
#import <objc/runtime.h>

@implementation UIImageView (ESCLoad)


- (void)local_imageViewWithImagePath:(NSString *)imagePath {
    
    
    if ([imagePath isEqualToString:[self getLastImagePath]]) {
        return;
    }
    
    [self setImagePath:imagePath];
    static dispatch_queue_t staticQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticQueue = dispatch_queue_create("loadImageQueue", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(staticQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([imagePath isEqualToString:[self getLastImagePath]]) {
                self.image = [UIImage imageWithData:imageData];
            }else {
                //                self.image = nil;
            }
        });
        
    });
}

static const char *KLFX_ImageView_KEY = "KLFX_ImageView_KEY";

- (void)setImagePath:(NSString *)imagePath {
    objc_setAssociatedObject(self, KLFX_ImageView_KEY, imagePath, OBJC_ASSOCIATION_COPY_NONATOMIC );
}

- (NSString *)getLastImagePath {
    return objc_getAssociatedObject(self, KLFX_ImageView_KEY);
}
@end
