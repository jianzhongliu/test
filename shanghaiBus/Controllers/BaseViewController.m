//
//  BaseViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
#import "UserLoginViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBackButton];

    
}

- (void)showBackButton {
    UIImage *menuBarImage = [UIImage imageNamed:@""];
    UIImage *backButtonImage = [UIImage imageNamed:@""];
    [[UINavigationBar appearance] setBackgroundImage:menuBarImage forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundColor:BYColor];
    
    backButtonImage = [backButtonImage
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 5.0f)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateNormal
                                                         barMetrics:UIBarMetricsCompact];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateSelected
                                                         barMetrics:UIBarMetricsCompact];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont boldSystemFontOfSize:10.0f], NSFontAttributeName,
      nil] forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont boldSystemFontOfSize:10.0f], NSFontAttributeName,
      nil] forState:UIControlStateHighlighted];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          [UIFont boldSystemFontOfSize:23.0f], NSFontAttributeName, [UIColor blackColor], NSShadowAttributeName,  [NSValue valueWithCGSize:CGSizeMake(0.0,1.0)], NSShadowAttributeName,
                                                          nil]];
}


- (void)requestBusData:(NSString *) url {
    __weak __typeof (self) blockSelf = self;
    self.manager = [[AFHTTPRequestOperationManager alloc] init];
    self.manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        blockSelf.busData(operation, YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blockSelf.busData(operation, NO);
    }];
}

- (void)doLoginWithBlock:(loginResultBlock) resultBlock {
    
    UserLoginViewController *controller = [[UserLoginViewController alloc] init];
    controller.loginBlock = resultBlock;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
