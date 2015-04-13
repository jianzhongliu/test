//
//  BusStationListViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TouristObject.h"

@interface TouristDetailViewController : BaseViewController

@property (nonatomic, copy) NSString *busLine;
@property (nonatomic, strong) TouristObject *tourist;

@end
