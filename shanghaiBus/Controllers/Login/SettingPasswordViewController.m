//
//  SettingPasswordViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/1.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "SettingPasswordViewController.h"
#import "WebImageView.h"

@interface SettingPasswordViewController ()

@property (nonatomic, strong) WebImageView *imageView;
@property (nonatomic, strong) UITextField *textPassword;
@property (nonatomic, strong) UIButton *buttonSubmit;

@end

@implementation SettingPasswordViewController
#pragma mark - getter&&setter

- (WebImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[WebImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon_phone"];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UITextField *)textPassword {
    if (_textPassword == nil) {
        _textPassword = [[UITextField alloc] init];
    }
    return _textPassword;
}

- (UIButton *)buttonSubmit {
    if (_buttonSubmit == nil) {
        _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSubmit setBackgroundImage:[UIImage imageNamed:@"icon_login_nomal"] forState:UIControlStateNormal];
        [_buttonSubmit addTarget:self action:@selector(didClickSetPassword) forControlEvents:UIControlEventTouchUpInside];
        [_buttonSubmit setTitle:@"确定设置" forState:UIControlStateNormal];
        _buttonSubmit.selected = NO;
    }
    return _buttonSubmit;
}

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initData {
    
}

- (void)initUI {
    self.imageView.frame = CGRectMake(10, 80, SCREENWIDTH - 20, 44);
    [self.view addSubview:self.imageView];
    
    self.textPassword.frame = CGRectMake(10, 2, SCREENWIDTH - 40, 40);
    self.textPassword.placeholder = @"输入新密码";
    [self.imageView addSubview:self.textPassword];
    
    self.buttonSubmit.frame = CGRectMake(10, self.imageView.ctBottom + 20, SCREENWIDTH - 20, 44);
    [self.view addSubview:self.buttonSubmit];
    
}

- (void)didClickSetPassword {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
