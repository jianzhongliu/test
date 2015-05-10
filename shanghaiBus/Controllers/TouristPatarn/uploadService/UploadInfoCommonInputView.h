//
//  UploadInfoCommonInputView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/4.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, INPUTVIEWTYPE) {
    INPUTVIEWTYPENAME = 1, //姓名
    INPUTVIEWTYPEIDENTIFY = 2,//身份证
    INPUTVIEWTYPEPHONE = 3,//电话号码
    INPUTVIEWTYPECODE = 4//验证码
};

@interface UploadInfoCommonInputView : UIView

@property (nonatomic, strong) UITextField *textInput;
@property (nonatomic) INPUTVIEWTYPE viewType;


- (void)configViewWithData:(id) data;

@end
