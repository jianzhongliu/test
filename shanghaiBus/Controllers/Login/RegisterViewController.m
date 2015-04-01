//
//  PhoneLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/29.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "RegisterViewController.h"
#import "SettingPasswordViewController.h"
#import "WebImageView.h"

@interface RegisterViewController ()

//@property (nonatomic, strong) UIButton *buttonForgetPass;
//@property (nonatomic, strong) UIButton *buttonRegister;

@property (nonatomic, strong) WebImageView *imageView;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelPass;

@property (nonatomic, strong) UITextField *textName;
@property (nonatomic, strong) UITextField *textPass;

@property (nonatomic, strong) UIButton *buttonCheckcode;

@property (nonatomic, strong) UIButton *buttonNextStep;

@end


@implementation RegisterViewController
#pragma mark - getter&&setter

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelName.font = [UIFont systemFontOfSize:13];
    }
    return _labelName;
}

- (UILabel *)labelPass {
    if (_labelPass == nil) {
        _labelPass = [[UILabel alloc] init];
        _labelPass.numberOfLines = 0;
        _labelPass.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPass.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelPass.font = [UIFont systemFontOfSize:13];
    }
    return _labelPass;
}

- (UITextField *)textName {
    if (_textName == nil) {
        _textName = [[UITextField alloc] init];
        _textName.clearsOnBeginEditing = YES;
        _textName.font = [UIFont systemFontOfSize:13];
        //        _textName.textColor = [UIColor whiteColor];
    }
    return _textName;
}

- (UITextField *)textPass {
    if (_textPass == nil) {
        _textPass = [[UITextField alloc] init];
        _textPass.clearsOnBeginEditing = YES;
        _textPass.secureTextEntry = YES;
    }
    return _textPass;
}

- (UIButton *)buttonCheckcode {
    if (_buttonCheckcode == nil) {
        _buttonCheckcode = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCheckcode setBackgroundColor:BYColor];
        //        [_buttonCheckcode setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        //        [_buttonCheckcode setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonCheckcode addTarget:self action:@selector(didClickCheckcode:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonCheckcode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_buttonCheckcode setFont:[UIFont systemFontOfSize:12]];
        _buttonCheckcode.selected = NO;
    }
    return _buttonCheckcode;
}

- (WebImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[WebImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon_name_pass"];
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)buttonNextStep {
    if (_buttonNextStep == nil) {
        _buttonNextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNextStep setBackgroundImage:[UIImage imageNamed:@"icon_login_nomal"] forState:UIControlStateNormal];
        [_buttonNextStep addTarget:self action:@selector(didClickNext) forControlEvents:UIControlEventTouchUpInside];
        [_buttonNextStep setTitle:@"下一步，设置密码" forState:UIControlStateNormal];
        _buttonNextStep.selected = NO;
    }
    return _buttonNextStep;
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
    
    self.imageView.frame = CGRectMake(10, 80, SCREENWIDTH - 20, 86);
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    self.labelName.frame = CGRectMake(10, 10, 70, 20);
    self.labelName.text = @"用户名：";
    [self.imageView addSubview:self.labelName];
    
    self.textName.frame = CGRectMake(self.labelName.ctRight + 10, 10, SCREENWIDTH - 110, 25);
    self.textName.placeholder = @"手机号码";
    [self.imageView addSubview:self.textName];
    
    self.labelPass.frame = CGRectMake(10, 55, 70, 20);
    self.labelPass.text = @"验证码：";
    [self.imageView addSubview:self.labelPass];
    
    self.textPass.frame = CGRectMake(self.labelPass.ctRight + 10, 55, SCREENWIDTH - 110, 25);
    [self.imageView addSubview:self.textPass];
    
    self.buttonCheckcode.frame = CGRectMake(self.imageView.viewWidth - 80, 55, 70, 25);
    [self.imageView addSubview:self.buttonCheckcode];
    
    self.buttonNextStep.frame = CGRectMake(10, self.imageView.ctBottom + 20, SCREENWIDTH - 20, 44);
    [self.view addSubview:self.buttonNextStep];
}

- (void)goBackView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickCheckcode:(id) sender {
    
}

- (void)didClickNext {
    SettingPasswordViewController *controller = [[SettingPasswordViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
