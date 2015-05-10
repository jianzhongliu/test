//
//  UploadServiceViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UploadServiceViewController.h"
#import "UploadInfoCommonInputView.h"
#import "ImageScrollView.h"

@interface UploadServiceViewController ()

@end

@implementation UploadServiceViewController

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
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(didSaveInfo)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self setTitle:@"发布服务信息"];
    
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
