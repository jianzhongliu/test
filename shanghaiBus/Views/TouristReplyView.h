//
//  touristReplyView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouristReplyView : UIView
@property (nonatomic, strong) UILabel *labelToursit;
- (void)configViewWithData:(id) data;
- (CGFloat)fetchViewHeightWithData:(id) data ;

@end
