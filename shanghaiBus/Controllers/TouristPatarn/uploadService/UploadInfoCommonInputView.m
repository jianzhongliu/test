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
@property (nonatomic, strong) UIImageView *imageInderector;
@property (nonatomic, strong) UILabel *labelUnit;

@end

@implementation UploadInfoCommonInputView

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
    
    self.imageInderector.frame = CGRectMake(SCREENWIDTH - 22, 16, 7, 12);
    [self addSubview:self.imageInderector];
    
    self.labelUnit.frame = CGRectMake(SCREENWIDTH - 100, 10, 90, 25);
    [self addSubview:self.labelUnit];
}

- (void)configViewWithTitle:(NSString *) title{
    self.viewLine.hidden = NO;
    self.labelTitle.text = title;
    self.textInput.enabled = NO;
//    self.textInput.hidden = YES;
    self.imageInderector.hidden = NO;
    
    switch (self.viewType) {
        case VIEWTYPENAME:
        {
            self.textInput.placeholder = @"(必填)";
        }
            break;
        case VIEWTYPEINPUT:
        {
            
        }
            break;
        case VIEWTYPEPRICE:
        {
            self.textInput.placeholder = @"(必填)";
            self.labelUnit.hidden = NO;
            self.textInput.hidden = NO;
            self.imageInderector.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (CGFloat)fetchViewHeight {
    return 0;
}
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

- (UIImageView *)imageInderector {
    if (_imageInderector == nil) {
        _imageInderector = [[UIImageView alloc] init];
        _imageInderector.image = [UIImage imageNamed:@"icon_inderector"];
        _imageInderector.clipsToBounds = YES;
        _imageInderector.userInteractionEnabled = YES;
        _imageInderector.hidden = YES;
    }
    return _imageInderector;
}

- (UILabel *)labelUnit {
    if (_labelUnit == nil) {
        _labelUnit = [[UILabel alloc] init];
        _labelUnit.numberOfLines = 0;
        _labelUnit.lineBreakMode = NSLineBreakByCharWrapping;
        _labelUnit.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelUnit.font = [UIFont systemFontOfSize:13];
        _labelUnit.textAlignment = NSTextAlignmentRight;
        _labelUnit.text = @"元/天";
        _labelUnit.hidden = YES;
    }
    return _labelUnit;
}

@end
