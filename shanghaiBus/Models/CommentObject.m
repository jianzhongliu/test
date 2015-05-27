//
//  CommentObject.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/12.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "CommentObject.h"

@implementation CommentObject


- (void)configCommentWithDic:(NSDictionary *)dic {

    if (dic && dic.count > 0) {
        self.identity = [dic objectForKey:@"identify"];
        self.userId = [dic objectForKey:@"userid"];
        self.touristId = [dic objectForKey:@"touristid"];
        self.score = [[dic objectForKey:@"score"] integerValue];
        self.content = [dic objectForKey:@"content"];
        self.replycontent = [dic objectForKey:@"replycontent"];
        self.commentdate = [[dic objectForKey:@"commentdate"] integerValue];
        self.replydate = [[dic objectForKey:@"replydate"] integerValue];
    }
}

@end
