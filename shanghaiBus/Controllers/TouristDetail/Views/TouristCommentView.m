//
//  TouristCommonView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristCommentView.h"
#import "WebImageView.h"
#import "Config.h"
#import "CommentObject.h"
#import "CWStarRateView.h"

@interface TouristCommentView ()

@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UILabel *labelHeaderTitle;
@property (nonatomic, strong) UIButton *buttonHeader;

@property (nonatomic, strong) WebImageView *imageIcon;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelCommon;
@property (nonatomic, strong) UIButton *buttonDetail;
@property (nonatomic, strong) CWStarRateView *starRateView;

@end

@implementation TouristCommentView
#pragma mark - getter && setter
- (UIView *)viewHeader {
    if (_viewHeader == nil) {
        _viewHeader = [[UIView alloc] init];
//        _viewHeader.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
        [self addSubview:_viewHeader];
    }
    return _viewHeader;
}

- (UILabel *)labelHeaderTitle {
    if (_labelHeaderTitle == nil) {
        _labelHeaderTitle = [[UILabel alloc] init];
        _labelHeaderTitle.backgroundColor = [UIColor whiteColor];
        _labelHeaderTitle.textColor = BYBlackColor;
        _labelHeaderTitle.font = [UIFont systemFontOfSize:16];
//        _labelHeaderTitle.text = @"评论";
        [self.viewHeader addSubview:_labelHeaderTitle];
    }
    return _labelHeaderTitle;
}

- (UIButton *)buttonHeader {
    if (_buttonHeader == nil) {
        _buttonHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonHeader setImage:[UIImage imageNamed:@"icon_detail_up"] forState:UIControlStateNormal];
        [_buttonHeader setImage:[UIImage imageNamed:@"icon_detail_down"] forState:UIControlStateSelected];
        [_buttonHeader addTarget:self action:@selector(didHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
        _buttonHeader.selected = NO;
//        [self.viewHeader addSubview:_buttonHeader];
    }
    return _buttonHeader;
}

- (WebImageView *)imageIcon {
    if (_imageIcon == nil) {
        _imageIcon = [[WebImageView alloc] init];
        _imageIcon.image = [UIImage imageNamed:@"icon_default_header"];
        _imageIcon.clipsToBounds = YES;
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.backgroundColor = [UIColor whiteColor];
        _labelName.textColor = BYBlackColor;
        _labelName.font = [UIFont systemFontOfSize:14];
        _labelName.text = @"";
        [self addSubview:_labelName];
    }
    return _labelName;
}

- (UILabel *)labelDate {
    if (_labelDate == nil) {
        _labelDate = [[UILabel alloc] init];
        _labelDate.backgroundColor = [UIColor whiteColor];
        _labelDate.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
        _labelDate.font = [UIFont systemFontOfSize:14];
        _labelDate.textAlignment = NSTextAlignmentRight;
        _labelDate.text = @"";
        [self addSubview:_labelDate];
    }
    return _labelDate;
}

- (UILabel *)labelCommon {
    if (_labelCommon == nil) {
        _labelCommon = [[UILabel alloc] init];
        _labelCommon.backgroundColor = [UIColor whiteColor];
        _labelCommon.textColor = BYColorFromHex(0x797979);
        _labelCommon.font = [UIFont systemFontOfSize:14];
        _labelCommon.text = @"暂无评论";
        [self addSubview:_labelCommon];
    }
    return _labelCommon;
}

- (UIButton *)buttonDetail {
    if (_buttonDetail == nil) {
        _buttonDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDetail setTitleColor:BYColor forState:UIControlStateNormal];
        [_buttonDetail setTitle:@""forState:UIControlStateNormal];
        [_buttonDetail addTarget:self action:@selector(didClickCommentDetail) forControlEvents:UIControlEventTouchUpInside];
        _buttonDetail.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _buttonDetail.font = [UIFont systemFontOfSize:14];
//        _buttonDetail.backgroundColor = BYColor;
//        _buttonDetail.layer.cornerRadius = 6;
        [self addSubview:_buttonDetail];
    }
    return _buttonDetail;
}

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.viewtype = VIEWTYPECOMMENT;
    
    self.viewHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
    self.labelHeaderTitle.frame = CGRectMake(10, 10, 100, 30);
    self.buttonHeader.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    self.buttonHeader.imageEdgeInsets = UIEdgeInsetsMake(0, SCREENWIDTH - 40, 0, 0);
    
    self.imageIcon.frame = CGRectMake(10, self.viewHeader.ctBottom + 5, 30, 30);
    self.imageIcon.layer.contentsScale = self.imageIcon.viewWidth / 2;
    self.imageIcon.layer.cornerRadius = self.imageIcon.viewWidth / 2;
    self.imageIcon.clipsToBounds = YES;
    self.labelName.frame = CGRectMake(self.imageIcon.ctRight + 10, self.imageIcon.ctTop - 5, 180, 20);
    self.labelDate.frame = CGRectMake( SCREENWIDTH - 100, self.labelName.ctTop, 85, 20);
    
    self.labelCommon.frame = CGRectMake(10, self.imageIcon.ctBottom + 10, SCREENHEIGHT - 20, 20);
    self.buttonDetail.frame = CGRectMake(0, self.labelCommon.ctBottom +10, SCREENWIDTH, 40);
    [self.buttonDetail setTitle:@"0条留言" forState:UIControlStateNormal];

    
}

