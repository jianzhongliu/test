//
//  MessageObject.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/12.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageObject : NSObject

@property (nonatomic, assign) NSInteger identity;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *touristId;
@property (nonatomic, assign) NSInteger phonenumber;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *replycontent;
@property (nonatomic, assign) NSInteger commentdate;
@property (nonatomic, assign) NSInteger replydate;

- (void)configCommentWithDic:(NSDictionary *)dic;

@end
