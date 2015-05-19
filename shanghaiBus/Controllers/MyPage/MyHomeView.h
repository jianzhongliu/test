//
//  MyHomeView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

typedef NS_ENUM(NSInteger, ACTIONINDEX) {
    ACTIONINDEXUSERINFO = 1,
    ACTIONINDEXSETTING = 2,
    ACTIONINDEXCONTECTUS = 3,
    ACTIONINDEXSWITCH = 4,
    ACTIONINDEXTOURISTENTER = 5 //商家入驻、发布服务
};

@protocol MyHomeViewDelegate <NSObject>

- (void)didClickActionWithActionType:(ACTIONINDEX) index;

@end

@interface MyHomeView : UIView

@property (nonatomic, strong) UINavigationController *nav;

@property (nonatomic, assign) id<MyHomeViewDelegate> delegate;

- (void)reloadData;
@end
