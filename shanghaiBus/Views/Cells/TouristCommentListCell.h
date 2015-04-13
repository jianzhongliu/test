//
//  TouristCommentListCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentObject.h"

@interface TouristCommentListCell : UITableViewCell

- (void)configCellWithData:(id) celldata;

- (CGFloat)fetchCellHightWithData:(id) cellData ;

@end
