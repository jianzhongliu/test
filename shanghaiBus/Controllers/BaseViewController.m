//
//  BaseViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
#import "UserLoginViewController.h"
#import "UIViewController+Loading.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYBackColor;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(didLeftClick)];
    
    [self.navigationItem setLeftBarButtonItem:leftItem];
//    self.navigationController.delegate = self;
}

- (void)setRightButtonWithTitle:(NSString *) title  {
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(didRightClick)];
    
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void)didRightClick {

}

- (void)didLeftClick {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.delegate = self;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1) {
        return;
    }
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    return 0;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    if ([[UserCachBean share] isLogin] == YES) {
        resultBlock([UserCachBean share], LOGINSTATUSSUCCESS);
    } else {
        UserLoginViewController *controller = [[UserLoginViewController alloc] init];
        controller.loginBlock = resultBlock;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }

}

@end
