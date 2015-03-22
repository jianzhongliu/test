//
//  TouristListCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouristObject.h"

@interface TouristListCell : UITableViewCell


@property (nonatomic, strong) TouristObject *cellData;

- (void)resetCellDataWith:(TouristObject *) tourist;

@end
