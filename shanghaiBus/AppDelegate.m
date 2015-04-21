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
//掌淘科技
#import <SMS_SDK/SMS_SDK.h>
#define ztappKey @"6ec614bbd5cf"
#define ztappSecret @"3c146fc7fc48754b2583d2daa389d772"
//umeng
#define UmengAppkey @"5211818556240bc9ee01db2f"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
//#import "UMSocialWechatHandler.h"

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
    //使用友盟统计
//    [MobClick startWithAppkey:UmengAppkey];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
//    [UMSocialQQHandler setSupportWebView:YES];
    //打开新浪微博的SSO开关
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //掌淘短信验证初始化应用，appKey和appSecret从后台申请得到
    [SMS_SDK registerApp:ztappKey
              withSecret:ztappSecret];
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


/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
