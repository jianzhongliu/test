//
//  ImageScrollView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/4.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "ImageScrollView.h"
#import "Config.h"

@interface ImageScrollView ()

@property (nonatomic, strong) UIScrollView *scroll;


@end

@implementation ImageScrollView

- (UIScrollView *)scroll {
    if (_scroll == nil) {
        _scroll = [[UIScrollView alloc] init];
        //        _scrollViewBG.delegate = self;
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.pagingEnabled = NO;
        _scroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    }
    return _scroll;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.scroll.frame = CGRectMake(0, 0, SCREENWIDTH, 80);
    [self addSubview:self.scroll];
    
    
}

- (void)configViewWithData:(NSArray *) data {
    CGFloat offset = 0;
    
    for (UIImage *image in data) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + offset, 10, 60, 60)];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        [self.scroll addSubview:imageView];
        if (data.count == 1) {
            imageView.frame = CGRectMake(10 + offset, 10, 60, 60);
        }
    }
    
    
}

- (CGFloat)fetchViewHeight {
    return 0;
}

@end
