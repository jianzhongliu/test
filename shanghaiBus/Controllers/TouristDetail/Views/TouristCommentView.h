//
//  TouristCommonView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TouristObject;
@class TouristCommentView;

@protocol TouristCommentViewDelegate <NSObject>

- (void)didTouristServiceCommentInfoDisplayChanged:(TouristCommentView*) detailView status:(BOOL) status;
- (void)didTouristServiceDetailClick:(TouristObject *) tourist;

@end


@interface TouristCommentView : UIView

@property (nonatomic, strong) TouristObject *cellData;
@property (nonatomic, weak) id<TouristCommentViewDelegate> delegate;

- (void)configViewWithData:(TouristObject *) tourist;

- (CGFloat)fetchViewHeight;

@end
