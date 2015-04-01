//
//  BaseLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BaseLoginViewController.h"
#import "WebImageView.h"
#import "Config.h"

@interface BaseLoginViewController ()

@property (nonatomic, strong)  WebImageView *imageBack;

@end

@implementation BaseLoginViewController
- (WebImageView *)imageBack {
    if (_imageBack == nil) {
        _imageBack = [[WebImageView alloc] init];
        _imageBack.image = [UIImage imageNamed:@"icon"];
        _imageBack.clipsToBounds = YES;
        [self.view addSubview:_imageBack];
    }
    return _imageBack;
}

- (UIButton *)buttonBack {
    if (_buttonBack == nil) {
        _buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_buttonBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateSelected];
        [_buttonBack addTarget:self action:@selector(goBackView) forControlEvents:UIControlEventTouchUpInside];
        _buttonBack.selected = NO;
    }
    return _buttonBack;
}

- (UIButton *)buttonDismiss {
    if (_buttonDismiss == nil) {
        _buttonDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDismiss setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_buttonDismiss setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateSelected];
        [_buttonDismiss addTarget:self action:@selector(didmissLoginView) forControlEvents:UIControlEventTouchUpInside];
        _buttonDismiss.selected = NO;
    }
    return _buttonDismiss;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initBaseUI];

}

- (void)initData {
    
}

- (void)initBaseUI {
    self.imageBack.frame = self.view.bounds;
    self.imageBack.image = [UIImage imageNamed:@"image_back"];
    self.navigationController.navigationBarHidden = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = self.imageBack.bounds;
        //    visualEffectView.backgroundColor = [UIColor greenColor];
        visualEffectView.alpha = 0.8;//模糊程度
        [self.imageBack addSubview:visualEffectView];
    } else {
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
        toolBar.barStyle = UIBarStyleBlackTranslucent;
        [toolBar setBackgroundImage:self.imageBack.image forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefaultPrompt];
        toolBar.alpha = 0.8;
        [self.view addSubview:toolBar];
    }
    
    self.buttonBack.frame = CGRectMake(15, 30, 32, 20);
    [self.view addSubview:self.buttonBack];
    
    self.buttonDismiss.frame = CGRectMake(SCREENWIDTH - 36, 30, 21, 21);
    [self.view addSubview:self.buttonDismiss];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewController)];
    [self.view addGestureRecognizer:tap];
}

- (void)goBackView {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didmissLoginView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapViewController {
    [self.view endEditing:YES];
}
@end
