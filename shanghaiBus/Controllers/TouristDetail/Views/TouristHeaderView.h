//
//  TouristHeaderView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/16.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouristObject.h"

@interface TouristHeaderView : UIView


- (void)configViewWithData:(TouristObject *) tourist;

- (CGFloat)fetchViewHeight;
@end
