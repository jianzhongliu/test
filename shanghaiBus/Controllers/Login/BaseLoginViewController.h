//
//  BaseLoginViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "UMSocial.h"
#import "UIViewController+Loading.h"
#import "UserCachBean.h"
typedef NS_ENUM(NSInteger, LOGINSTATUS) {
    LOGINSTATUSSUCCESS = 1, //登陆成功
    LOGINSTATUSFAIL = 2    //登陆失败
};

typedef void (^loginResultBlock) (UserCachBean *userInfo, LOGINSTATUS status);

@interface BaseLoginViewController : UIViewController

@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, strong) UIButton *buttonDismiss;

@property (nonatomic, copy) loginResultBlock loginBlock;

- (void)goBackView;

- (void)didmissLoginView;

@end
