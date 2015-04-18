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
#import "CWStarRateView.h"

@interface TouristCommentListCell ()

@property (nonatomic, strong) UILabel *labelComment;
@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) CWStarRateView *starRateView;
@property (nonatomic, strong) UIView *viewLine;

@end

@implementation TouristCommentListCell
#pragma mark - getter&&setter
- (UILabel *)labelComment {
    if (_labelComment == nil) {
        _labelComment = [[UILabel alloc] init];
        _labelComment.numberOfLines = 0;
        _labelComment.lineBreakMode = NSLineBreakByCharWrapping;
        _labelComment.textColor = [UIColor whiteColor];
        _labelComment.font = [UIFont systemFontOfSize:14];
        
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
        _labelName.textColor = BYColorFromHex(0x999999);
        _labelName.font = [UIFont systemFontOfSize:14];
    }
    return _labelName;
}

- (UILabel *)labelDate {
    if (_labelDate == nil) {
        _labelDate = [[UILabel alloc] init];
        _labelDate.numberOfLines = 0;
        _labelDate.lineBreakMode = NSLineBreakByCharWrapping;
        _labelDate.textColor = BYColorFromHex(0x999999);
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
    self.contentView.backgroundColor = BYColorFromHex(0x4c4c4c);
    self.labelComment.frame = CGRectMake(10, 30, SCREENWIDTH - 20, 40);
    self.imageIcon.frame = CGRectMake(10, self.labelComment.ctBottom + 10, 30, 30);
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, self.imageIcon.ctTop + 5, 160, 20);
    self.labelDate.frame = CGRectMake(self.imageIcon.ctRight + 10, self.labelName.ctBottom + 10, 160, 20);
    [self.contentView addSubview:self.labelComment];
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelDate];

}

- (void)configCellWithComment:(CommentObject *) comment {
    self.labelComment.text = comment.content;
    self.labelComment.viewWidth = SCREENWIDTH - 20;
    [self.labelComment sizeThatFits:CGSizeMake(SCREENWIDTH - 20, SCREENHEIGHT)];
    [self.labelComment sizeToFit];
    
    self.imageIcon.ctTop = self.labelComment.ctBottom + 15;
    
    self.imageIcon.layer.cornerRadius = 15;
    self.imageIcon.clipsToBounds = YES;
    
    self.labelName.ctTop = self.imageIcon.ctTop;
    self.labelDate.ctTop = self.labelName.ctBottom ;
    
    self.labelName.text = comment.userId;
    self.labelDate.text = [NSString stringWithFormat:@"%ld", (long)comment.commentdate];
    
    
    if (self.starRateView == nil) {
        self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 70, self.labelName.ctBottom , 60, 13) numberOfStars:5];
//        self.starRateView.scorePercent = 1;
        self.starRateView.allowIncompleteStar = NO;
        self.starRateView.hasAnimation = NO;
        self.starRateView.enable = NO;
        [self addSubview:self.starRateView];
    }
    self.starRateView.scorePercent = comment.score / 5;
    self.starRateView.ctTop = self.labelName.ctBottom + 3;
    [self drawLine];
}

- (void)configCellWithMessage:(MessageObject *) celldata {
    if ([celldata isKindOfClass:[CommentObject class]]) {
        CommentObject *comment = (CommentObject *)celldata;
        self.labelComment.text = comment.content;
        self.labelComment.viewWidth = SCREENWIDTH - 20;
        [self.labelComment sizeThatFits:CGSizeMake(SCREENWIDTH - 20, SCREENHEIGHT)];
        [self.labelComment sizeToFit];
        
        self.imageIcon.layer.cornerRadius = 15;
        self.imageIcon.clipsToBounds = YES;
        
        self.labelName.text = @"会费的猪";
        self.labelDate.text = @"2014-3-4";
    }
    [self drawLine];
}

- (void)drawLine {
    if (self.viewLine == nil) {
        self.viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.labelDate.ctBottom + 14, SCREENWIDTH - 20, 1)];
    }
    self.viewLine.ctTop = self.labelDate.ctBottom + 14;
    self.viewLine.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.viewLine];
}

- (CGFloat)fetchCellHightWithData:(id) cellData {
    if ([cellData isKindOfClass:[CommentObject class]]) {
        [self configCellWithComment:(CommentObject *)cellData];
    }
    if ([cellData isKindOfClass:[MessageObject class]]) {
        [self configCellWithMessage:(MessageObject *)cellData];
    }
    return self.labelDate.ctBottom + 15;
}

@end
