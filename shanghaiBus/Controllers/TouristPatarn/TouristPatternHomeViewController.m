//
//  TouristPatternHomeViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristPatternHomeViewController.h"
#import "ContectUSViewController.h"
#import "MessageListViewController.h"
#import "SettingViewController.h"
#import "TouristBaseInfoViewController.h"
#import "UploadServiceViewController.h"
#import "ServiceListViewController.h"
#import "TouristInfoViewController.h"

#import "WebImageView.h"
#import "AppDelegate.h"

@interface TouristPatternHomeViewController ()

@property (nonatomic, strong) UIButton *controlIcon;
@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UIButton *buttonMessage;
@property (nonatomic, strong) UIButton *buttonSetting;
@property (nonatomic, strong) UIButton *buttonUpload;
@property (nonatomic, strong) UIButton *buttonService;
@property (nonatomic, strong) UIButton *buttonCotectUS;
@property (nonatomic, strong) UIButton *buttonSwitch;

@end

@implementation TouristPatternHomeViewController
#pragma mark - getter & setter

- (UIButton *)controlIcon {
    if (_controlIcon == nil) {
        _controlIcon = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_controlIcon setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//        [_controlIcon setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_controlIcon addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _controlIcon.tag = 101;
        _controlIcon.backgroundColor = [UIColor clearColor];
        _controlIcon.selected = NO;
        [_controlIcon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _controlIcon.titleLabel.font = [UIFont systemFontOfSize:13];
        _controlIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _controlIcon;
    
}
- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon_tourist_head"];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
    }
    return _imageIcon;
}

- (UIButton *)buttonMessage {
    if (_buttonMessage == nil) {
        _buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonMessage setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [_buttonMessage setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonMessage addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _buttonMessage.tag = 102;
        _buttonMessage.selected = NO;
        [_buttonMessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonMessage.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonMessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonMessage;
    
}

- (UIButton *)buttonSetting {
    if (_buttonSetting == nil) {
        _buttonSetting = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSetting setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [_buttonSetting setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonSetting addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSetting.selected = NO;
        _buttonSetting.tag = 103;
        [_buttonSetting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonSetting.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonSetting.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonSetting;
    
}

- (UIButton *)buttonUpload {
    if (_buttonUpload == nil) {
        _buttonUpload = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_buttonUpload setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//        [_buttonUpload setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonUpload setTitle:@"发布服务信息" forState:UIControlStateNormal];
        [_buttonUpload addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _buttonUpload.selected = NO;
        _buttonUpload.tag = 104;
        [_buttonUpload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonUpload.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonUpload.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _buttonUpload;
    
}

- (UIButton *)buttonService {
    if (_buttonService == nil) {
        _buttonService = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_buttonService setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//        [_buttonService setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonService setTitle:@"我发布的服务信息（1条）" forState:UIControlStateNormal];
        [_buttonService addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _buttonService.selected = NO;
        _buttonService.tag = 105;
        [_buttonService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonService.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonService.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _buttonService;
    
}

- (UIButton *)buttonCotectUS {
    if (_buttonCotectUS == nil) {
        _buttonCotectUS = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_buttonCotectUS setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
//        [_buttonCotectUS setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonCotectUS setTitle:@"联系我们" forState:UIControlStateNormal];
        [_buttonCotectUS addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCotectUS.selected = NO;
        _buttonCotectUS.tag = 106;
        [_buttonCotectUS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonCotectUS.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonCotectUS.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _buttonCotectUS;
    
}

- (UIButton *)buttonSwitch {
    if (_buttonSwitch == nil) {
        _buttonSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSwitch setImage:[UIImage imageNamed:@"icon_switch"] forState:UIControlStateNormal];
        [_buttonSwitch setImage:[UIImage imageNamed:@"icon_switch"] forState:UIControlStateSelected];
        [_buttonSwitch setTitle:@"切换至用户模式" forState:UIControlStateNormal];
        [_buttonSwitch addTarget:self action:@selector(didClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSwitch.selected = NO;
        _buttonSwitch.tag = 107;
        [_buttonSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonSwitch.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _buttonSwitch;
    
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
    self.view.backgroundColor = BYBackColor;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    [self setTitle:@"商家模式"];
    [self initUI];
}

- (void)initData {
    
}

- (void)initUI {
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.contentSize = CGSizeMake(SCREENWIDTH, scroll.viewHeight - 60);
    scroll.scrollEnabled = YES;
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
    
    [scroll addSubview:self.imageIcon];
    [scroll addSubview:self.buttonMessage];
    [scroll addSubview:self.buttonSetting];
    [scroll addSubview:self.buttonUpload];
    [scroll addSubview:self.buttonService];
    [scroll addSubview:self.buttonCotectUS];
    [scroll addSubview:self.buttonSwitch];
    [scroll addSubview:self.controlIcon];
    
    self.imageIcon.frame = CGRectMake((SCREENWIDTH - 95)/2, 30, 95, 95);
    self.buttonMessage.frame = CGRectMake(0, self.imageIcon.ctBottom + 20, SCREENWIDTH / 2, 44);
    self.buttonSetting.frame = CGRectMake(SCREENWIDTH / 2, self.buttonMessage.ctTop, SCREENWIDTH / 2, 44);
    self.controlIcon.frame = self.imageIcon.frame;

    self.buttonUpload.frame = CGRectMake(10, self.buttonMessage.ctBottom + 30, SCREENWIDTH, 30);
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonUpload.ctBottom, SCREENWIDTH, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.2);
    [scroll addSubview:viewLine];
    
    self.buttonService.frame = CGRectMake(10, self.buttonUpload.ctBottom + 10, SCREENWIDTH, 30);
    viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonService.ctBottom, SCREENWIDTH, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.2);
    [scroll addSubview:viewLine];
    
    self.buttonCotectUS.frame = CGRectMake(10, self.buttonService.ctBottom + 10, SCREENWIDTH, 30);
    viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonCotectUS.ctBottom, SCREENWIDTH, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.2);
    [scroll addSubview:viewLine];
    
    self.buttonSwitch.frame = CGRectMake(0, scroll.viewHeight - 88 - 15, SCREENWIDTH, 30);
    self.buttonSwitch.imageEdgeInsets = UIEdgeInsetsMake(0, SCREENWIDTH - 40, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - action && private Methods
- (void)didDismissMyInfo {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSaveInfo {
    
    [self didDismissMyInfo];
}

- (void)didClickActionWithSender:(UIButton *) sender {
    switch (sender.tag) {
        case 101:
        {
        //头像
            TouristInfoViewController *controller = [[TouristInfoViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case 102:
        {
            MessageListViewController *controller = [[MessageListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        case 103:
        {
            SettingViewController *controller = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 104:
        {
            UploadServiceViewController *controller = [[UploadServiceViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 105:
        {
            ServiceListViewController *controller = [[ServiceListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
        case 106:
        {
            ContectUSViewController *controller = [[ContectUSViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 107:
        {
            [[AppDelegate share] switchUserPattern];
        }
            break;
        default:
            break;
    }
    
}

@end