- (void)configViewWithData:(CommentObject *) comment WithNumber:(NSInteger) number{
    if (comment == nil) {
        [self.labelName removeFromSuperview];
        [self.labelDate removeFromSuperview];
        [self.labelCommon removeFromSuperview];
        [self.imageIcon removeFromSuperview];
        [self.starRateView removeFromSuperview];
        self.buttonDetail.ctTop = self.viewHeader.ctBottom;
        [self.buttonHeader removeFromSuperview];
    }
    UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonDetail.ctTop, SCREENWIDTH, 0.5)];
    viewLineTop.backgroundColor = BYLineSepratorColor;
    [self addSubview:viewLineTop];
    
#warning TODO 关于划线 写个retina的方法，当时非retina时宽度是1，retina时是0.5的宽度
    UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonDetail.ctBottom, SCREENWIDTH, 0.5)];
    viewLineBottom.backgroundColor = BYLineSepratorColor;
    [self addSubview:viewLineBottom];
    
    NSString *commentNumber = @"";
    switch (self.viewtype) {
        case VIEWTYPECOMMENT:
        {
            self.labelHeaderTitle.text = @"评论";
            self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(self.imageIcon.ctRight + 10, self.labelName.ctBottom , 80, 15) numberOfStars:5];
//            self.starRateView.scorePercent = 1;
            self.starRateView.enable = NO;
            self.starRateView.allowIncompleteStar = NO;
            self.starRateView.hasAnimation = YES;
            self.starRateView.scorePercent = comment.score / 5;
            if (comment != nil) {
                [self addSubview:self.starRateView];
            }
            commentNumber = [NSString stringWithFormat:@"%ld条评论", (long)number];
        }
            break;
        case VIEWTYPEMESSAGE:
        {
            self.labelHeaderTitle.text = @"留言";
            commentNumber = [NSString stringWithFormat:@"%ld条留言", (long)number];
        }
            break;
        default:
            break;
    }
    self.labelCommon.text = comment.content;
    [self.buttonDetail setTitle:commentNumber forState:UIControlStateNormal];

//    self.imageIcon.imageUrl = comment.ico

#warning TODO 设置图像的url
    self.labelName.text = comment.userId;

    self.labelDate.text = [NSString stringWithFormat:@"%ld", (long)comment.commentdate];
    
}
- (void)configViewWithMessage:(MessageObject *) message WithNumber:(NSInteger) number{
    if (message == nil) {
        [self.labelName removeFromSuperview];
        [self.labelDate removeFromSuperview];
        [self.labelCommon removeFromSuperview];
        [self.imageIcon removeFromSuperview];
        [self.starRateView removeFromSuperview];
        self.buttonDetail.ctTop = self.viewHeader.ctBottom;
        [self.buttonHeader removeFromSuperview];
    }
    UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonDetail.ctTop, SCREENWIDTH, 0.5)];
    viewLineTop.backgroundColor = BYLineSepratorColor;
    [self addSubview:viewLineTop];
    
#warning TODO 关于划线 写个retina的方法，当时非retina时宽度是1，retina时是0.5的宽度
    UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonDetail.ctBottom, SCREENWIDTH, 0.5)];
    viewLineBottom.backgroundColor = BYLineSepratorColor;
    [self addSubview:viewLineBottom];
    NSString *commentNumber = @"";
    switch (self.viewtype) {
        case VIEWTYPECOMMENT:
        {
            
        }
            break;
        case VIEWTYPEMESSAGE:
        {
            self.labelHeaderTitle.text = @"留言";
            
            self.labelCommon.text = @"暂无留言";
            commentNumber = [NSString stringWithFormat:@"%ld条留言", (long)number];
        }
            break;
        default:
            break;
    }
    if (message == nil) {
        return;
    }
    self.labelCommon.text = message.content;
    [self.buttonDetail setTitle:commentNumber forState:UIControlStateNormal];

#warning TODO 设置图像的url
    self.labelName.text = message.userId;
    self.labelDate.text = [NSString stringWithFormat:@"%ld", (long)message.commentdate];
    
}

- (void)didHeaderClick:(UIButton *) sender {
    if (YES == sender.isSelected) {
        self.buttonHeader.selected = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceCommentInfoDisplayChanged:status:)]) {
            [_delegate didTouristServiceCommentInfoDisplayChanged:self status:YES];
        }
    } else {
        self.buttonHeader.selected = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceCommentInfoDisplayChanged:status:)]) {
            [_delegate didTouristServiceCommentInfoDisplayChanged:self status:YES];
        }
    }
}

- (void)didClickCommentDetail {
    if (_delegate && [_delegate respondsToSelector:@selector(didTouristServiceDetailClick:)]) {
        [_delegate didTouristServiceDetailClick:self.cellData];
    }
}

- (CGFloat)fetchViewHeight {
    if (YES == self.buttonHeader.selected) {
        return self.viewHeader.ctBottom;
    } else {
        return self.buttonDetail.ctBottom + 1;
    }
}

@end
