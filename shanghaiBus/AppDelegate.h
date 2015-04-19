//
//  AppDelegate.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SWITCHPATTERN) {
    SWITCHPATTERNUSER = 1,
    SWITCHPATTERNTOURIST = 2
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) SWITCHPATTERN switchPattern;

+ (AppDelegate *)share;

- (void)switchUserPattern;//切换模式


@end

