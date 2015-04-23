//
//  UIViewController+Loading.m
//  AnjukeBroker_New
//
//  Created by Wu sicong on 13-11-8.
//  Copyright (c) 2013年 Wu sicong. All rights reserved.
//

#import "UIViewController+Loading.h"

@implementation UIViewController (Loading)

- (void)hideLoadWithAnimated:(BOOL)animated{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)showLoadingActivity:(BOOL)activity{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.yOffset = -45;
    hud.labelText = @"加载中...";
}

- (void)showInfo:(NSString *)info{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    hud.yOffset = -85;
    [hud hide:YES afterDelay:2];
}

@end
