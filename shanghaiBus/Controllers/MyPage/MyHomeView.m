//
//  MyHomeView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MyHomeView.h"
#import "EditeUserInfomationViewController.h"
#import "AppDelegate.h"
#import "WebImage.h"

#define VIEWWIDTH 230

@interface MyHomeView ()

@property (nonatomic, strong) UIButton *buttonIcon;
@property (nonatomic, strong) UIButton *buttonMessage;
@property (nonatomic, strong) UIButton *buttonFavorites;
@property (nonatomic, strong) UIButton *buttonSetting;
@property (nonatomic, strong) UIButton *buttonContecUs;
@property (nonatomic, strong) UIButton *buttonTouristEnter;
@property (nonatomic, strong) UIButton *buttonSwitch;

@end

@implementation MyHomeView

#pragma mark - lifeCycleMethods
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = BYBackColor;
    self.buttonIcon.frame = CGRectMake((VIEWWIDTH - 44) / 2, 44, 44, 44);
    self.buttonIcon.layer.cornerRadius = self.buttonIcon.viewWidth/ 2;
    self.buttonIcon.clipsToBounds = YES;
    
//    self.buttonMessage.frame = CGRectMake(0, self.buttonIcon.ctBottom + 30, VIEWWIDTH / 3, VIEWWIDTH / 3);
    self.buttonFavorites.frame = CGRectMake(0, self.buttonIcon.ctBottom + 30, VIEWWIDTH / 2, VIEWWIDTH / 3);
    self.buttonSetting.frame = CGRectMake(VIEWWIDTH / 2, self.buttonIcon.ctBottom + 30, VIEWWIDTH / 2, VIEWWIDTH / 3);
    
//    self.buttonTouristEnter.frame = CGRectMake(20, self.buttonSetting.ctBottom + 20, VIEWWIDTH - 40, 20);
//    [self.buttonTouristEnter setTitle:@"商家入驻" forState:UIControlStateNormal];
    
    self.buttonContecUs.frame = CGRectMake(20, self.buttonFavorites.ctBottom + 20, VIEWWIDTH - 40, 20);
    [self.buttonContecUs setTitle:@"联系我们" forState:UIControlStateNormal];
    
    self.buttonSwitch.frame = CGRectMake(0, SCREENHEIGHT - 40, VIEWWIDTH, 30);
    [self.buttonSwitch setTitle:@"切换到商家模式" forState:UIControlStateNormal];
    [self.buttonSwitch setImageEdgeInsets:UIEdgeInsetsMake(0, self.buttonSwitch.viewWidth - 40, 0, 0)];
    
}

- (void)reloadData {
    if ([[UserCachBean share] isLogin ] == YES) {
        self.buttonMessage.enabled = YES;
        [self.buttonSwitch setTitle:@"切换到商家模式" forState:UIControlStateNormal];
    } else {
        self.buttonMessage.enabled = NO;
        [self.buttonSwitch setTitle:@"登录或注册账号" forState:UIControlStateNormal];
    }
    
    if ([[UserCachBean share] touristInfo].usertype == 3) {//表示该用户是导游
        [self.buttonFavorites setImage:[UIImage imageNamed:@"icon_user_upload"] forState:UIControlStateNormal];
        [self.buttonFavorites setTitle:@"发布服务" forState:UIControlStateNormal];
        
    } else {
        [self.buttonFavorites setImage:[UIImage imageNamed:@"icon_user_enter"] forState:UIControlStateNormal];
        [self.buttonFavorites setTitle:@"商家入驻" forState:UIControlStateNormal];
    }
    
    [self.buttonIcon.imageView sd_setImageWithURL:[NSURL URLWithString:[[[UserCachBean share] touristInfo] icon]]];
}

- (void)didStatusChange:(UIButton *) sender {
    if (!(_delegate && [_delegate respondsToSelector:@selector(didClickActionWithActionType:)])) {
        return;
    }
    
    switch (sender.tag) {
        case 101://用户资料
        {
            [_delegate didClickActionWithActionType:ACTIONINDEXUSERINFO];
        }
            break;
        case 102://消息
        {
            
        }
            break;
        case 103://收藏
        {
            if ([[UserCachBean share] touristInfo].usertype == 2) {//表示该用户是导游
               //发布信息
            } else {
                //入驻
                [_delegate didClickActionWithActionType:ACTIONINDEXTOURISTENTER];
            }
        }
            break;
        case 104://设置
        {
            [_delegate didClickActionWithActionType:ACTIONINDEXSETTING];
        }
            break;
        case 105://联系我们
        {
            [_delegate didClickActionWithActionType:ACTIONINDEXCONTECTUS];
        }
            break;
        case 106://商家入驻
        {
            [_delegate didClickActionWithActionType:ACTIONINDEXTOURISTENTER];
        }
            break;
        case 107://切换模式
        {
            [[AppDelegate share] switchPattern];
            [_delegate didClickActionWithActionType:ACTIONINDEXSWITCH];
            
        }
            break;
        default:
            break;
    }

}
#pragma mark - getter && setter

