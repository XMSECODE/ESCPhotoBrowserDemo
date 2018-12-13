//
//  ViewController.m
//  ESCPhotoBrowserDemo
//
//  Created by xiang on 2018/11/27.
//  Copyright © 2018 xiang. All rights reserved.
//

#import "ViewController.h"
#import "ESCPhotoBrowser/ESCPhotoBrowserViewController.h"

@interface ViewController () <ESCPhotoBrowserViewControllerDataSource>

@property(nonatomic,strong)NSArray* imageURLArray;

@property(nonatomic,strong)NSArray* imagePathArray;

@property(nonatomic,assign)int type;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"photo";
    
    self.imageURLArray = @[@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2168427908,4072089613&fm=200&gp=0.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543493134293&di=4a1e37930bca38f792b34bde0df78423&imgtype=0&src=http%3A%2F%2Ffile29.mafengwo.net%2FM00%2F7B%2F34%2FwKgBpVYdGOiAS71LAABuKaLQB_887.groupinfo.w600.jpeg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543493134292&di=f75f982b1e0c96ea78d36b1f92d9d934&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F574ddb5egw1eqosahw1m6j20pa0g00w3.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543493134290&di=838d4ba16ffb6593d5b96ddec1eb28bc&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2Fc146a59aab8e736f8c7d9a3a8217d0295c301180.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543493134286&di=ff29d4ea4ab6f65a77a91cd877277a35&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D46de93bfc711728b24208461a095a9bb%2F4610b912c8fcc3ce5423d51d9845d688d43f2038.jpg"];
    

    NSMutableArray *temArray = [NSMutableArray array];
    for (int i = 1; i <= 8; i++) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"test%d.jpg",i] ofType:nil];
        [temArray addObject:filePath];
    }
    self.imagePathArray = [temArray copy];
}

- (IBAction)didClickButton:(id)sender {
    self.type = 0;
    ESCPhotoBrowserViewController *controller = [[ESCPhotoBrowserViewController alloc] init];
    controller.dataSource = self;
    controller.rightButtonTitle = @"分享";
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)didClickLocalPhotoButton:(id)sender {
    self.type = 1;
    ESCPhotoBrowserViewController *controller = [[ESCPhotoBrowserViewController alloc] init];
    controller.dataSource = self;
    controller.rightButtonTitle = @"分享";
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - ESCPhotoBrowserViewControllerDataSource
- (NSInteger)numberOfItemsInPhotoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController {
    if (self.type == 0) {
        return self.imageURLArray.count;
    }else {
        return self.imagePathArray.count;
    }
    
}

- (ESCPhotoBroswerImageType)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController typeWithIndex:(NSInteger)index {
    if (self.type == 0) {
        return ESCPhotoBroswerImageTypeNet;
    }else {
        return ESCPhotoBroswerImageTypeLocal;
    }
}

- (NSString *)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController pathWithIndex:(NSInteger)index {
    if (self.type == 0) {
        return [self.imageURLArray objectAtIndex:index];
    }else {
        return [self.imagePathArray objectAtIndex:index];
    }
}

- (void)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController didClickRightButtonItemIndex:(NSInteger)index {

}

- (void)photoBroswerViewController:(ESCPhotoBrowserViewController *)photoBroswerViewController didTouchLongIndex:(NSInteger)index {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"分享" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:action];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
