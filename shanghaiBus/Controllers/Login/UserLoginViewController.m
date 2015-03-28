//
//  UserLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UserLoginViewController.h"
#import "PhoneLoginViewController.h"

@interface UserLoginViewController ()

@property (nonatomic, strong) UIButton *buttonWX;
@property (nonatomic, strong) UIButton *buttonQQ;
@property (nonatomic, strong) UIButton *buttonSina;

@property (nonatomic, strong) UIButton *buttonMore;
@property (nonatomic, strong) UIButton *buttonPhone;

@end

@implementation UserLoginViewController

- (UIButton *)buttonWX {
    if (_buttonWX == nil) {
        _buttonWX = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonWX setBackgroundImage:[UIImage imageNamed:@"icon_login"] forState:UIControlStateNormal];
        [_buttonWX setTitle:@"微信登录" forState:UIControlStateNormal];
        [_buttonWX addTarget:self action:@selector(loginWX) forControlEvents:UIControlEventTouchUpInside];
        _buttonWX.selected = NO;
    }
    return _buttonWX;
}

- (UIButton *)buttonQQ {
    if (_buttonQQ == nil) {
        _buttonQQ = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonQQ setBackgroundImage:[UIImage imageNamed:@"icon_login_nomal"] forState:UIControlStateNormal];
        [_buttonQQ setTitle:@"QQ登录" forState:UIControlStateNormal];
        [_buttonQQ addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
        _buttonQQ.selected = NO;
    }
    return _buttonQQ;
}

- (UIButton *)buttonSina {
    if (_buttonSina == nil) {
        _buttonSina = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSina setBackgroundImage:[UIImage imageNamed:@"icon_sina_login"] forState:UIControlStateNormal];
        [_buttonSina setTitle:@"新浪微博" forState:UIControlStateNormal];
        [_buttonSina addTarget:self action:@selector(loginSina) forControlEvents:UIControlEventTouchUpInside];
        _buttonSina.selected = NO;
        _buttonSina.alpha = 0;
    }
    return _buttonSina;
}

- (UIButton *)buttonMore {
    if (_buttonMore == nil) {
        _buttonMore = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonMore addTarget:self action:@selector(loginMore:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonMore setTitle:@"更多选项..." forState:UIControlStateNormal];
        [_buttonMore setTitle:@"更少选项..." forState:UIControlStateSelected];
        _buttonMore.font = [UIFont systemFontOfSize:13];
        _buttonMore.selected = NO;
    }
    return _buttonMore;
}

- (UIButton *)buttonPhone {
    if (_buttonPhone == nil) {
        _buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonPhone setBackgroundImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
        [_buttonPhone setBackgroundImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateHighlighted];
        [_buttonPhone setTitle:@"手机号码" forState:UIControlStateNormal];
        [_buttonPhone setTitleColor:BYColorAlphaMake(0, 0, 0, 0.6) forState:UIControlStateNormal];
        [_buttonPhone setTitleEdgeInsets:UIEdgeInsetsMake(0, -SCREENWIDTH / 2, 0, 0)];
        [_buttonPhone addTarget:self action:@selector(loginPhone) forControlEvents:UIControlEventTouchDown];
        _buttonPhone.selected = NO;
    }
    return _buttonPhone;
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
    self.buttonBack.hidden = YES;

    [self resetFrame];
    
    [self.view addSubview:self.buttonWX];
    [self.view addSubview:self.buttonQQ];
    [self.view addSubview:self.buttonSina];
    [self.view addSubview:self.buttonMore];
    [self.view addSubview:self.buttonPhone];
    
}

- (void)resetFrame {
    self.buttonWX.frame = CGRectMake(10, 60, SCREENWIDTH - 20, 44);
    
    
    self.buttonQQ.frame = CGRectMake(10, self.buttonWX.ctBottom + 10, SCREENWIDTH - 20, 44);
    
    self.buttonMore.frame = CGRectMake((SCREENWIDTH - 80) /2, self.buttonQQ.ctBottom + 10, 80, 20);
    
    self.buttonSina.frame = CGRectMake(10, self.buttonQQ.ctBottom + 10, SCREENWIDTH - 20, 44);
    
    self.buttonPhone.frame = CGRectMake(10, self.buttonMore.ctBottom + 20, SCREENWIDTH - 20, 44);
}

#pragma mark - private Methods
- (void)loginWX {

}

- (void)loginQQ {

}

- (void)loginSina {

}

- (void)loginMore:(UIButton *)sender {
    if (sender.isSelected == YES) {
        sender.selected = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.buttonSina.alpha = 0;
            self.buttonMore.viewY = self.buttonQQ.ctBottom + 10;
            self.buttonPhone.viewY = self.buttonSina.ctBottom + 30;
        } completion:^(BOOL finished) {
            
        }];

    } else {
        sender.selected = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.buttonSina.alpha = 1;
            self.buttonMore.viewY = self.buttonSina.ctBottom + 10;
            self.buttonPhone.viewY = self.buttonSina.ctBottom + 74;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)loginPhone {
    PhoneLoginViewController *controller = [[PhoneLoginViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
//pushs
}

@end
