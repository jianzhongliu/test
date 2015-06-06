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
#import "TouristReplyView.h"

@interface TouristCommentListCell ()

@property (nonatomic, strong) UILabel *labelComment;
@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) CWStarRateView *starRateView;
@property (nonatomic, strong) UIView *viewLine;

@property (nonatomic, strong) TouristReplyView *viewReply;
@property (nonatomic, assign) BOOL isHaseReply;

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

- (TouristReplyView *)viewReply {
    if (_viewReply == nil) {
        _viewReply = [[TouristReplyView alloc] init];
    }
    return _viewReply;
}

#pragma mark - lifecycleMethod
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.isHaseReply = NO;
    self.contentView.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = BYColorFromHex(0x4c4c4c);
    
    [self.contentView addSubview:self.labelComment];
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelDate];
    [self.contentView addSubview:self.viewReply];
    
    self.labelComment.frame = CGRectMake(10, 30, SCREENWIDTH - 20, 40);
    self.imageIcon.frame = CGRectMake(10, self.labelComment.ctBottom + 10, 30, 30);
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, self.imageIcon.ctTop + 5, 160, 20);
    self.labelDate.frame = CGRectMake(self.imageIcon.ctRight + 10, self.labelName.ctBottom + 10, 160, 20);
    self.viewReply.frame = CGRectMake(0, self.labelDate.ctBottom + 5, SCREENWIDTH, 60);
    
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
    self.starRateView.scorePercent = comment.score / 5.0;
    self.starRateView.ctTop = self.labelName.ctBottom + 3;
    
    if (comment.replycontent.length > 0) {
        self.isHaseReply = YES;
        self.viewReply.ctTop = self.labelDate.ctBottom+ 5;
        [self.viewReply configViewWithData:comment];
        self.viewReply.viewHeight = [self.viewReply fetchViewHeightWithData:comment];
        [self.contentView addSubview:self.viewReply];
    } else {
        self.isHaseReply = NO;
        [self.viewReply removeFromSuperview];
    }
    
    [self drawLine];

}

- (void)configCellWithMessage:(MessageObject *) celldata {
    MessageObject *message = (MessageObject *)celldata;
    self.labelComment.text = message.content;
    self.labelComment.viewWidth = SCREENWIDTH - 20;
    [self.labelComment sizeThatFits:CGSizeMake(SCREENWIDTH - 20, SCREENHEIGHT)];
    [self.labelComment sizeToFit];
    
    self.imageIcon.layer.cornerRadius = 15;
    self.imageIcon.clipsToBounds = YES;
    
    self.labelName.text = message.userId;
    self.labelDate.text = [NSString stringWithFormat:@"%ld", (long)message.commentdate];
    if (message.replycontent.length > 0) {
        self.isHaseReply = YES;
        self.viewReply.ctTop = self.labelDate.ctBottom+ 5;
        [self.viewReply configViewWithData:message];
        self.viewReply.viewHeight = [self.viewReply fetchViewHeightWithData:message];
        [self.contentView addSubview:self.viewReply];
    } else {
        self.isHaseReply = NO;
        [self.viewReply removeFromSuperview];
    }
    [self drawLine];
}

- (void)drawLine {
    if (self.viewLine == nil) {
        self.viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, self.labelDate.ctBottom + 14, SCREENWIDTH - 20, 1)];
        [self.contentView addSubview:self.viewLine];
    }


    if (self.isHaseReply == YES) {
        self.viewLine.ctTop = self.viewReply.ctBottom + 14;
    } else {
        self.viewLine.ctTop = self.labelDate.ctBottom + 14;
    }
    self.viewLine.backgroundColor = [UIColor whiteColor];

}

- (CGFloat)fetchCellHightWithData:(id) cellData {
    
    CGFloat height = 0;
    if ([cellData isKindOfClass:[CommentObject class]]) {
        CommentObject *common = (CommentObject *)cellData;
        NSLog(@"2=====%ld", (long)common.identity);
        [self configCellWithComment:(CommentObject *)cellData];
    }
    if ([cellData isKindOfClass:[MessageObject class]]) {

        [self configCellWithMessage:(MessageObject *)cellData];
    }
    
    if (self.isHaseReply == YES) {
        height = self.viewReply.ctBottom + 15;
    } else {
        height = self.labelDate.ctBottom + 15;
    }
    
    return height;
}

@end
