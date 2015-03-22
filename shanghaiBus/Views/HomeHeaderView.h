//
//  HomeHeaderView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeHeaderView;

@protocol HomeHeaderViewDelegate <NSObject>

- (void)didClickHeaderImageBannerAtIndex:(NSInteger )index withUrl:(NSString *) url;

@end

@interface HomeHeaderView : UIView

@property (nonatomic, weak) id<HomeHeaderViewDelegate> delegate;

- (void)resetDataToView:(NSDictionary *)dicData;

@end
