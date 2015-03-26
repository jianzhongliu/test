//
//  TouristCommonView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristCommentView.h"
#import "WebImageView.h"
#import "Config.h"
#import "TouristObject.h"

@interface TouristCommentView ()

@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UILabel *labelHeaderTitle;
@property (nonatomic, strong) UIButton *buttonHeader;

@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelCommon;
@property (nonatomic, strong) UIButton *buttonDetail;

@end

@implementation TouristCommentView
#pragma mark - getter && setter
- (UIView *)viewHeader {
    if (_viewHeader == nil) {
        _viewHeader = [[UIView alloc] init];
        _viewHeader.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
        [self addSubview:_viewHeader];
    }
    return _viewHeader;
}

- (UILabel *)labelHeaderTitle {
    if (_labelHeaderTitle == nil) {
        _labelHeaderTitle = [[UILabel alloc] init];
        _labelHeaderTitle.backgroundColor = [UIColor clearColor];
        _labelHeaderTitle.textColor = BYColor;
        _labelHeaderTitle.font = [UIFont systemFontOfSize:14];
        _labelHeaderTitle.text = @"评论";
        [self.viewHeader addSubview:_labelHeaderTitle];
    }
    return _labelHeaderTitle;
}

- (UIButton *)buttonHeader {
    if (_buttonHeader == nil) {
        _buttonHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonHeader setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [_buttonHeader setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonHeader addTarget:self action:@selector(didHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
        _buttonHeader.selected = NO;
        [self.viewHeader addSubview:_buttonHeader];
    }
    return _buttonHeader;
}

- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon"];
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.backgroundColor = self.backgroundColor;
        _labelName.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
        _labelName.font = [UIFont systemFontOfSize:14];
        _labelName.text = @"会飞的猪";
        [self addSubview:_labelName];
    }
    return _labelName;
}

- (UILabel *)labelDate {
    if (_labelDate == nil) {
        _labelDate = [[UILabel alloc] init];
        _labelDate.backgroundColor = [UIColor clearColor];
        _labelDate.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
        _labelDate.font = [UIFont systemFontOfSize:14];
        _labelDate.text = @"1970-12-01";
        [self addSubview:_labelDate];
    }
    return _labelDate;
}

- (UILabel *)labelCommon {
    if (_labelCommon == nil) {
        _labelCommon = [[UILabel alloc] init];
        _labelCommon.backgroundColor = self.backgroundColor;
        _labelCommon.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
        _labelCommon.font = [UIFont systemFontOfSize:14];
        _labelCommon.text = @"不会平时说的是离开手机点击电视的";
        [self addSubview:_labelCommon];
    }
    return _labelCommon;
}

- (UIButton *)buttonDetail {
    if (_buttonDetail == nil) {
        _buttonDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonDetail setTitle:@"78条评论"forState:UIControlStateNormal];
        [_buttonDetail addTarget:self action:@selector(didClickCommentDetail) forControlEvents:UIControlEventTouchUpInside];
        _buttonDetail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _buttonDetail.backgroundColor = BYColor;
        _buttonDetail.layer.cornerRadius = 6;
        [self addSubview:_buttonDetail];
    }
    return _buttonDetail;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.viewHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
    self.labelHeaderTitle.frame = CGRectMake(10, 10, 100, 30);
    self.buttonHeader.frame = CGRectMake(SCREENWIDTH - 30, 15, 20, 20);
    
    self.imageIcon.frame = CGRectMake(15, self.viewHeader.ctBottom + 5, 30, 30);
    self.imageIcon.layer.contentsScale = self.imageIcon.viewWidth / 2;
    
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, self.imageIcon.ctTop, 180, 20);
    self.labelDate.frame = CGRectMake( SCREENWIDTH - 100, self.imageIcon.ctTop, 85, 20);
    
    self.labelCommon.frame = CGRectMake(10, self.imageIcon.ctBottom + 10, SCREENHEIGHT - 20, 20);
    self.buttonDetail.frame = CGRectMake(0, self.labelCommon.ctBottom +10, SCREENWIDTH, 40);
}

- (void)configViewWithData:(TouristObject *) tourist {
    
    
}

- (void)didHeaderClick:(UIButton *) sender {
    if (YES == sender.isSelected) {
        self.buttonHeader.selected = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceCommentInfoDisplayChanged:status:)]) {
            [_delegate didTouristServiceCommentInfoDisplayChanged:self status:YES];
        }
    } else {
        self.buttonHeader.selected = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceCommentInfoDisplayChanged:status:)]) {
            [_delegate didTouristServiceCommentInfoDisplayChanged:self status:YES];
        }
    }
}

- (void)didClickCommentDetail {
    if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceDetailClick:)]) {
        [_delegate didTouristServiceDetailClick:self.cellData];
    }
}

- (CGFloat)fetchViewHeight {
    if (YES == self.buttonHeader.selected) {
        return self.viewHeader.ctBottom;
    } else {
        return self.buttonDetail.ctBottom + 10;
    }
}

@end
