//
//  ESCPhotoBrowserViewController.m
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/11/29.
//  Copyright © 2018 xiang. All rights reserved.
//

#import "ESCPhotoBrowserViewController.h"
#import "ESCPhotoBrowswerCollectionViewCell.h"
#import "ESCNavigationControllerAnimation.h"

@interface ESCPhotoBrowserViewController () <UICollectionViewDelegate, UICollectionViewDataSource,ESCPhotoBrowswerCollectionViewCellDelegate, UINavigationControllerDelegate>

@property(nonatomic,weak)UICollectionView* collectionView;

@property(nonatomic,weak)UICollectionViewFlowLayout* flowLayout;

@property(nonatomic,assign)BOOL isHiddenNavigationBar;

@property(nonatomic,assign)CGRect navigationBarFrame;

@property(nonatomic,assign)BOOL animationCompleted;

@property(nonatomic,weak)UISwipeGestureRecognizer* popSwipeGesture;

@end

@implementation ESCPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setGesture];
    
    self.navigationController.delegate = self;

}

- (void)setGesture {
    UISwipeGestureRecognizer *popSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePopToViewController)];
    popSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:popSwipeGesture];
    self.popSwipeGesture = popSwipeGesture;
}

- (void)gesturePopToViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    [self setupCollectionView];
    
    if (self.rightButtonTitle) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.rightButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightButton)];
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.animationCompleted = YES;

}

- (void)setupCollectionView {

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    self.flowLayout.itemSize = CGSizeMake(screenWidth, screenHeight);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ESCPhotoBrowswerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ESCPhotoBrowswerCollectionViewCellId];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource) {
        return [self.dataSource numberOfItemsInPhotoBroswerViewController:self];
    }else {
        return 0;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ESCPhotoBrowswerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ESCPhotoBrowswerCollectionViewCellId forIndexPath:indexPath];
    ESCPhotoBroswerImageType type = [self.dataSource photoBroswerViewController:self typeWithIndex:indexPath.item];
    if (type == ESCPhotoBroswerImageTypeNet) {
        cell.imageURLPath = [self.dataSource photoBroswerViewController:self pathWithIndex:indexPath.item];
    }else {
        cell.imageLocalPath = [self.dataSource photoBroswerViewController:self pathWithIndex:indexPath.item];
    }
    cell.delegate = self;
    return cell;
}

- (BOOL)prefersStatusBarHidden {
    return self.isHiddenNavigationBar;
}

#pragma mark - ESCPhotoBrowswerCollectionViewCellDelegate
- (void)ESCPhotoBrowswerCollectionViewCell:(ESCPhotoBrowswerCollectionViewCell *)cell didTouchTapWithImagePath:(NSString *)imagePath {
    if (self.animationCompleted == NO) {
        return;
    }
    self.animationCompleted = NO;
    if (self.isHiddenNavigationBar) {
        self.isHiddenNavigationBar = NO;
        [UIView animateWithDuration:0.5 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.frame = self.navigationBarFrame;
            self.navigationController.navigationBar.alpha = 1;
        } completion:^(BOOL finished) {
            self.animationCompleted = YES;
        }];
        
    }else {
        self.isHiddenNavigationBar = YES;
        
        [UIView animateWithDuration:0.5 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.alpha = 0;
            CGRect frame = self.navigationController.navigationBar.frame;
            self.navigationBarFrame = frame;
            frame.origin.y = -frame.size.height;
            self.navigationController.navigationBar.frame = frame;
        } completion:^(BOOL finished) {
            
            self.animationCompleted = YES;
        }];
    }
}

- (void)ESCPhotoBrowswerCollectionViewCell:(ESCPhotoBrowswerCollectionViewCell *)cell didTouchLongpressWithImagePath:(NSString *)imagePath {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBroswerViewController:didTouchLongIndex:)]) {
        NSInteger currentIndex = self.collectionView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        [self.dataSource photoBroswerViewController:self didTouchLongIndex:currentIndex];
    }
}

- (void)didClickRightButton {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(photoBroswerViewController:didClickRightButtonItemIndex:)]) {
        NSInteger currentIndex = self.collectionView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
        [self.dataSource photoBroswerViewController:self didClickRightButtonItemIndex:currentIndex];
    }
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    if(operation == UINavigationControllerOperationPop) {
        ESCNavigationControllerAnimation *animation = [[ESCNavigationControllerAnimation alloc] init];
        animation.navigationBarIsHidden = self.isHiddenNavigationBar;
        return animation;
    }
    return nil;
}

@end
