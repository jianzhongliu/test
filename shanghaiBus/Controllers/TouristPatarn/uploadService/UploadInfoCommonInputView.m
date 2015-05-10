//
//  UploadInfoCommonInputView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/4.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UploadInfoCommonInputView.h"
#import "Config.h"

@interface UploadInfoCommonInputView ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIView *viewLine;

@end

@implementation UploadInfoCommonInputView
#pragma mark - getter && setter

- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textColor = BYBlackColor;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labelTitle;
}

- (UITextField *)textInput {
    if (_textInput == nil) {
        _textInput = [[UITextField alloc] init];
        _textInput.textColor = [UIColor blackColor];
    }
    return _textInput;
}

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
        _viewLine.hidden = YES;
    }
    return _viewLine;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.labelTitle.frame = CGRectMake(10, 10, 100, 25);
    [self addSubview:self.labelTitle];
    
    self.textInput.frame = CGRectMake(110, 10, 180, 25);
    [self addSubview:self.textInput];
    
    self.viewLine.frame = CGRectMake(0, 43, SCREENWIDTH, 1);
    [self addSubview:self.viewLine];
}

- (void)configViewWithData:(id) data {
    self.viewLine.hidden = YES;
    
    switch (self.viewType) {
        case INPUTVIEWTYPENAME:
        {
            self.labelTitle.text = @"姓名";
            self.textInput.placeholder = @"请输入真实姓名";
        }
            break;
        case INPUTVIEWTYPEIDENTIFY:
        {
            self.labelTitle.text = @"身份证号";
            self.textInput.placeholder = @"请输入身份证号码";
            self.viewLine.hidden = NO;
        }
            break;
        case INPUTVIEWTYPEPHONE:
        {
            self.labelTitle.text = @"手机号";
            self.textInput.placeholder = @"请输入手机号";
            self.viewLine.hidden = NO;
        }
            break;
        case INPUTVIEWTYPECODE:
        {
            self.labelTitle.text = @"验证码";
            self.textInput.placeholder = @"请输入验证码";
            self.viewLine.hidden = NO;
        }
            break;
        default:
            break;
    }
    
}

- (CGFloat)fetchViewHeight {
    return 0;
}

@end
