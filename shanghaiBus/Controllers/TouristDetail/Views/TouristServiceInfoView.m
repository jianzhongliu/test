//
//  TouristServiceInfoView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/24.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristServiceInfoView.h"
#import "Config.h"
#import "TouristObject.h"
#import "UILabel+HightLight.h"
#import "CWStarRateView.h"

@interface TouristServiceInfoView ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UILabel *labelPriceUnit;
@property (nonatomic, strong) UILabel *labelServiceArea;
@property (nonatomic, strong) UILabel *labelLanguage;
@property (nonatomic, strong) CWStarRateView *starRateView;

@end

@implementation TouristServiceInfoView

#pragma getter&&setter
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.backgroundColor = [UIColor whiteColor];
        _labelTitle.font = [UIFont systemFontOfSize:17];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_labelTitle];
    }
    return _labelTitle;
}

- (UILabel *)labelPrice {
    if (_labelPrice == nil) {
        _labelPrice = [[UILabel alloc] init];
        _labelPrice.backgroundColor = [UIColor whiteColor];
        _labelPrice.textColor = BYColorFromHex(0xff5555);
        _labelPrice.font = [UIFont systemFontOfSize:20];
        _labelPrice.textAlignment = NSTextAlignmentRight;
        [self addSubview:_labelPrice];
    }
    return _labelPrice;
}
- (UILabel *)labelPriceUnit {
    if (_labelPriceUnit == nil) {
        _labelPriceUnit = [[UILabel alloc] init];
        _labelPriceUnit.numberOfLines = 0;
        _labelPriceUnit.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPriceUnit.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelPriceUnit.font = [UIFont systemFontOfSize:13];
    }
    return _labelPriceUnit;
}
- (UILabel *)labelServiceArea {
    if (_labelServiceArea == nil) {
        _labelServiceArea = [[UILabel alloc] init];
        _labelServiceArea.backgroundColor = [UIColor whiteColor];
        _labelServiceArea.textColor = BYColorFromHex(0x797979);
        _labelServiceArea.font = [UIFont boldSystemFontOfSize:13];
        _labelServiceArea.numberOfLines = 0;
        _labelServiceArea.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_labelServiceArea];
    }
    return _labelServiceArea;
}

- (UILabel *)labelLanguage {
    if (_labelLanguage == nil) {
        _labelLanguage = [[UILabel alloc] init];
        _labelLanguage.backgroundColor = [UIColor whiteColor];
        _labelLanguage.textColor = BYColorFromHex(0x797979);
        _labelLanguage.font = [UIFont boldSystemFontOfSize:13];
        _labelLanguage.numberOfLines = 0;
        _labelLanguage.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_labelLanguage];
    }
    return _labelLanguage;
}

#pragma mark - lifeCycle Methods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.labelTitle.frame = CGRectMake(10, 15, SCREENWIDTH - 20, 40);
    self.labelPrice.frame = CGRectMake(SCREENWIDTH - 290, 40, 280, 20);
    
}

- (void)configViewWithData:(TouristObject *) tourist {
//    @"收到了开发建设的路口附近了深刻的设计的开发卢卡斯剪短发了啊就是离开的房间了速度交罚款链接"
    self.labelTitle.text = tourist.signature;
    [self.labelTitle sizeToFit];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(10, self.labelTitle.ctBottom + 5, 100, 20) numberOfStars:5];
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = NO;
    self.starRateView.enable = NO;
    self.starRateView.scorePercent = tourist.star / 5.0;
    [self addSubview:self.starRateView];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.starRateView.ctBottom + 15, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = BYLineSepratorColor;
    [self addSubview:viewLine];
    
    self.labelPrice.text = [NSString stringWithFormat:@"%@", tourist.price];
    self.labelPrice.ctTop = self.labelTitle.ctBottom + 5;
    [self.labelPrice highLightTextInRange:NSMakeRange(tourist.price.length - 3, 3) forColor:BYColorFromHex(0x797979)];
    
    UILabel *labelAreaTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labelPrice.ctBottom + 32, 80, 20)];
    labelAreaTitle.font = [UIFont systemFontOfSize:13];
    labelAreaTitle.textColor = BYColorFromHex(0x333333);
    labelAreaTitle.backgroundColor = self.backgroundColor;
    labelAreaTitle.text = @"服务区域";
    [labelAreaTitle sizeToFit];
    [self addSubview:labelAreaTitle];
    
    self.labelServiceArea.frame = CGRectMake(labelAreaTitle.ctRight + 20, self.labelPrice.ctBottom + 30, SCREENWIDTH - 100, 20);

    UILabel *labelLanguageTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labelServiceArea.ctBottom + 7, 80, 20)];
    labelLanguageTitle.font = [UIFont systemFontOfSize:13];
    labelLanguageTitle.textColor = BYColorFromHex(0x333333);
    labelLanguageTitle.backgroundColor = self.backgroundColor;
    labelLanguageTitle.text = @"擅长语言";
    [labelLanguageTitle sizeToFit];
    [self addSubview:labelLanguageTitle];
    
    
    self.labelLanguage.frame = CGRectMake(labelAreaTitle.ctRight + 20, self.labelServiceArea.ctBottom + 5, SCREENWIDTH - 100, 20);
    
    self.labelServiceArea.text = tourist.servicearea;
    self.labelLanguage.text = tourist.language;
}

- (CGFloat)fetchViewHight {
    return self.labelLanguage.ctBottom + 20;
}
@end
