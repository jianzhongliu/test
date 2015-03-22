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

- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"IMG_0146.JPG"];
        [self.contentView addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (WebImageView *)imageGender {
    if (_imageGender == nil) {
        _imageGender = [[WebImageView alloc] init];
        _imageGender.image = [UIImage imageNamed:@"gender"];
        [self.contentView addSubview:_imageGender];
    }
    return _imageGender;
}

- (UILabel *)labelSignature {
    if (_labelSignature == nil) {
        _labelSignature = [[UILabel alloc] init];
        _labelSignature.text = @"";
        _labelSignature.font = [UIFont boldSystemFontOfSize:14];
        _labelSignature.backgroundColor = [UIColor whiteColor];
        _labelSignature.textColor = BYColorAlphaMake(0, 0, 0, 0.9);
        _labelSignature.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelSignature];
    }
    return _labelSignature;
}

- (UILabel *)labelNuckName {
    if (_labelNuckName == nil) {
        _labelNuckName = [[UILabel alloc] init];
        _labelNuckName.text = @"";
        _labelNuckName.font = [UIFont systemFontOfSize:13];
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
        _labelPrice.font = [UIFont systemFontOfSize:14];
        _labelPrice.backgroundColor = [UIColor whiteColor];
        _labelPrice.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
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
    self.imageIcon.frame = CGRectMake(5, 5, 70, 70);
    self.labelSignature.frame = CGRectMake(self.imageIcon.ctRight + 10, 5, SCREENWIDTH - 80, 20);
    self.labelNuckName.frame = CGRectMake(self.labelSignature.ctLeft, self.labelSignature.ctBottom + 5, 80, 20);
    self.labelPrice .frame = CGRectMake(SCREENWIDTH - 90, self.labelSignature.ctBottom + 5, 80, 20);
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 80 - 1, SCREENHEIGHT, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    [self.contentView addSubview:viewLine];
    
}

- (void)resetCellDataWith:(TouristObject *) tourist {
    self.imageIcon.imageUrl = tourist.icon;
    self.labelSignature.text = tourist.signature;
    self.labelNuckName.text = tourist.nuckname;
    self.labelPrice.text = [NSString stringWithFormat:@"%@元/天", tourist.price];
    [self.labelPrice highLightTextInRange:NSMakeRange(0, tourist.price.length) forColor:[UIColor redColor]];
    [self.labelNuckName sizeToFit];
    self.imageGender.frame = CGRectMake(self.labelNuckName.ctRight, self.labelNuckName.ctTop, 15, 15);
    
    UILabel *labelTag = [[UILabel alloc] initWithFrame:CGRectMake(self.imageIcon.ctRight + 10, self.labelNuckName.ctBottom +5, 50, 20)];
    labelTag.text = @"驾照";
    labelTag.layer.cornerRadius = 6;
    labelTag.textAlignment = NSTextAlignmentCenter;
    labelTag.textColor = BYColor;
    labelTag.layer.borderColor = BYColor.CGColor;
    labelTag.layer.borderWidth = 1;
    [self.contentView addSubview:labelTag];
}

@end
