//
//  UploadInfoCommonInputView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/4.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VIEWTYPE) {
    VIEWTYPENAME = 1, //title
    VIEWTYPEINPUT = 2,//
    VIEWTYPEPRICE = 3,//price
};

@interface UploadInfoCommonInputView : UIView

@property (nonatomic, strong) UITextField *textInput;
@property (nonatomic) VIEWTYPE viewType;


- (void)configViewWithTitle:(NSString *) title;

@end
