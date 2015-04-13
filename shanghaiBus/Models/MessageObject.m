//
//  MessageObject.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/12.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MessageObject.h"

@implementation MessageObject

- (void)configCommentWithDic:(NSDictionary *)dic {
    
    if (dic && dic.count > 0) {
        self.identity = [[dic objectForKey:@"identity"] integerValue];
        self.userId = [dic objectForKey:@"userid"];
        self.touristId = [dic objectForKey:@"touristid"];
        self.phonenumber = [[dic objectForKey:@"phonenumber"] integerValue];
        self.content = [dic objectForKey:@"content"];
        self.replycontent = [dic objectForKey:@"replycontent"];
        self.commentdate = [[dic objectForKey:@"commentdate"] integerValue];
        self.replydate = [[dic objectForKey:@"replydate"] integerValue];
    }
}

@end
