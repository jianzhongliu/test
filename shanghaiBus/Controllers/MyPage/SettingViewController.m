//
//  SettingViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYBackColor;
    [self initUI];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self setTitle:@"设置"];
    
}

- (void)initData {
    
}

- (void)initUI {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - action && private Methods
- (void)didDismissMyInfo {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSaveInfo {
    
    [self didDismissMyInfo];
}

@end