- (UIButton *)buttonIcon {
    if (_buttonIcon == nil) {
        _buttonIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonIcon setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [_buttonIcon setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonIcon addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonIcon.selected = NO;
        _buttonIcon.tag = 101;
        [self addSubview:_buttonIcon];
    }
    return _buttonIcon;
    
}

- (UIButton *)buttonMessage {
    if (_buttonMessage == nil) {
        _buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonMessage setImage:[UIImage imageNamed:@"icon_user_message_enable"] forState:UIControlStateNormal];
        [_buttonMessage setBackgroundColor:[UIColor whiteColor]];
        [_buttonMessage setTitle:@"信息" forState:UIControlStateNormal];
        [_buttonMessage addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonMessage setTitleColor:BYColorAlphaMake(0, 0, 0, 0.5) forState:UIControlStateNormal];
        _buttonMessage.titleLabel.font = [UIFont systemFontOfSize:13];
        [_buttonMessage setImageEdgeInsets:UIEdgeInsetsMake(-20, 20, 0, 0)];
        [_buttonMessage setTitleEdgeInsets:UIEdgeInsetsMake(40, -20, 0, 10)];
        _buttonMessage.tag = 102;
//        [self addSubview:_buttonMessage];
    }
    return _buttonMessage;
    
}

- (UIButton *)buttonFavorites {
    if (_buttonFavorites == nil) {
        _buttonFavorites = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonFavorites setImage:[UIImage imageNamed:@"icon_user_enter"] forState:UIControlStateNormal];
        [_buttonFavorites setBackgroundColor:[UIColor whiteColor]];
        [_buttonFavorites setTitle:@"商家入驻" forState:UIControlStateNormal];
        [_buttonFavorites setTitleColor:BYColorAlphaMake(0, 0, 0, 0.5) forState:UIControlStateNormal];
        [_buttonFavorites addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonFavorites.selected = NO;
        _buttonFavorites.tag = 103;
        _buttonFavorites.titleLabel.font = [UIFont systemFontOfSize:13];
        [_buttonFavorites setImageEdgeInsets:UIEdgeInsetsMake(-20, 40, 0, 0)];
        [_buttonFavorites setTitleEdgeInsets:UIEdgeInsetsMake(40, -20, 0, 10)];
        [self addSubview:_buttonFavorites];
    }
    return _buttonFavorites;
    
}

- (UIButton *)buttonSetting {
    if (_buttonSetting == nil) {
        _buttonSetting = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSetting setImage:[UIImage imageNamed:@"icon_user_setting"] forState:UIControlStateNormal];
        [_buttonSetting setBackgroundColor:[UIColor whiteColor]];
        [_buttonSetting setTitle:@"设置" forState:UIControlStateNormal];
        [_buttonSetting setTitleColor:BYColorAlphaMake(0, 0, 0, 0.5) forState:UIControlStateNormal];
        [_buttonSetting addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSetting.selected = NO;
        _buttonSetting.tag = 104;
        _buttonSetting.titleLabel.font = [UIFont systemFontOfSize:13];
        [_buttonSetting setImageEdgeInsets:UIEdgeInsetsMake(-20, 20, 0, 0)];
        [_buttonSetting setTitleEdgeInsets:UIEdgeInsetsMake(40, -20, 0, 10)];
        [self addSubview:_buttonSetting];
    }
    return _buttonSetting;
    
}

- (UIButton *)buttonContecUs {
    if (_buttonContecUs == nil) {
        _buttonContecUs = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_buttonContecUs setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        //        [_buttonContecUs setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonContecUs addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonContecUs.selected = NO;
        _buttonContecUs.titleLabel.font = [UIFont systemFontOfSize:13];
        [_buttonContecUs setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonContecUs.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _buttonContecUs.tag = 105;
        [self addSubview:_buttonContecUs];
    }
    return _buttonContecUs;
    
}

- (UIButton *)buttonTouristEnter {
    if (_buttonTouristEnter == nil) {
        _buttonTouristEnter = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_buttonTouristEnter setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        //        [_buttonTouristEnter setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonTouristEnter addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonTouristEnter.selected = NO;
        [_buttonTouristEnter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonTouristEnter.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonTouristEnter.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _buttonTouristEnter.tag = 106;
//        [self addSubview:_buttonTouristEnter];
    }
    return _buttonTouristEnter;
}

- (UIButton *)buttonSwitch {
    if (_buttonSwitch == nil) {
        _buttonSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSwitch setImage:[UIImage imageNamed:@"icon_switch"] forState:UIControlStateNormal];
        [_buttonSwitch setImage:[UIImage imageNamed:@"icon_switch"] forState:UIControlStateSelected];
        [_buttonSwitch addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonSwitch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonSwitch.titleLabel.font = [UIFont systemFontOfSize:14];
        _buttonSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _buttonSwitch.selected = NO;
        _buttonSwitch.tag = 107;
        [self addSubview:_buttonSwitch];
    }
    return _buttonSwitch;
}

@end
