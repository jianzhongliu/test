//
//  HomePageSingleCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sites.h"

@interface HomePageSingleCell : UITableViewCell


- (void)resetDataWith:(Sites *) site;

+ (CGFloat)fetchCellHeight;
@end
