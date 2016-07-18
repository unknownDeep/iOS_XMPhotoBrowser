//
//  ViewController.m
//  XMPhotoBrowser
//
//  Created by zhanghao on 16/7/18.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ViewController.h"
#import "XMPhotoBrowserController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickBtn:(id)sender {
    XMPhotoBrowserController *controller = [XMPhotoBrowserController controllerWithImagesUrl:
  @[
    @"http://protect-app.oss-cn-beijing.aliyuncs.com/photos/1326937734117b0b2f52f6b99f1639a993dafd5a5b60d.jpeg",
    @"http://protect-app.oss-cn-beijing.aliyuncs.com/photos/1326937841307b0b2f52f6b99f1639a993dafd5a5b60d.jpeg",
    @"http://protect-app.oss-cn-beijing.aliyuncs.com/photos/1326937876254b0b2f52f6b99f1639a993dafd5a5b60d.jpeg",
    @"http://protect-app.oss-cn-beijing.aliyuncs.com/photos/1326938275349b0b2f52f6b99f1639a993dafd5a5b60d.jpeg",
    @"http://protect-app.oss-cn-beijing.aliyuncs.com/photos/1326940935926b0b2f52f6b99f1639a993dafd5a5b60d.jpeg"
                                                                                               
                                                                                               ]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
