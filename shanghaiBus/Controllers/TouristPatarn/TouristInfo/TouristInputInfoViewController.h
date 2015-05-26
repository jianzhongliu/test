//
//  TouristInputInfoViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/3.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol TouristInputInfoViewControllerDelegate <NSObject>

- (void)didUploadInfoWith:(NSString *) content tag:(NSInteger) tag;

@end

@interface TouristInputInfoViewController : BaseViewController
@property (nonatomic, strong) UITextView *textContent;
@property (nonatomic, weak) id<TouristInputInfoViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;

@end
