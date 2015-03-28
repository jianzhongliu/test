//
//  PhoneLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/29.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "PhoneLoginViewController.h"
#import "WebImageView.h"

@interface PhoneLoginViewController ()

@property (nonatomic, strong) UIButton *buttonForgetPass;
@property (nonatomic, strong) UIButton *buttonRegister;

@property (nonatomic, strong) WebImageView *imageView;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelPass;

@property (nonatomic, strong) UITextField *textName;
@property (nonatomic, strong) UITextField *textPass;

@property (nonatomic, strong) UIButton *buttonLogin;

@end


@implementation PhoneLoginViewController
- (WebImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[WebImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon_username_back"];
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
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
    
}

@end
