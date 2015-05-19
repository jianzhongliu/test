//
//  MessageInfoCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MessageInfoCell.h"
#import "WebImageView.h"
#import "UIView+CTExtensions.h"
#import "Config.h"

@interface MessageInfoCell ()

@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelNuckName;
@property (nonatomic, strong) UILabel *labelContent;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) WebImageView *imageGender;

@end

@implementation MessageInfoCell

#pragma mark - getter&&setter
- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon_default_header"];
        [self.contentView addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (WebImageView *)imageGender {
    if (_imageGender == nil) {
        _imageGender = [[WebImageView alloc] init];
        _imageGender.image = [UIImage imageNamed:@"icon_gender_man"];
        [self.contentView addSubview:_imageGender];
    }
    return _imageGender;
}

- (UILabel *)labelContent {
    if (_labelContent == nil) {
        _labelContent = [[UILabel alloc] init];
        _labelContent.text = @"";
        _labelContent.font = [UIFont boldSystemFontOfSize:16];
        _labelContent.backgroundColor = [UIColor whiteColor];
        _labelContent.textColor = BYColorAlphaMake(0, 0, 0, 1);
        _labelContent.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelContent];
    }
    return _labelContent;
}

- (UILabel *)labelNuckName {
    if (_labelNuckName == nil) {
        _labelNuckName = [[UILabel alloc] init];
        _labelNuckName.text = @"";
        _labelNuckName.font = [UIFont systemFontOfSize:14];
        _labelNuckName.backgroundColor = [UIColor whiteColor];
        _labelNuckName.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelNuckName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelNuckName];
    }
    return _labelNuckName;
}

- (UILabel *)labelTime {
    if (_labelTime == nil) {
        _labelTime = [[UILabel alloc] init];
        _labelTime.text = @"";
        _labelTime.font = [UIFont systemFontOfSize:20];
        _labelTime.backgroundColor = [UIColor whiteColor];
        _labelTime.textColor = BYColorFromHex(0x797979);
        _labelTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_labelTime];
    }
    return _labelTime;
}

#pragma mark - lifeycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageIcon.frame = CGRectMake(15, 15, 35, 35);
    self.imageIcon.layer.cornerRadius = self.imageIcon.ctWidth / 2;
    [self.imageIcon clipsToBounds];
    
    self.labelNuckName.frame = CGRectMake(self.imageIcon.ctRight + 10, 10, SCREENWIDTH - 110, 20);
    self.labelContent.frame = CGRectMake(self.labelNuckName.ctLeft, self.labelNuckName.ctBottom + 10, 180, 20);

    self.labelTime .frame = CGRectMake(SCREENWIDTH - 110, self.labelContent.ctBottom + 5, 100, 20);
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 100 - 1, SCREENHEIGHT, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    [self.contentView addSubview:viewLine];
    
}

//- (void)resetCellDataWith:(TouristObject *) tourist {
//    self.imageIcon.imageUrl = tourist.icon;
//    self.labelSignature.text = tourist.signature;
//    self.labelNuckName.text = tourist.nuckname;
//    self.labelPrice.text = [NSString stringWithFormat:@"%@", tourist.price];
//    [self.labelPrice highLightNumberTextforColor:BYColorFromHex(0xff5555)];
//    self.labelNuckName.viewWidth = 180;
//    [self.labelNuckName sizeToFit];
//    self.imageGender.frame = CGRectMake(self.labelNuckName.ctRight, self.labelNuckName.ctTop, 20, 20);
//    
//    NSMutableArray *arrayTag = [NSMutableArray array];
//    [arrayTag addObject:@"实名"];
//    
//    NSArray *arrayOriginTag = [tourist.tag componentsSeparatedByString:@"|"];
//    [arrayTag addObjectsFromArray:arrayOriginTag];
//    CGFloat pointX = self.imageIcon.ctRight + 10;
//    
//    for (int i = 0; i < arrayTag.count; i ++) {
//        UILabel *labelTag = [[UILabel alloc] initWithFrame:CGRectMake(pointX, self.labelNuckName.ctBottom + 15, 50, 20)];
//        labelTag.text = @"驾照 ";
//        labelTag.layer.cornerRadius = 1;
//        labelTag.font = [UIFont systemFontOfSize:12];
//        labelTag.textAlignment = NSTextAlignmentCenter;
//        labelTag.textColor = BYColor;
//        labelTag.layer.borderColor = BYColor.CGColor;
//        labelTag.layer.borderWidth = 0.5;
//        [labelTag sizeToFit];
//        labelTag.viewHeight = 20;
//        [self.contentView addSubview:labelTag];
//        
//        pointX = pointX + labelTag.viewWidth + 8;
//    }
//    
//}

@end
