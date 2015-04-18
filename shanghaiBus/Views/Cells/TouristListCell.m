//
//  TouristListCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristListCell.h"
#import "WebImageView.h"
#import "Config.h"

@interface TouristListCell ()

@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelSignature;
@property (nonatomic, strong) UILabel *labelNuckName;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) WebImageView *imageGender;

@end

@implementation TouristListCell

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

- (UILabel *)labelSignature {
    if (_labelSignature == nil) {
        _labelSignature = [[UILabel alloc] init];
        _labelSignature.text = @"";
        _labelSignature.font = [UIFont boldSystemFontOfSize:16];
        _labelSignature.backgroundColor = [UIColor whiteColor];
        _labelSignature.textColor = BYColorAlphaMake(0, 0, 0, 1);
        _labelSignature.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelSignature];
    }
    return _labelSignature;
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

- (UILabel *)labelPrice {
    if (_labelPrice == nil) {
        _labelPrice = [[UILabel alloc] init];
        _labelPrice.text = @"";
        _labelPrice.font = [UIFont systemFontOfSize:20];
        _labelPrice.backgroundColor = [UIColor whiteColor];
        _labelPrice.textColor = BYColorFromHex(0x797979);
        _labelPrice.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_labelPrice];
    }
    return _labelPrice;
}

#pragma mark - lifeycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageIcon.frame = CGRectMake(10, 10, 80, 80);
    self.labelSignature.frame = CGRectMake(self.imageIcon.ctRight + 10, 10, SCREENWIDTH - 110, 20);
    self.labelNuckName.frame = CGRectMake(self.labelSignature.ctLeft, self.labelSignature.ctBottom + 10, 180, 20);
    self.labelPrice .frame = CGRectMake(SCREENWIDTH - 110, self.labelSignature.ctBottom + 5, 100, 20);
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 100 - 1, SCREENHEIGHT, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    [self.contentView addSubview:viewLine];
    
}

- (void)resetCellDataWith:(TouristObject *) tourist {
    self.imageIcon.imageUrl = tourist.icon;
    self.labelSignature.text = tourist.signature;
    self.labelNuckName.text = tourist.nuckname;
    self.labelPrice.text = [NSString stringWithFormat:@"%@", tourist.price];
    [self.labelPrice highLightNumberTextforColor:BYColorFromHex(0xff5555)];
    self.labelNuckName.viewWidth = 180;
    [self.labelNuckName sizeToFit];
    self.imageGender.frame = CGRectMake(self.labelNuckName.ctRight, self.labelNuckName.ctTop, 20, 20);
    
    NSMutableArray *arrayTag = [NSMutableArray array];
    [arrayTag addObject:@"实名"];
    
    NSArray *arrayOriginTag = [tourist.tag componentsSeparatedByString:@"|"];
    [arrayTag addObjectsFromArray:arrayOriginTag];
    CGFloat pointX = self.imageIcon.ctRight + 10;
    
    for (int i = 0; i < arrayTag.count; i ++) {
        UILabel *labelTag = [[UILabel alloc] initWithFrame:CGRectMake(pointX, self.labelNuckName.ctBottom + 15, 50, 20)];
        labelTag.text = @"驾照 ";
        labelTag.layer.cornerRadius = 1;
        labelTag.font = [UIFont systemFontOfSize:12];
        labelTag.textAlignment = NSTextAlignmentCenter;
        labelTag.textColor = BYColor;
        labelTag.layer.borderColor = BYColor.CGColor;
        labelTag.layer.borderWidth = 0.5;
        [labelTag sizeToFit];
        labelTag.viewHeight = 20;
        [self.contentView addSubview:labelTag];
        
        pointX = pointX + labelTag.viewWidth + 8;
    }
    
}

@end
