//
//  HomePageSepratorCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sites.h"

@class HomePageSepratorCell;

@protocol HomePageSepratorCellDelegate <NSObject>

- (void)didClickImageAtCell:(HomePageSepratorCell *)cell withIndex:(NSInteger) index;

@end


@interface HomePageSepratorCell : UITableViewCell

@property (nonatomic, weak) id<HomePageSepratorCellDelegate> delegate;
@property (nonatomic, strong) id cellData;

- (void)resetDataWith:(NSArray *) arrayData;

/**
 计算方法，屏幕宽度-30除以2得到图片的宽度
 图片的宽度高比为16：9
 得到图片的高度为：(SCREENWIDTH - 30) / 2 *9 / 16
 */
+ (CGFloat)fetchCellHeight;

@end
