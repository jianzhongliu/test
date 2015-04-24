//
//  SettingViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "SettingViewController.h"
#import "UserCachBean.h"

@interface SettingViewController () <UIAlertViewDelegate>

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
    
    UIView *viewMessage= [[UIView alloc] initWithFrame:CGRectMake(0, 90, SCREENWIDTH, 90)];
    viewMessage.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:viewMessage];
    
    UILabel *labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    labelMessage.text = @"推送消息";
    labelMessage.font = [UIFont systemFontOfSize:14];
    [viewMessage addSubview:labelMessage];
    
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - 60, 5, 40, 30)];
    [viewMessage addSubview:switchView];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, labelMessage.ctBottom + 7, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    [viewMessage addSubview:viewLine];
    
    UIButton *buttonClear = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonClear.frame = CGRectMake(10, labelMessage.ctBottom + 14, SCREENWIDTH - 20, 30);
    [buttonClear setTitle:@"清楚缓存" forState:UIControlStateNormal];
    [buttonClear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonClear addTarget:self action:@selector(didClearCache) forControlEvents:UIControlEventTouchUpInside];
    [buttonClear setBackgroundColor:[UIColor whiteColor]];
    buttonClear.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonClear.titleLabel.font = [UIFont systemFontOfSize:14];
    [viewMessage addSubview:buttonClear];
    
    UIButton *buttonExit = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonExit.tag = 101;
    buttonExit.frame = CGRectMake(10, viewMessage.ctBottom + 20, SCREENWIDTH - 20, 45);
    [buttonExit setTitle:@"退出登录" forState:UIControlStateNormal];
    [buttonExit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonExit addTarget:self action:@selector(didLoginOut) forControlEvents:UIControlEventTouchUpInside];
    [buttonExit setBackgroundColor:[UIColor whiteColor]];
    
    if ([[UserCachBean share] isLogin]) {
        [self.view addSubview:buttonExit];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didClearCache {
    [self showInfo:@"缓存已清空"];
}

- (void)didLoginOut {
    
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出吗" delegate:self cancelButtonTitle:@"点错了" otherButtonTitles:@"退出", nil];
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [UserCachBean share].touristInfo = nil;
        UIButton *but = (UIButton *)[self.view viewWithTag:101];
        but.hidden = YES;
    }
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
