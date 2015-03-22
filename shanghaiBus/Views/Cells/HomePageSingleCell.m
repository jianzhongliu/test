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

@end

@implementation HomePageSingleCell

- (WebImageView *)imageMain {
    if (_imageMain == nil) {
        _imageMain = [[WebImageView alloc] init];
        _imageMain.userInteractionEnabled = YES;
        _imageMain.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_imageMain];
    }
    return _imageMain;
}

- (UIButton *)buttonNumber {
    if (_buttonNumber == nil) {
        _buttonNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNumber addTarget:self action:@selector(didClickTouristNumber) forControlEvents:UIControlEventTouchUpInside];
        _buttonNumber.backgroundColor = [UIColor redColor];
        [_buttonNumber setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_buttonNumber];
    }
    return _buttonNumber;
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
    self.buttonNumber.frame = CGRectMake(SCREENWIDTH - 100, self.imageMain.ctBottom - 50, 80, 40);
}

- (void)resetDataWith:(Sites *) site {
    self.imageMain.imageUrl = site.imageUrl;
    [self.buttonNumber setTitle:[NSString stringWithFormat:@"%@位导游", site.touristNumber] forState:UIControlStateNormal];
    
}

- (void)didClickTouristNumber {

}
+ (CGFloat)fetchCellHeight {
    return (SCREENWIDTH - 20) *9 / 16 ;
}
@end
