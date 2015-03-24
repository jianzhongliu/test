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

@interface TouristServiceInfoView ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UILabel *labelServiceArea;
@property (nonatomic, strong) UILabel *labelLanguage;

@end

@implementation TouristServiceInfoView

#pragma getter&&setter
- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.backgroundColor = self.backgroundColor;
        _labelTitle.textColor = BYColorFromHex(0x999999);
        _labelTitle.font = [UIFont boldSystemFontOfSize:15];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_labelTitle];
    }
    return _labelTitle;
}

- (UILabel *)labelPrice {
    if (_labelPrice == nil) {
        _labelPrice = [[UILabel alloc] init];
        _labelPrice.backgroundColor = self.backgroundColor;
        _labelPrice.textColor = BYColorFromHex(0x999999);
        _labelPrice.font = [UIFont boldSystemFontOfSize:15];
        _labelPrice.textAlignment = NSTextAlignmentRight;
        [self addSubview:_labelPrice];
    }
    return _labelPrice;
}

- (UILabel *)labelServiceArea {
    if (_labelServiceArea == nil) {
        _labelServiceArea = [[UILabel alloc] init];
        _labelServiceArea.backgroundColor = self.backgroundColor;
        _labelServiceArea.textColor = BYColorFromHex(0x999999);
        _labelServiceArea.font = [UIFont boldSystemFontOfSize:15];
        _labelServiceArea.numberOfLines = 0;
        _labelServiceArea.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_labelServiceArea];
    }
    return _labelServiceArea;
}

- (UILabel *)labelLanguage {
    if (_labelLanguage == nil) {
        _labelLanguage = [[UILabel alloc] init];
        _labelLanguage.backgroundColor = self.backgroundColor;
        _labelLanguage.textColor = BYColorFromHex(0x999999);
        _labelLanguage.font = [UIFont boldSystemFontOfSize:15];
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
    self.labelTitle.frame = CGRectMake(10, 0, SCREENWIDTH - 20, 35);
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.labelTitle.ctBottom + 3, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.2);
    [self addSubview:viewLine];
    
    self.labelPrice.frame = CGRectMake(SCREENWIDTH - 90, 40, 80, 20);
    UILabel *labelAreaTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labelPrice.ctBottom +3, 80, 20)];
    labelAreaTitle.font = [UIFont systemFontOfSize:13];
    labelAreaTitle.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
    labelAreaTitle.backgroundColor = self.backgroundColor;
    [self addSubview:labelAreaTitle];
    self.labelServiceArea.frame = CGRectMake(100, self.labelPrice.ctBottom +3, SCREENWIDTH - 100, 20);
    
   UILabel *labelLanguageTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labelServiceArea.ctBottom +3, 80, 20)];
    labelLanguageTitle.font = [UIFont systemFontOfSize:13];
    labelLanguageTitle.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
    labelLanguageTitle.backgroundColor = self.backgroundColor;
    [self addSubview:labelLanguageTitle];
    
    self.labelLanguage.frame = CGRectMake(100, self.labelServiceArea.ctBottom +3, SCREENWIDTH - 100, 20);
}

- (void)configViewWithData:(TouristObject *) tourist {
    self.labelTitle.text = tourist.signature;
    self.labelPrice.text = [NSString stringWithFormat:@"%@元/天", tourist.price];
    [self.labelPrice highLightTextInRange:NSMakeRange(0, tourist.price.length) forColor:[UIColor redColor]];
    self.labelServiceArea.text = tourist.servicearea;
    self.labelLanguage.text = tourist.language;
}

- (CGFloat)fetchViewHight {
    return self.labelLanguage.ctBottom;
}
@end
