//
//  HomePageSepratorCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "HomePageSepratorCell.h"
#import "WebImageView.h"
#import "Config.h"

@interface HomePageSepratorCell ()

@property (nonatomic, strong) WebImageView *imageLeft;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelNumber;

@property (nonatomic, strong) WebImageView *imageRight;
@property (nonatomic, strong) UILabel *labelNameR;
@property (nonatomic, strong) UILabel *labelNumberR;

@end

@implementation HomePageSepratorCell

- (WebImageView *)imageLeft {
    if (_imageLeft == nil) {
        _imageLeft = [[WebImageView alloc] init];
        _imageLeft.userInteractionEnabled = YES;
        _imageLeft.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_imageLeft];
    }
    return _imageLeft;
}

- (WebImageView *)imageRight {
    if (_imageRight == nil) {
        _imageRight = [[WebImageView alloc] init];
        _imageRight.userInteractionEnabled = YES;
//        _imageRight.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imageRight];
    }
    return _imageRight;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.text = @"";
        _labelName.font = [UIFont boldSystemFontOfSize:14];
        _labelName.backgroundColor = [UIColor whiteColor];
        _labelName.textColor = BYColor;
        _labelName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelName];
    }
    return _labelName;
}

- (UILabel *)labelNumber {
    if (_labelNumber == nil) {
        _labelNumber = [[UILabel alloc] init];
        _labelNumber.text = @"";
        _labelNumber.font = [UIFont systemFontOfSize:12];
        _labelNumber.backgroundColor = [UIColor whiteColor];
        _labelNumber.textColor = BYColorFromHex(0x999999);
        _labelNumber.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_labelNumber];
    }
    return _labelNumber;
}

- (UILabel *)labelNameR {
    if (_labelNameR == nil) {
        _labelNameR = [[UILabel alloc] init];
        _labelNameR.text = @"";
        _labelNameR.font = [UIFont boldSystemFontOfSize:14];
        _labelNameR.backgroundColor = [UIColor whiteColor];
        _labelNameR.textColor = BYColor;
        _labelNameR.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelNameR];
    }
    return _labelNameR;
}

- (UILabel *)labelNumberR {
    if (_labelNumberR == nil) {
        _labelNumberR = [[UILabel alloc] init];
        _labelNumberR.text = @"";
        _labelNumberR.font = [UIFont systemFontOfSize:12];
        _labelNumberR.backgroundColor = [UIColor whiteColor];
        _labelNumberR.textColor = BYColorFromHex(0x999999);
        _labelNumberR.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_labelNumberR];
    }
    return _labelNumberR;
}

#pragma mark - lifeycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imageLeft.frame = CGRectMake(10, 5, (SCREENWIDTH - 30) / 2 , (SCREENWIDTH - 30) / 2 *9 / 16);
    
    self.imageRight.frame = CGRectMake(self.imageLeft.ctRight + 10, 5, (SCREENWIDTH - 30) / 2 , (SCREENWIDTH - 30) / 2 *9 / 16);
    
    self.labelName.frame = CGRectMake(10, self.imageLeft.ctBottom + 3, 70, 20);
    self.labelNumber.frame = CGRectMake(self.labelName.ctRight, self.imageLeft.ctBottom + 3, 70, 20);
    
    self.labelNameR.frame = CGRectMake(self.imageLeft.ctRight + 10, self.imageLeft.ctBottom + 3, 70, 20);
    self.labelNumberR.frame = CGRectMake(self.labelNameR.ctRight , self.imageLeft.ctBottom + 3, 70, 20);
    
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickLeft)];
    [self.imageLeft addGestureRecognizer:tapLeft];
    
    UITapGestureRecognizer *tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickRight)];
    [self.imageRight addGestureRecognizer:tapRight];
    
}

- (void)didClickLeft {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickImageAtCell:withIndex:)]) {
        [_delegate didClickImageAtCell:self withIndex:0];
    }
}

- (void)didClickRight {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickImageAtCell:withIndex:)]) {
        [_delegate didClickImageAtCell:self withIndex:1];
    }
}

- (void)resetDataWith:(NSArray *) arrayData {
    self.cellData = arrayData;
    NSInteger numberOfobject = arrayData.count;
    switch (numberOfobject) {
        case 1:{
            Sites *site = [arrayData objectAtIndex:0];
            self.imageLeft.imageUrl = site.mainImage;
            self.labelName.text = site.cityname;
            self.labelNumber.text = [NSString stringWithFormat:@"%ld位导游", (long)site.touristnumber];

        }
            break;
        case 2:{
            Sites *site = [arrayData objectAtIndex:0];
            self.imageLeft.imageUrl = site.mainImage;
            self.labelName.text = site.cityname;
            self.labelNumber.text = [NSString stringWithFormat:@"%ld位导游", (long)site.touristnumber];
            
            Sites *siteR = [arrayData objectAtIndex:1];
            self.imageRight.imageUrl = siteR.mainImage;
            self.labelNameR.text = siteR.cityname;
            self.labelNumberR.text = [NSString stringWithFormat:@"%ld位导游", (long)siteR.touristnumber];
            
        }
            break;
        default:
        {
        }
            break;
    }
}

/**
 计算方法，屏幕宽度-30除以2得到图片的宽度
 图片的宽度高比为16：9
 得到图片的高度为：(SCREENWIDTH - 30) / 2 *9 / 16
 */
+ (CGFloat)fetchCellHeight {
    return (SCREENWIDTH - 30) / 2 *9 / 16 + 30;
}

@end
