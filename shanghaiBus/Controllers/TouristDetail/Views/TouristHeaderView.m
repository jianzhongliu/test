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
        _imageIcon.image = [UIImage imageNamed:@"icon_default_header"];
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
//        _labelName.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelName.font = [UIFont systemFontOfSize:14];
    }
    return _labelName;
}

- (UIImageView *)imageGender {
    if (_imageGender == nil) {
        _imageGender = [[UIImageView alloc] init];
        _imageGender.image = [UIImage imageNamed:@"icon_gender_man"];
        _imageGender.clipsToBounds = YES;
        _imageGender.userInteractionEnabled = YES;
    }
    return _imageGender;
}

- (UIButton *)buttonNumber {
    if (_buttonNumber == nil) {
        _buttonNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNumber setBackgroundImage:[UIImage imageNamed:@"orderNumber"] forState:UIControlStateNormal];
        [_buttonNumber setBackgroundImage:[UIImage imageNamed:@"orderNumber"] forState:UIControlStateSelected];
        [_buttonNumber setBackgroundImage:[UIImage imageNamed:@"orderNumber"] forState:UIControlStateHighlighted];
        [_buttonNumber setTitle:@"--人已预订" forState:UIControlStateNormal];
        [_buttonNumber setFont:[UIFont systemFontOfSize:12]];
        
//        [_buttonNumber addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
//        _buttonNumber.selected = NO;
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
    self.imageIcon.frame = CGRectMake(10, 10, 35, 35);
    self.imageIcon.layer.cornerRadius = self.imageIcon.viewHeight / 2;
    self.imageIcon.clipsToBounds = YES;
    [self addSubview:self.imageIcon];
    
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, 20, 100, 35);
    [self addSubview:self.labelName];
    
    self.imageGender.frame = CGRectMake(self.labelName.ctRight +5, 20, 20, 20);
    [self addSubview:self.imageGender];
    
    self.buttonNumber.frame = CGRectMake(SCREENWIDTH - 85, 13, 85, 30);
    [self addSubview:self.buttonNumber];
    
}

- (void)configViewWithData:(TouristObject *) tourist {
    self.imageIcon.imageUrl = tourist.icon;
    self.labelName.text = tourist.nuckname;
    [self.labelName sizeToFit];
    self.imageGender.viewX = self.labelName.ctRight + 5;
    NSString *number = [NSString stringWithFormat:@"%ld人已预约",(long)(tourist.commentnumber + tourist.messagenumber)];
    [self.buttonNumber setTitle:number forState:UIControlStateNormal];
    
}

- (CGFloat)fetchViewHeight {
    return 55;
}

@end
