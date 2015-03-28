//
//  BaseLoginViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface BaseLoginViewController : UIViewController

@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, strong) UIButton *buttonDismiss;


- (void)goBackView;

- (void)didmissLoginView;

@end
