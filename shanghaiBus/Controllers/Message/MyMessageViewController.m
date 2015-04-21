//
//  MyMessageViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/18.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MyMessageViewController.h"
#import "Config.h"

@implementation MyMessageViewController
#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYColor;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self setTitle:@"我的消息"];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.viewX = SCREENWIDTH;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.viewX = 0;
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)initData {
    
}

- (void)initUI {
    
}

@end
