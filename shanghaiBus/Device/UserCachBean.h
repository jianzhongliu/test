//
//  UserCachBean.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristObject.h"

typedef NS_ENUM(NSInteger, USERTYPE) {
        USERTYPENOMAL = 1,
        USERTYPEBUSSENESS = 2

};

@interface UserCachBean : NSObject

@property (nonatomic, strong) TouristObject *touristInfo;
@property (nonatomic, assign) USERTYPE userType;

+ (instancetype)share;

+ (void)fetchTouristInfo;

- (BOOL)isLogin;


@end
