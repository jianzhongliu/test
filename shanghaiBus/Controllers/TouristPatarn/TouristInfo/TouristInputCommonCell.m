//
//  TouristInputCommonCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/1.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristInputCommonCell.h"
#import "WebImage.h"
#import "UserCachBean.h"
#import "Config.h"

@interface TouristInputCommonCell ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView  *imageIcon;
@property (nonatomic, strong) UIButton *buttonGender;


@property (nonatomic, strong) UIImageView *imageIndicator;

@property (nonatomic, strong) UILabel *labelContent;

@property (nonatomic, strong) UIView *viewLine;


@end


@implementation TouristInputCommonCell

- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textColor = BYBlackColor;
        _labelTitle.font = [UIFont systemFontOfSize:13];
        _labelTitle.text = @"====";
        
    }
    return _labelTitle;
}

- (UIImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[UIImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon"];
        _imageIcon.clipsToBounds = YES;
        _imageIcon.userInteractionEnabled = YES;
        _imageIcon.hidden = YES;
    }
    return _imageIcon;
}

- (UIButton *)buttonGender {
    if (_buttonGender == nil) {
        _buttonGender = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonGender setImage:[UIImage imageNamed:@"icon_man"] forState:UIControlStateNormal];
        [_buttonGender setImage:[UIImage imageNamed:@"icon_female"] forState:UIControlStateSelected];
        [_buttonGender addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonGender.selected = NO;
        [_buttonGender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonGender.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonGender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _buttonGender.hidden = YES;
    }
    return _buttonGender;
}

- (UITextField *)textPhone {
    if (_textPhone == nil) {
        _textPhone = [[UITextField alloc] init];
        _textPhone.textColor = [UIColor blackColor];
        _textPhone.placeholder = @"输入手机号码";
        _textPhone.hidden = YES;
        _textPhone.keyboardType = UIKeyboardTypePhonePad;
    }
    return _textPhone;
}

- (UIImageView *)imageIndicator {
    if (_imageIndicator == nil) {
        _imageIndicator = [[UIImageView alloc] init];
        _imageIndicator.image = [UIImage imageNamed:@"icon_search_indecator"];
        _imageIndicator.clipsToBounds = YES;
        _imageIndicator.userInteractionEnabled = YES;
        _imageIndicator.hidden = YES;
    }
    return _imageIndicator;
}

- (UILabel *)labelContent {
    if (_labelContent == nil) {
        _labelContent = [[UILabel alloc] init];
        _labelContent.numberOfLines = 0;
        _labelContent.lineBreakMode = NSLineBreakByCharWrapping;
        _labelContent.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelContent.font = [UIFont systemFontOfSize:13];
    }
    return _labelContent;
}

- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREENWIDTH, 1)];
        _viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    }
    return _viewLine;
}

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.labelTitle.frame = CGRectMake(10, 10, 100, 25);
    [self.contentView addSubview:self.labelTitle];

    self.imageIcon.frame = CGRectMake(SCREENWIDTH - 50, 5, 35, 35);
    [self.contentView addSubview:self.imageIcon];
    self.imageIcon.layer.cornerRadius = self.imageIcon.viewWidth / 2;
    self.imageIcon.clipsToBounds = YES;
    
    self.buttonGender.frame = CGRectMake(SCREENWIDTH - 100, 7, 85, 30);
    [self.contentView addSubview:self.buttonGender];
    
    self.textPhone.frame = CGRectMake(110, 12, 180, 20);
    [self.contentView addSubview:self.textPhone];
    
    self.imageIndicator.frame = CGRectMake(SCREENWIDTH - 20, 15, 8, 13);
    [self.contentView addSubview:self.imageIndicator];
    
    self.labelContent.frame = CGRectMake(120, 10, 180, 20);
    [self.contentView addSubview:self.labelContent];
    
    self.viewLine.frame = CGRectMake(0, 43, SCREENWIDTH, 1);
    [self.contentView addSubview:self.viewLine];
    
    
}

- (void)didStatusChange:(UIButton *) sender {
    if (sender.selected == YES) {
        sender.selected = NO;
    } else {
        sender.selected = YES;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didGenderChange:)]) {
        [_delegate didGenderChange:sender.selected];
    }
}

- (void)configCellWithData:(id) celldata {
    
    self.imageIcon.hidden = YES;
    self.buttonGender.hidden = YES;
    self.textPhone.hidden = YES;
    self.imageIndicator.hidden = YES;
    self.viewLine.hidden = YES;
    self.labelContent.hidden = YES;
    
    switch (self.cellType) {
        case CELLTYPEICON:
        {
            self.labelTitle.text = @"上传头像";
            NSString *icon = [[[UserCachBean share] touristInfo] icon];
            [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"icon_tourist_head"]];
            self.imageIcon.hidden = NO;
        }
            break;
        case CELLTYPEGENDER:
        {
            
            self.labelTitle.text = @"性别";
            self.buttonGender.hidden = NO;
            
        }
            break;
        case CELLTYPEINPUT:
        {
            
            self.labelTitle.text = @"手机号码";
            self.textPhone.hidden = NO;
            
        }
            break;
        case CELLTYPECOMMON:
        {
            
            self.labelTitle.text = [celldata objectForKey:@"title"];
            self.labelContent.text = [celldata objectForKey:@"content"];
            
            self.imageIndicator.hidden = NO;
            self.viewLine.hidden = NO;
            self.labelContent.hidden = NO;
        }
            break;
        default:
            break;
    }

}

@end
