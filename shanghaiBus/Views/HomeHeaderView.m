//
//  HomeHeaderView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UIImageView+AFNetworking.h"
#import "WebImage.h"
#import "WebImageView.h"
#import "JXBAdPageView.h"
#import "Config.h"

@interface HomeHeaderView () <UIScrollViewDelegate, JXBAdPageViewDelegate>

@property (nonatomic, strong) WebImageView *imageBanner;
@property (nonatomic, strong) JXBAdPageView *adView;
//headerSearch
@property (nonatomic, strong) UIButton *viewSearch;
@property (nonatomic, strong) UILabel *labelNumberOftourist;


@property (nonatomic, strong) NSMutableArray *arrayImageUrl;

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

- (JXBAdPageView *)adView {
    if (_adView == nil) {
        _adView = [[JXBAdPageView alloc] init];
        _adView.delegate = self;
        _adView.iDisplayTime = 3;
        _adView.bWebImage = YES;
        [self addSubview:_adView];
    }
    return _adView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.arrayImageUrl = [NSMutableArray array];
        [self initUI];
    }
    return self;
}

#pragma mark - private Methods
- (void)initUI {

    self.adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);

    self.viewSearch.frame = CGRectMake(0, 0, SCREENWIDTH, 60);
    [self addSubview:self.viewSearch];
    
    UIImageView *imageSearchBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 82)];
    imageSearchBack.image = [UIImage imageNamed:@"icon_searchBackground"];
    [self.viewSearch addSubview:imageSearchBack];

    UIImageView *imageSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 17, 17)];
    imageSearchIcon.image = [UIImage imageNamed:@"icon_search"];
    [self.viewSearch addSubview:imageSearchIcon];
    
    UILabel *labelSearchTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageSearchIcon.ctRight + 5, 20, 200, 20)];
    labelSearchTitle.backgroundColor = [UIColor whiteColor];
    labelSearchTitle.text = @"你想去哪里玩?";
    labelSearchTitle.font = [UIFont boldSystemFontOfSize:15];
    labelSearchTitle.textColor = BYColorFromHex(0x000000);
    [self.viewSearch addSubview:labelSearchTitle];
    
    self.labelNumberOftourist.frame = CGRectMake(imageSearchIcon.ctRight + 5, 40, 250, 20);
    self.labelNumberOftourist.text = @"2000多名专业的向导，为您提供服务";
    [self.labelNumberOftourist highLightNumberTextforColor:BYColorFromHex(0xff5555)];

    [self.viewSearch addSubview:self.labelNumberOftourist];
    
    UIImageView *imageSearchIndecator = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 18, 45, 8, 13)];
    imageSearchIndecator.image = [UIImage imageNamed:@"icon_search_indecator"];
    [self.viewSearch addSubview:imageSearchIndecator];
    
}

- (void)resetDataToView:(NSDictionary *)dicData {
   __weak NSArray *arrayIMG = [dicData objectForKey:@"img"];
    if (arrayIMG.count == 0) {
        return;
    }
    
    self.viewSearch.ctTop = 40;
    [self.arrayImageUrl removeAllObjects];
    for (NSDictionary *dic in arrayIMG) {
        [self.arrayImageUrl addObject:[dic objectForKey:@"imageUrl"]];
    }
    
    [self.adView startAdsWithBlock:self.arrayImageUrl block:^(NSInteger clickIndex){
        NSLog(@"%d",(int)clickIndex);
        if (_delegate && [_delegate respondsToSelector:@selector(didClickHeaderImageBannerAtIndex:withUrl:)]) {
            [_delegate didClickHeaderImageBannerAtIndex:clickIndex withUrl:[arrayIMG objectAtIndex:clickIndex]];
        }
    }];

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

- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl withIndex:(NSInteger)index{
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:[self.arrayImageUrl objectAtIndex:index]]];
    
}
@end
