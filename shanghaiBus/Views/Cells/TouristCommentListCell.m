//
//  TouristCommentListCell.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristCommentListCell.h"
#import "Config.h"
#import "WebImageView.h"

@interface TouristCommentListCell ()

@property (nonatomic, strong) UILabel *labelComment;
@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;

@end

@implementation TouristCommentListCell
#pragma mark - getter&&setter
- (UILabel *)labelComment {
    if (_labelComment == nil) {
        _labelComment = [[UILabel alloc] init];
        _labelComment.numberOfLines = 0;
        _labelComment.lineBreakMode = NSLineBreakByCharWrapping;
        _labelComment.textColor = [UIColor whiteColor];
        _labelComment.font = [UIFont systemFontOfSize:13];
        
    }
    return _labelComment;
}

- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon"];
        _imageIcon.clipsToBounds = YES;
    }
    return _imageIcon;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textColor = [UIColor whiteColor];
        _labelName.font = [UIFont systemFontOfSize:13];
    }
    return _labelName;
}

- (UILabel *)labelDate {
    if (_labelDate == nil) {
        _labelDate = [[UILabel alloc] init];
        _labelDate.numberOfLines = 0;
        _labelDate.lineBreakMode = NSLineBreakByCharWrapping;
        _labelDate.textColor = [UIColor whiteColor];
        _labelDate.font = [UIFont systemFontOfSize:13];
    }
    return _labelDate;
}

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = BYColorAlphaMake(77, 77, 77, 1);
    self.labelComment.frame = CGRectMake(10, 5, SCREENWIDTH - 20, 40);
    self.imageIcon.frame = CGRectMake(10, self.labelComment.ctBottom + 10, 30, 30);
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, self.imageIcon.ctTop + 5, 160, 20);
    self.labelDate.frame = CGRectMake(self.imageIcon.ctRight, self.labelName.ctBottom + 10, 160, 20);
    [self.contentView addSubview:self.labelComment];
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelDate];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.labelDate.ctBottom + 9, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:viewLine];
    
}

- (void)configCellWithData:(id) celldata {
    self.labelComment.text = @"这是个好评论，给你5分又咋滴呢，明天还要给你5分，后天给你6分，大后天给你1分，明年再回来给你0.5分，好导游，要赞的飞起！";
    [self.labelComment sizeThatFits:CGSizeMake(SCREENWIDTH - 20, SCREENHEIGHT)];
    [self.labelComment sizeToFit];
    
    self.imageIcon.layer.cornerRadius = 15;
    self.imageIcon.clipsToBounds = YES;
    
    self.labelName.text = @"会费的猪";
    self.labelDate.text = @"2014-3-4";

}

- (CGFloat)fetchCellHightWithData:(id) cellData {
    return self.labelDate.ctBottom + 10;
}

@end
