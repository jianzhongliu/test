//
//  AppDelegate.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "AppDelegate.h"
#import "MainHomePageViewController.h"
#import "BYTabBarController.h"
#import "TouristPatternHomeViewController.h"
#import "UINavigationController+Ext.h"

#import <SMS_SDK/SMS_SDK.h>

#define appKey @"6ec614bbd5cf"
#define appSecret @"3c146fc7fc48754b2583d2daa389d772"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationTouristPattern;
@property (nonatomic, strong) BYTabBarController *viewUserPattern;

@end

@implementation AppDelegate

+ (AppDelegate *)share {
    static AppDelegate *appDelegate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (appDelegate == nil) {
            appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        }
    });
    return appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化应用，appKey和appSecret从后台申请得到
    [SMS_SDK registerApp:appKey
              withSecret:appSecret];
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:@"13916241357"
                                          zone:@"86"
                                        result:^(SMS_SDKError *error)
     {
         if (!error)
         {
             
         }
         else
         {
             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                 otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.switchPattern = SWITCHPATTERNUSER;
    BYTabBarController *controller = [[BYTabBarController alloc] init];
    self.window.rootViewController = controller;
    self.viewUserPattern = controller;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)switchUserPattern {
    if (self.switchPattern == SWITCHPATTERNUSER) {
        
        if (self.navigationTouristPattern == nil) {
            TouristPatternHomeViewController *controller = [[TouristPatternHomeViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [nav adjustNavigationUI];
            self.window.rootViewController = nav;
            self.navigationTouristPattern = nav;
        } else {
            self.window.rootViewController = self.navigationTouristPattern;
        }
        self.switchPattern = SWITCHPATTERNTOURIST;

    } else {
        if (self.viewUserPattern == nil) {
            BYTabBarController *controller = [[BYTabBarController alloc] init];
            self.window.rootViewController = controller;
            self.viewUserPattern = controller;
        } else {
            self.window.rootViewController = self.viewUserPattern;
        }
        self.switchPattern = SWITCHPATTERNUSER;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
