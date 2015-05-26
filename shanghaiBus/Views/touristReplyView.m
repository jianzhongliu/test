//
//  touristReplyView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristReplyView.h"
#import "CommentObject.h"
#import "MessageObject.h"
#import "Config.h"

@interface TouristReplyView ()

@property (nonatomic, strong) UIImageView *imagePointer;
@property (nonatomic, strong) UIImageView *imageBack;
@property (nonatomic, strong) UILabel *labelToursit;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelContent;

@end

@implementation TouristReplyView

#pragma mark - getter && setter

#pragma mark - lifeCycleMethods
- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.imagePointer.frame = CGRectMake(100, 0, 8, 7);
    self.imageBack.frame = CGRectMake(10, self.imagePointer.ctBottom, SCREENWIDTH - 20, 50);
    self.labelToursit.frame = CGRectMake(20, 15, 200, 20);
    self.labelTime.frame = CGRectMake(SCREENWIDTH - 110, self.labelToursit.ctTop, 80, 25);
    self.labelContent.frame = CGRectMake(20, self.labelToursit.ctBottom + 5, SCREENWIDTH - 40, 70);
}

- (void)configViewWithData:(id) data {
    if ([data isKindOfClass:[CommentObject class]]) {
        CommentObject *comment = (CommentObject *)data;
        self.labelTime.text = [NSString stringWithFormat:@"%ld", (long)comment.commentdate];
        self.labelContent.viewWidth = SCREENWIDTH - 40;
        self.labelContent.text = comment.replycontent;
        [self.labelContent sizeToFit];
        self.labelToursit.text = @"商家回复:";
    
        self.imageBack.viewHeight = self.labelContent.ctBottom + 5;
        
    }
    
    if ([data isKindOfClass:[MessageObject class]]) {
        MessageObject *message = (MessageObject *)data;
        self.labelTime.text = [NSString stringWithFormat:@"%ld", (long)message.commentdate];
        self.labelContent.viewWidth = SCREENWIDTH - 40;
        self.labelContent.text = message.replycontent;
        [self.labelContent sizeToFit];
        
        self.imageBack.viewHeight = self.labelContent.ctBottom + 5;
    }
}

- (CGFloat)fetchViewHeightWithData:(id) data {
    [self configViewWithData:data];
    
    return self.imageBack.ctBottom + 7;
}

- (UIImageView *)imagePointer {
    if (_imagePointer == nil) {
        _imagePointer = [[UIImageView alloc] init];
        _imagePointer.image = [UIImage imageNamed:@"pointer"];
        _imagePointer.clipsToBounds = YES;
        _imagePointer.userInteractionEnabled = YES;
        [self addSubview:_imagePointer];
    }
    return _imagePointer;
}

- (UIImageView *)imageBack {
    if (_imageBack == nil) {
        _imageBack = [[UIImageView alloc] init];
        _imageBack.image = [UIImage imageNamed:@"icon_white_bg"];
//        _imageBack.clipsToBounds = YES;
        _imageBack.userInteractionEnabled = YES;
        [self addSubview:_imageBack];
    }
    return _imageBack;
}

- (UILabel *)labelToursit {
    if (_labelToursit == nil) {
        _labelToursit = [[UILabel alloc] init];
        _labelToursit.numberOfLines = 0;
        _labelToursit.lineBreakMode = NSLineBreakByCharWrapping;
        _labelToursit.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
        _labelToursit.font = [UIFont systemFontOfSize:13];
        _labelToursit.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_labelToursit];
    }
    return _labelToursit;
}

- (UILabel *)labelTime {
    if (_labelTime == nil) {
        _labelTime = [[UILabel alloc] init];
        _labelTime.numberOfLines = 0;
        _labelTime.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTime.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelTime.font = [UIFont systemFontOfSize:13];
        _labelTime.textAlignment = NSTextAlignmentRight;
        [self addSubview:_labelTime];
    }
    return _labelTime;
}

- (UILabel *)labelContent {
    if (_labelContent == nil) {
        _labelContent = [[UILabel alloc] init];
        _labelContent.numberOfLines = 0;
        _labelContent.lineBreakMode = NSLineBreakByCharWrapping;
        _labelContent.textColor = BYColorAlphaMake(0, 0, 0, 0.8);
        _labelContent.font = [UIFont systemFontOfSize:13];
        [self addSubview:_labelContent];
    }
    return _labelContent;
}

@end
