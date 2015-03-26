//
//  TouristServiceDetailView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/24.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristServiceDetailView.h"
#import "Config.h"

@interface TouristServiceDetailView ()

@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UILabel *labelHeaderTitle;
@property (nonatomic, strong) UIButton *buttonHeader;
@property (nonatomic, strong) UILabel *labelDetail;
@end

@implementation TouristServiceDetailView
#pragma mark - getter&&setter
- (UILabel *)labelDetail {
    if (_labelDetail == nil) {
        _labelDetail = [[UILabel alloc] init];
        _labelDetail.backgroundColor = self.backgroundColor;
        _labelDetail.numberOfLines = 0;
        _labelDetail.lineBreakMode = NSLineBreakByCharWrapping;
        _labelDetail.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelDetail.font = [UIFont systemFontOfSize:13];
        [self addSubview:_labelDetail];
    }
    return _labelDetail;
}

- (UIButton *)buttonHeader {
    if (_buttonHeader == nil) {
        _buttonHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonHeader setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];//隐藏
        [_buttonHeader setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];//展开
        [_buttonHeader addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonHeader.selected = NO;//默认隐藏
    }
    return _buttonHeader;

}
- (void)isShow:(BOOL) status {
    if (YES == status) {
        self.buttonHeader.selected = YES;
    } else {
        self.buttonHeader.selected = NO;
    }
}

#pragma  mark - lifeCycle
- (id)init {
    if (self = [super init]) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData {
    self.isShow = NO;
}

- (void)initUI {
    self.viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    self.viewHeader.backgroundColor = self.backgroundColor;
    [self addSubview:self.viewHeader];
    
    self.labelHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 30)];
    self.labelHeaderTitle.font = [UIFont systemFontOfSize:15];
    self.labelHeaderTitle.textColor = BYColorAlphaMake(0, 0, 0, 0.5);
    self.labelHeaderTitle.backgroundColor = self.viewHeader.backgroundColor;
    [self.viewHeader addSubview:self.labelHeaderTitle];
    
    self.buttonHeader.frame = CGRectMake(SCREENWIDTH - 30, 5, 20, 20);
    [self.viewHeader addSubview:self.buttonHeader];
    self.labelDetail.frame = CGRectMake(10, self.viewHeader.ctBottom, SCREENWIDTH - 20, 100);
}

- (void)configViewWithTitle:(NSString *) title detail:(NSString *) detailInfo {
    self.labelHeaderTitle.text = title;
    self.labelDetail.text = detailInfo;
    [self.labelDetail sizeThatFits:CGSizeMake(SCREENWIDTH - 20, 20000)];
    [self.labelDetail sizeToFit];
}

- (void)didStatusChange:(id) sender {
    UIButton *statusButton = (UIButton *)sender;
    if (YES == statusButton.isSelected) {
        self.buttonHeader.selected = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceDetailInfoDisplayChanged:status:)]){
            [_delegate didTouristServiceDetailInfoDisplayChanged:self status:YES];
        }
    } else {
        self.buttonHeader.selected = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceDetailInfoDisplayChanged:status:)]){
            [_delegate didTouristServiceDetailInfoDisplayChanged:self status:NO];
        }
    }
}

- (CGFloat)fetchViewHeight {
    if (YES == self.buttonHeader.selected) {
        return self.viewHeader.viewHeight;
    } else {
        return self.viewHeader.viewHeight + self.labelDetail.viewHeight;
    }
}

@end
