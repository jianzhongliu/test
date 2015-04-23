//
//  HomePageSingleCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "HomePageSingleCell.h"
#import "WebImageView.h"
#import "Config.h"

@interface HomePageSingleCell ()

@property (nonatomic, strong) WebImageView *imageMain;
@property (nonatomic, strong) UIButton *buttonNumber;
@property (nonatomic, strong) UILabel *labelName;

@end

@implementation HomePageSingleCell

- (WebImageView *)imageMain {
    if (_imageMain == nil) {
        _imageMain = [[WebImageView alloc] init];
        _imageMain.userInteractionEnabled = YES;
        _imageMain.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imageMain];
    }
    return _imageMain;
}

- (UIButton *)buttonNumber {
    if (_buttonNumber == nil) {
        _buttonNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNumber addTarget:self action:@selector(didClickTouristNumber) forControlEvents:UIControlEventTouchUpInside];
        _buttonNumber.backgroundColor = BYColorFromHex(0xff5555);
        [_buttonNumber setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_buttonNumber];
    }
    return _buttonNumber;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
//        _labelName.backgroundColor = [UIColor redColor];
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textColor = [UIColor whiteColor];
        _labelName.font = [UIFont boldSystemFontOfSize:18];
        _labelName.shadowColor = [UIColor blackColor];
        _labelName.shadowOffset = CGSizeMake(0, 1);
        [self.contentView addSubview:_labelName];
    }
    return _labelName;
}

#pragma mark - lifeycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageMain.frame = CGRectMake(10, 10, SCREENWIDTH - 20, (SCREENWIDTH -20) * 9/16);
    
    self.buttonNumber.frame = CGRectMake(SCREENWIDTH - 110, self.imageMain.ctBottom - 50, 90, 30);

    self.buttonNumber.layer.cornerRadius = 2;
    self.buttonNumber.clipsToBounds = YES;
    self.labelName.frame = CGRectMake(20, self.imageMain.ctBottom - 50, 150, 30);
    [self.contentView bringSubviewToFront:self.labelName];
}

- (void)resetDataWith:(Sites *) site {
//    self.labelName.frame = CGRectMake(10, self.imageMain.ctBottom - 50, 150, 30);
    self.imageMain.imageUrl = site.mainImage;
    [self.buttonNumber setTitle:[NSString stringWithFormat:@"%ld条服务", (long)site.touristnumber] forState:UIControlStateNormal];
    self.labelName.text = site.cityname;
}

- (void)didClickTouristNumber {

}
+ (CGFloat)fetchCellHeight {
    return (SCREENWIDTH - 20) *9 / 16 ;
}
@end
