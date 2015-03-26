//
//  TouristContectView.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/26.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristContectView.h"
#import "Config.h"

@interface TouristContectView ()
@property (nonatomic, strong) UIButton *buttonMessage;
@property (nonatomic, strong) UIButton *buttonPhone;

@end
@implementation TouristContectView
- (UIButton *)buttonMessage {
    if (_buttonMessage == nil) {
        _buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonMessage setTitleColor:BYColor forState:UIControlStateNormal];
        [_buttonMessage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_buttonMessage setTitle:@"留言"forState:UIControlStateNormal];
        [_buttonMessage addTarget:self action:@selector(didClickMessage) forControlEvents:UIControlEventTouchUpInside];
        [_buttonMessage setBackgroundColor:[UIColor greenColor]];
        _buttonMessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:_buttonMessage];
    }
    return _buttonMessage;
}
- (UIButton *)buttonPhone {
    if (_buttonPhone == nil) {
        _buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonPhone setTitleColor:BYColor forState:UIControlStateNormal];
        [_buttonPhone setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_buttonPhone setBackgroundColor:[UIColor redColor]];
        [_buttonPhone setTitle:@"电话联系"forState:UIControlStateNormal];
        [_buttonPhone addTarget:self action:@selector(didClickPhone) forControlEvents:UIControlEventTouchUpInside];
        _buttonPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:_buttonPhone];
    }
    return _buttonPhone;
}

- (id)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.buttonMessage.frame = CGRectMake(0, 0, SCREENWIDTH / 2, 40);
    self.buttonPhone.frame = CGRectMake(SCREENWIDTH / 2, 0, SCREENWIDTH / 2, 40);
}

- (void)didClickMessage {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickMessage)]) {
        [_delegate didClickMessage];
    }
}
- (void)didClickPhone {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickPhone)]) {
        [_delegate didClickPhone];
    }
}
@end
