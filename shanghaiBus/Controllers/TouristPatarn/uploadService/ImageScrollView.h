//
//  ImageScrollView.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/4.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickAddImageBlock) (NSInteger index);

@interface ImageScrollView : UIView

@property (nonatomic, strong) clickAddImageBlock imageBlock;

- (void)configViewWithData:(NSArray *) data clickBlock:(clickAddImageBlock ) clickBlock;


@end
