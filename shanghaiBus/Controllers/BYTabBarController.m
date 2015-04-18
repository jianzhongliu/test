//
//  BYTabBarController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/18.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BYTabBarController.h"
#import "BYTabBarItem.h"

@interface BYTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) UIControl *control;
@property (nonatomic, strong) UIView *viewMy;

@end

@implementation BYTabBarController
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
//    BYTabBarItem *sessionItem;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x22b9f7), UITextAttributeTextColor, [UIFont boldSystemFontOfSize:13], NSFontAttributeName,nil] forState:UIControlStateSelected];
        
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x9999999), UITextAttributeTextColor, [UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
    } else {
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x22b9f7), UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        
        [[BYTabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BYColorFromHex(0x9999999), UITextAttributeTextColor, nil] forState:UIControlStateNormal];
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
    
    self.viewControllers = @[homeNavController, messageNavController, myNavController];
    [homeController view];
    
    [self.tabBar setBackgroundColor:[UIColor clearColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.selectedIndex = 0;
    
}

- (void)showMyInfo {
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    if (self.control == nil) {
        self.control = [[UIControl alloc] initWithFrame:window.bounds];
        self.control.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.3);
        [self.control addTarget:self action:@selector(didDismissMyInfoCenter) forControlEvents:UIControlEventTouchDown];
        [window addSubview:self.control];
        
        self.viewMy = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, 230, SCREENHEIGHT)];
        self.viewMy.backgroundColor = BYColor;
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
    if (tabBarController.selectedIndex == 0) {//我的
        UIViewController *tabController = viewController;
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            tabController = [(UINavigationController *)viewController visibleViewController];
        }
//window
        [self showMyInfo];
        return NO;
    }
    self.currentIndex = tabBarController.selectedIndex;
    


    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    if (tabBarController.selectedIndex == 2) {

    }
    if (tabBarController.selectedIndex == 0) {

    } else if (tabBarController.selectedIndex == 1){

    } else if (tabBarController.selectedIndex == 2) {

    }
}


@end
