//
//  TouristBaseInfoViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristBaseInfoViewController.h"

@interface TouristBaseInfoViewController ()

@end

@implementation TouristBaseInfoViewController

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
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didSaveInfo)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self setTitle:@"商家信息"];
    
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
