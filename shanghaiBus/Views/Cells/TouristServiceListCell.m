//
//  TouristServiceListCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristServiceListCell.h"
#import "WebImageView.h"
#import "Config.h"

@interface TouristServiceListCell ()

@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelSignature;
@property (nonatomic, strong) UILabel *labelNuckName;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UILabel *labelStatus;

@end

@implementation TouristServiceListCell

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
    self.labelStatus.frame = CGRectMake(SCREENWIDTH - 50, self.labelPrice.ctBottom + 5, 45, 20);

}

- (void)configCellDataWith:(ServiceObject *) service {
    TouristObject *tourist = [[UserCachBean share] touristInfo];
    
    self.imageIcon.imageUrl = tourist.icon;
    self.labelSignature.text = service.otherinfoid;
    self.labelNuckName.text = tourist.nuckname;
    self.labelPrice.text = [NSString stringWithFormat:@"%@", service.price];
    [self.labelPrice highLightNumberTextforColor:BYColorFromHex(0xff5555)];
    self.labelNuckName.viewWidth = 180;
    [self.labelNuckName sizeToFit];

    self.labelStatus.text = service.status;
    self.labelStatus.layer.cornerRadius = 4;
    self.labelStatus.clipsToBounds = YES;
    self.labelStatus.textColor = [UIColor whiteColor];
    if ([self.labelStatus.text isEqualToString:@"已通过"]) {
        self.labelStatus.backgroundColor = [UIColor greenColor];
    } else if ([self.labelStatus.text isEqualToString:@"未通过"]) {
        self.labelStatus.backgroundColor = [UIColor redColor];
    } else if ([self.labelStatus.text isEqualToString:@"待审核"]) {
        self.labelStatus.backgroundColor = [UIColor brownColor];
        self.labelStatus.textColor = BYColorAlphaMake(0, 0, 0, 0.7);
    } else {
        self.labelStatus.textColor = [UIColor blackColor];
        self.labelStatus.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - getter&&setter
- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon_default_header"];
        [self.contentView addSubview:_imageIcon];
    }
    return _imageIcon;
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

- (UILabel *)labelStatus {
    if (_labelStatus == nil) {
        _labelStatus = [[UILabel alloc] init];
        _labelStatus.numberOfLines = 0;
        _labelStatus.lineBreakMode = NSLineBreakByCharWrapping;
        _labelStatus.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelStatus.font = [UIFont systemFontOfSize:13];
        _labelStatus.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_labelStatus];
    }
    return _labelStatus;
}

@end
