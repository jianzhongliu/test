//
//  ContectUSViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "ContectUSViewController.h"

@interface ContectUSViewController ()

@property (nonatomic, strong) UITextView *textContent;
@property (nonatomic, strong) UITextField *textPhone;
@property (nonatomic, strong) UITextField *textEmail;

@end

@implementation ContectUSViewController

#pragma mark - getter && setter

- (UITextView *)textContent {
    if (_textContent == nil) {
        _textContent = [[UITextView alloc] init];
        _textContent.textColor = [UIColor blackColor];
        _textContent.font = [UIFont systemFontOfSize:15];
    }
    return _textContent;
}

- (UITextField *)textPhone {
    if (_textPhone == nil) {
        _textPhone = [[UITextField alloc] init];
        _textPhone.font = [UIFont systemFontOfSize:13];
        _textPhone.textColor = [UIColor blackColor];
        _textPhone.keyboardType = UIKeyboardTypePhonePad;
        _textPhone.placeholder = @"请出入手机号码";
        
    }
    return _textPhone;
}

- (UITextField *)textEmail {
    if (_textEmail == nil) {
        _textEmail = [[UITextField alloc] init];
        _textEmail.textColor = [UIColor blackColor];
        _textEmail.font = [UIFont systemFontOfSize:13];
        _textEmail.keyboardType = UIKeyboardTypeEmailAddress;
        _textEmail.placeholder = @"请输入电子邮箱地址";
    }
    return _textEmail;
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
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = BYBackColor;
    [self initUI];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(didSaveInfo)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self setTitle:@"联系我们"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(didTapController)];
    [self.view addGestureRecognizer:tap];
}

- (void)didTapController {
    [self.view endEditing:YES];
}

- (void)initData {
    
}

- (void)initUI {
//    UIScrollView
    
    
    self.textContent.frame = CGRectMake(0, 90, SCREENWIDTH, 150);
    [self.view addSubview:self.textContent];
    
    UIView *viewContect = [[UIView alloc] initWithFrame:CGRectMake(0, self.textContent.ctBottom + 20, SCREENWIDTH, 90)];
    viewContect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewContect];
    
    UILabel *labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    labelPhone.textColor = BYColor;
    labelPhone.font = [UIFont systemFontOfSize:13];
    labelPhone.text = @"手机号码(必填)";
    labelPhone.backgroundColor = [UIColor whiteColor];
    [viewContect addSubview:labelPhone];
    
    self.textPhone.frame = CGRectMake(labelPhone.ctRight + 5, 10, 200, 30);
    [viewContect addSubview:self.textPhone];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, labelPhone.ctBottom + 5, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    [viewContect addSubview:viewLine];
    
    UILabel *labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(10, labelPhone.ctBottom + 10, 100, 30)];
    labelEmail.textColor = BYColor;
    labelEmail.text = @"电子邮箱";
    labelEmail.font = [UIFont systemFontOfSize:13];
    labelEmail.backgroundColor = [UIColor whiteColor];
    [viewContect addSubview:labelEmail];
    
    
    self.textEmail.frame = CGRectMake(labelEmail.ctRight + 5, labelEmail.ctTop, 200, 30);
    [viewContect addSubview:self.textEmail];
    
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
