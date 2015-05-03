//
//  commonInputView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/3.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VIEWTYPE) {
    VIEWTYPENAME = 1, //姓名
    VIEWTYPEIDENTIFY = 2,//身份证
    VIEWTYPEPHONE = 3,//电话号码
    VIEWTYPECODE = 4//验证码
};

@interface CommonInputView : UIView

@property (nonatomic, strong) UITextField *textInput;
@property (nonatomic) VIEWTYPE viewType;


- (void)configViewWithData:(id) data;

@end
