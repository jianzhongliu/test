//
//  TouristServiceDetailView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/24.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouristObject.h"
@class TouristServiceDetailView;
@protocol TouristServiceDetailViewDelegate <NSObject>

- (void)didTouristServiceDetailInfoDisplayChanged:(TouristServiceDetailView*) detailView status:(BOOL) status;

@end

@interface TouristServiceDetailView : UIView

@property (nonatomic) BOOL isShow;//yes表示展开，no表示关闭
@property (nonatomic, weak) id<TouristServiceDetailViewDelegate> delegate;

/**
 传入值
 */
- (void)configViewWithTitle:(NSString *) title detail:(NSString *) detailInfo;

/**
 计算view的高度
 */
- (CGFloat)fetchViewHeight ;
@end
