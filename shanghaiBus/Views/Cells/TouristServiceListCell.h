//
//  TouristServiceListCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceObject.h"
#import "TouristObject.h"
#import "UserCachBean.h"

@interface TouristServiceListCell : UITableViewCell

@property (nonatomic, strong) ServiceObject *cellData;

- (void)configCellDataWith:(ServiceObject *) service;

@end
