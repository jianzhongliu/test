//
//  TouristHeaderView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/16.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristHeaderView.h"
#import "WebImageView.h"
#import "Config.h"

@interface TouristHeaderView ()

@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIImageView *imageGender;
@property (nonatomic, strong) UIButton *buttonNumber;

@end

@implementation TouristHeaderView
#pragma getter && setter

- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon"];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
    }
    return _imageIcon;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelName.font = [UIFont systemFontOfSize:13];
    }
    return _labelName;
}

- (UIImageView *)imageGender {
    if (_imageGender == nil) {
        _imageGender = [[UIImageView alloc] init];
        _imageGender.image = [UIImage imageNamed:@"gender"];
        _imageGender.clipsToBounds = YES;
        _imageGender.userInteractionEnabled = YES;
    }
    return _imageGender;
}

- (UIButton *)buttonNumber {
    if (_buttonNumber == nil) {
        _buttonNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonNumber.enabled = NO;
        [_buttonNumber setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [_buttonNumber setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
//        [_buttonNumber addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonNumber.selected = NO;
    }
    return _buttonNumber;
}

#pragma mark - lifeCycleMethods
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageIcon.frame = CGRectMake(10, 10, 45, 45);
    self.imageIcon.layer.cornerRadius = self.imageIcon.viewHeight / 2;
    self.imageIcon.clipsToBounds = YES;
    [self addSubview:self.imageIcon];
    
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, 20, 100, 20);
    [self addSubview:self.labelName];
    
    self.imageGender.frame = CGRectMake(self.labelName.ctRight +5, 20, 15, 15);
    [self addSubview:self.imageGender];
    
    self.buttonNumber.frame = CGRectMake(SCREENWIDTH - 80, 10, 80, 30);
    [self addSubview:self.buttonNumber];
    
}

- (void)configViewWithData:(TouristObject *) tourist {
    self.imageIcon.imageUrl = tourist.icon;
    self.labelName.text = tourist.nuckname;
    [self.labelName sizeToFit];
    self.imageGender.viewX = self.labelName.ctRight + 5;
    NSString *number = [NSString stringWithFormat:@"%ld人已预约",(long)(tourist.commentnumber + tourist.messagenumber)];
    [self.buttonNumber setTitle:number forState:UIControlStateNormal];
    [self addSubview:self.buttonNumber];
}

- (CGFloat)fetchViewHeight {
    return 65;
}

@end
