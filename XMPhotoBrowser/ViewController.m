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
    XMPhotoBrowserController *controller = [XMPhotoBrowserController controller];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
