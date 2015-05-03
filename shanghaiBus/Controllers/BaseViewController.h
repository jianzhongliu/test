//
//  BaseViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Config.h"
#import "UIViewController+Loading.h"
#import "UserLoginViewController.h"

typedef void (^busDataBlock) (AFHTTPRequestOperation *operation, BOOL status);

@interface BaseViewController : UIViewController

@property (nonatomic, copy) busDataBlock busData;

- (void)setRightButtonWithTitle:(NSString *) title;

- (void)didRightClick;

- (void)didLeftClick;

- (void)requestBusData:(NSString *) url;

- (void)doLoginWithBlock:(loginResultBlock) resultBlock;

@end
