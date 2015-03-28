//
//  UserLoginViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//


#import "BaseLoginViewController.h"
#import "UserCachBean.h"

typedef NS_ENUM(NSInteger, LOGINSTATUS) {
    LOGINSTATUSSUCCESS = 1, //登陆成功
    LOGINSTATUSFAIL = 2    //登陆失败
};

typedef void (^loginResultBlock) (UserCachBean *userInfo, LOGINSTATUS status);


@interface UserLoginViewController : BaseLoginViewController

@property (nonatomic, copy) loginResultBlock loginBlock;


@end
