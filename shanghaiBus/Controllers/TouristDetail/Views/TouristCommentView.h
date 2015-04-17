//
//  TouristCommonView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObject.h"

@class CommentObject;
@class TouristCommentView;

typedef NS_ENUM(NSInteger, VIEWTYPE) {
    VIEWTYPECOMMENT = 1,
    VIEWTYPEMESSAGE =2
};

@protocol TouristCommentViewDelegate <NSObject>

- (void)didTouristServiceCommentInfoDisplayChanged:(TouristCommentView*) detailView status:(BOOL) status;
- (void)didTouristServiceDetailClick:(CommentObject *) tourist;

@end


@interface TouristCommentView : UIView

@property (nonatomic, strong) CommentObject *cellData;
@property (nonatomic, weak) id<TouristCommentViewDelegate> delegate;
@property (nonatomic) VIEWTYPE viewtype;

- (void)configViewWithData:(CommentObject *) comment WithNumber:(NSInteger) number;
- (void)configViewWithMessage:(MessageObject *) message WithNumber:(NSInteger) number;
- (CGFloat)fetchViewHeight;

@end
