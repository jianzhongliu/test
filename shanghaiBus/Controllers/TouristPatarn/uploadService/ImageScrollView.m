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

- (void)configViewWithData:(NSArray *) data clickBlock:(clickAddImageBlock ) clickBlock{
    self.imageBlock = clickBlock;
    CGFloat offset = 0;
    NSMutableArray *arrayImage = [NSMutableArray arrayWithArray:data];
    [arrayImage addObject:[UIImage imageNamed:@"icon"]];
    
    for (int i = 0; i < arrayImage.count; i ++) {
        UIImage *imageData = [arrayImage objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + offset, 10, 60, 60)];
        imageView.image = imageData;
        imageView.userInteractionEnabled = YES;
        [self.scroll addSubview:imageView];
        offset += 80;
        
        if (i == arrayImage.count - 1) {
            UITapGestureRecognizer *tapIMG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickAddIMG)];
            [imageView addGestureRecognizer:tapIMG];
        }
    }
    
    CGFloat width = SCREENWIDTH;
    if (arrayImage.count * 80 > width) {
        width = arrayImage.count * 80;
    }
    self.scroll.contentSize = CGSizeMake(width, 80);
}

- (void)didClickAddIMG {
    self.imageBlock(0);
}

- (CGFloat)fetchViewHeight {
    return 80;
}

@end
