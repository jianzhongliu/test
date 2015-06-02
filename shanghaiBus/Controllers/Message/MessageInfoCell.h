//
//  TouristCommentListCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentObject.h"
#import "MessageObject.h"

@interface MessageInfoCell : UITableViewCell

- (void)configCellWithComment:(CommentObject * ) celldata;

- (void)configCellWithMessage:(MessageObject *) celldata;

- (CGFloat)fetchCellHightWithData:(id) cellData ;

@end
