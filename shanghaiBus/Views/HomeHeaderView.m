//
//  HomeHeaderView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UIImageView+AFNetworking.h"
#import "WebImageView.h"
#import "Config.h"

@interface HomeHeaderView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollTop;
@property (nonatomic, strong) WebImageView *imageBanner;

//headerSearch
@property (nonatomic, strong) UIButton *viewSearch;
@property (nonatomic, strong) UILabel *labelNumberOftourist;

@end

@implementation HomeHeaderView

#pragma mark - lifeCycleMethods
- (UILabel *)labelNumberOftourist {
    if (_labelNumberOftourist == nil) {
        _labelNumberOftourist = [[UILabel alloc] init];
        _labelNumberOftourist.backgroundColor = [UIColor whiteColor];
        _labelNumberOftourist.font = [UIFont systemFontOfSize:13];
        _labelNumberOftourist.textColor = BYColorFromHex(0x999999);
    }
    return _labelNumberOftourist;
}

- (UIButton *)viewSearch {
    if (_viewSearch == nil) {
        _viewSearch = [[UIButton alloc] init];
        _viewSearch.backgroundColor = [UIColor whiteColor];
        [_viewSearch addTarget:self action:@selector(didClickSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _viewSearch;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

#pragma mark - private Methods
- (void)initUI {
    self.scrollTop = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    self.scrollTop.delegate = self;
    self.scrollTop.pagingEnabled = YES;
    [self addSubview:self.scrollTop];
    self.scrollTop.contentSize = CGSizeMake(SCREENWIDTH, 55);
    
    UIImageView *imageSearchBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 82)];
    imageSearchBack.image = [UIImage imageNamed:@"icon_searchBackground"];
    [self addSubview:imageSearchBack];

    self.viewSearch.frame = CGRectMake(0, self.scrollTop.ctBottom, SCREENWIDTH, 60);
    [self addSubview:self.viewSearch];

    UIImageView *imageSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 17, 17)];
    imageSearchIcon.image = [UIImage imageNamed:@"icon_search"];
    [self addSubview:imageSearchIcon];
    
    UILabel *labelSearchTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageSearchIcon.ctRight + 5, 17, 200, 20)];
    labelSearchTitle.backgroundColor = [UIColor whiteColor];
    labelSearchTitle.text = @"你想去哪里玩?";
    labelSearchTitle.font = [UIFont boldSystemFontOfSize:15];
    labelSearchTitle.textColor = BYColorFromHex(0x000000);
    [self.viewSearch addSubview:labelSearchTitle];
    
    self.labelNumberOftourist.frame = CGRectMake(imageSearchIcon.ctRight + 5, 37, 250, 20);
    [self.viewSearch addSubview:self.labelNumberOftourist];
    
    UIImageView *imageSearchIndecator = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 18, 85, 8, 13)];
    imageSearchIndecator.image = [UIImage imageNamed:@"icon_search_indecator"];
    [self addSubview:imageSearchIndecator];
    
}

- (void)resetDataToView:(NSDictionary *)dicData {
    self.labelNumberOftourist.text = @"2000多名专业的向导，为您提供服务";
    [self.labelNumberOftourist highLightNumberTextforColor:BYColorFromHex(0xff5555)];
    [self.scrollTop removeAllSubView];
    NSArray *arrayIMG = [dicData objectForKey:@"img"];
    self.scrollTop.contentSize = CGSizeMake(SCREENWIDTH * arrayIMG.count, 45);
    for (int i = 0; i < arrayIMG.count; i++) {
        WebImageView *image = [[WebImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, self.scrollTop.viewHeight)];
        image.userInteractionEnabled = YES;
        NSURL *url = [NSURL URLWithString:[arrayIMG objectAtIndex:i]];
        [image setImageWithURL:url];
        image.tag = 100 + i;
        [self.scrollTop addSubview:image];
        
        UIControl *tapControl = [[UIControl alloc] initWithFrame:image.frame];
        [tapControl addTarget:self action:@selector(didTapImage:) forControlEvents:UIControlEventTouchDown];
        tapControl.tag = 200 + i;
        [self.scrollTop addSubview:tapControl];
    }
    
}

- (void)didTapImage:(UIControl *) sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickHeaderImageBannerAtIndex:withUrl:)]) {
        [_delegate didClickHeaderImageBannerAtIndex:(sender.tag - 200) withUrl:nil];
    }
    
}

- (void)didClickSearch {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickHeaderSearch)]) {
        [_delegate didClickHeaderSearch];
    }
}
@end
