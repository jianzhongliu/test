//
//  TouristContectView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TouristContectView;

@protocol TouristContectViewDelegate <NSObject>

- (void)didClickMessage;
- (void)didClickPhone;

@end

@interface TouristContectView : UIView

@property (nonatomic, weak) id<TouristContectViewDelegate> delegate;

@end
