//
//  UserCachBean.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UserCachBean.h"

@implementation UserCachBean

- (instancetype)share {
    static UserCachBean *userCachBean = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userCachBean == nil) {
            userCachBean = [[UserCachBean alloc] init];
        }
    });
    return userCachBean;
}

@end
