//
//  TouristInputInfoViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/3.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristInputInfoViewController.h"
#import "Config.h"

@interface TouristInputInfoViewController ()



@end

@implementation TouristInputInfoViewController

#pragma mark- getter&&setter

- (UITextView *)textContent {
    if (_textContent == nil) {
        _textContent = [[UITextView alloc] init];
        _textContent.textColor = [UIColor blackColor];
        
    }
    return _textContent;
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
    self.navigationController.navigationBar.translucent = YES;
    self.textContent.frame = CGRectMake(10, 74, SCREENWIDTH, 150);
    [self.view addSubview:self.textContent];
    
    [self setRightButtonWithTitle:@"确定"];
    
}

- (void)didRightClick {
    if ([_delegate respondsToSelector:@selector(didUploadInfoWith:tag:)]) {
        [_delegate didUploadInfoWith:self.textContent.text tag:self.tag];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
