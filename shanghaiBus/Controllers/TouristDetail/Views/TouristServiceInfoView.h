//
//  TouristServiceInfoView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/24.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TouristObject;

@interface TouristServiceInfoView : UIView

- (void)configViewWithData:(TouristObject *) tourist;

- (CGFloat)fetchViewHight;

@end
