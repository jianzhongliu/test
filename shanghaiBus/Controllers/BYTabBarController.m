//
//  BYTabBarController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/18.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BYTabBarController.h"
#import "EditeUserInfomationViewController.h"
#import "ContectUSViewController.h"
#import "SettingViewController.h"
#import "MessageListViewController.h"
#import "TouristBaseInfoViewController.h"
#import "MyHomeViewController.h"
#import "TouristInfoViewController.h"
#import "AuthenticatedInfoViewController.h"
#import "UploadServiceViewController.h"

#import "AppDelegate.h"
#import "BYTabBarItem.h"
#import "MyHomeView.h"

@interface BYTabBarController () <UITabBarControllerDelegate, MyHomeViewDelegate>

@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) MyHomeView *viewMy;

@end

@implementation BYTabBarController

- (MyHomeView *)viewMy {
    if (_viewMy == nil) {
        _viewMy = [[MyHomeView alloc] init];
        _viewMy.delegate = self;
    }
    return _viewMy;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self configureTabBarController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)adjustNavigationUI:(UINavigationController *) nav {
    [[UINavigationBar appearance] setBarTintColor:BYColor];
    nav.navigationBar.translucent = YES;
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

-(void) configureTabBarController
{
    BYTabBarItem *homeItem;
    BYTabBarItem *messageItem;
    BYTabBarItem *myItem;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x22b9f7), NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:13], NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x9999999), NSForegroundColorAttributeName, [UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
    } else {
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x22b9f7), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x9999999), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    }
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.tabBar.tintColor = BYColor;
        homeItem = [[BYTabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_home_home"] selectedImage:[UIImage imageNamed:@"icon_home_home_selected"]];
        
        messageItem = [[BYTabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"icon_home_message"] selectedImage:[UIImage imageNamed:@"icon_home_message_selected"]];
        
        myItem = [[BYTabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_home_me"] selectedImage:[UIImage imageNamed:@"icon_home_me_selected"]];
    }
    
    //home tab
    MainHomePageViewController *homeController = [[MainHomePageViewController alloc] init];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    homeController.navigationController.navigationBar.translucent = NO;
    homeItem.highlightedImage = [UIImage imageNamed:@"icon_home_home_selected"];
    homeNavController.tabBarItem = homeItem;
    [self adjustNavigationUI:homeNavController];
    
    //tab
    MyMessageViewController *messageController = [[MyMessageViewController alloc] init];
    UINavigationController *messageNavController = [[UINavigationController alloc] initWithRootViewController:messageController];
    messageController.navigationController.navigationBar.translucent = NO;
    messageItem.highlightedImage = [UIImage imageNamed:@"icon_home_message_selected.png"];
    messageNavController.tabBarItem = messageItem;
    [self adjustNavigationUI:messageNavController];
    
    //我
    MyHomeViewController *myController = [[MyHomeViewController alloc] init];
    UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:myController];
    myController.navigationController.navigationBar.translucent = NO;
    myItem.highlightedImage = [UIImage imageNamed:@"icon_home_me_selected"];
    myNavController.tabBarItem = myItem;
    [self adjustNavigationUI:myNavController];
    self.viewMy.nav = myNavController;
    
    self.viewControllers = @[homeNavController, messageNavController, myNavController];
    [homeController view];
    
    [self.tabBar setBackgroundColor:[UIColor clearColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.selectedIndex = 0;
    
}

- (void)showMyInfo {
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    self.control = nil;
    if (self.control == nil) {
        self.control = [[UIControl alloc] initWithFrame:window.bounds];
        self.control.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.3);
        [self.control addTarget:self action:@selector(didDismissMyInfoCenter) forControlEvents:UIControlEventTouchDown];
        [window addSubview:self.control];
        
        self.viewMy.frame = CGRectMake(SCREENWIDTH, 0, 230, SCREENHEIGHT);
        [self.control addSubview:self.viewMy];
    } else {
        self.control.alpha = 1;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.viewMy.viewX = SCREENWIDTH - 230;
    } completion:^(BOOL finished) {
    }];
}

- (void)didDismissMyInfoCenter {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewMy.viewX = SCREENWIDTH;
    } completion:^(BOOL finished) {
        self.control.alpha = 0;
    }];
}

#pragma mark - tabBarController delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    if (tabBarController.selectedIndex == 0) {//我的
//        UIViewController *tabController = viewController;
//        
//        if ([viewController isKindOfClass:[UINavigationController class]]) {
//            tabController = [(UINavigationController *)viewController visibleViewController];
//        }
////window
//        [self showMyInfo];
//        return NO;
//    }
//    self.currentIndex = tabBarController.selectedIndex;
//    NSLog(@"%d",tabBarController.selectedIndex);
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    if (tabBarController.selectedIndex == 0) {
        self.currentIndex = tabBarController.selectedIndex;
    } else if (tabBarController.selectedIndex == 1){
        self.currentIndex = tabBarController.selectedIndex;
    } else if (tabBarController.selectedIndex == 2) {
        self.selectedIndex = self.currentIndex;
        [self showMyInfo];
//        self.currentIndex = tabBarController.selectedIndex;
    }
}

#pragma  mark - MyHomeViewDelegate 
- (void)didClickActionWithActionType:(ACTIONINDEX)index {
    switch (index) {
        case ACTIONINDEXUSERINFO:
        {
            TouristInfoViewController *controller = [[TouristInfoViewController alloc] init];
            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self adjustNavigationUI:myNavController];
            [self presentViewController:myNavController animated:YES completion:nil];
            [self didDismissMyInfoCenter];
        }
            break;
        case ACTIONINDEXSWITCH:
        {
            [[AppDelegate share] switchUserPattern];
            self.control.alpha = 0;
            self.control = nil;
//            MessageListViewController *controller = [[MessageListViewController alloc] init];
//            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
//            [self adjustNavigationUI:myNavController];
//            [self presentViewController:myNavController animated:YES completion:nil];
//            [self didDismissMyInfoCenter];
        }
            break;
        case ACTIONINDEXSETTING:
        {
            SettingViewController *controller = [[SettingViewController alloc] init];
            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self adjustNavigationUI:myNavController];
            [self presentViewController:myNavController animated:YES completion:nil];
            [self didDismissMyInfoCenter];
        }
            break;
        case ACTIONINDEXTOURISTENTER:
        {
//            if ([[[UserCachBean share] touristInfo] usertype] == 2) {
//                AuthenticatedInfoViewController *controller = [[AuthenticatedInfoViewController alloc] init];
//                UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
//                [self adjustNavigationUI:myNavController];
//                [self presentViewController:myNavController animated:YES completion:nil];
//                [self didDismissMyInfoCenter];
//            } else {
//                //当认证成功就可以直接发服务了
//
//                UploadServiceViewController *controller = [[UploadServiceViewController alloc] init];
//                UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
//                [self adjustNavigationUI:myNavController];
//                [self presentViewController:myNavController animated:YES completion:nil];
//                [self didDismissMyInfoCenter];
//            }

            UploadServiceViewController *controller = [[UploadServiceViewController alloc] init];
            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self adjustNavigationUI:myNavController];
            [self presentViewController:myNavController animated:YES completion:nil];
            [self didDismissMyInfoCenter];
            
            

        }
            break;
        case ACTIONINDEXCONTECTUS:
        {
            ContectUSViewController *controller = [[ContectUSViewController alloc] init];
            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self adjustNavigationUI:myNavController];
            [self presentViewController:myNavController animated:YES completion:nil];
            [self didDismissMyInfoCenter];
        }
            break;
        default:
            break;
    }

}
@end
