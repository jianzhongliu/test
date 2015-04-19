//
//  UINavigationController+Ext.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UINavigationController+Ext.h"
#import "Config.h"

@implementation UINavigationController (Ext)

- (void)adjustNavigationUI {
    [[UINavigationBar appearance] setBarTintColor:BYColor];
    self.navigationBar.translucent = YES;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"icon_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back"]];
    NSShadow *shadow = [[NSShadow alloc] init];
    //    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
}

@end
