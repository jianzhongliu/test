//
//  Sites.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "Sites.h"

@implementation Sites

- (NSString *)mainImage {
    NSArray *arrayImage = [self.imageurl componentsSeparatedByString:@"|"];
    if (arrayImage.count > 0) {
        _mainImage = [arrayImage objectAtIndex:0];
    }
    return _mainImage;
}

- (void)configSiteWithDic:(NSDictionary *)dic {
    if (dic && dic.count > 0) {
        self.cityid = [dic objectForKey:@"cityid"];
        self.cityname = [dic objectForKey:@"cityname"];
        self.date = [[dic objectForKey:@"date"] integerValue];
        self.identify = [[dic objectForKey:@"identify"] integerValue];
        self.imageurl = [dic objectForKey:@"imageurl"];
        self.scenerynumber = [[dic objectForKey:@"scenerynumber"] integerValue];
        self.score = [[dic objectForKey:@"score"] floatValue];
        self.senaryname = [dic objectForKeyedSubscript:@"senaryname"];
        self.touristnumber = [[dic objectForKey:@"touristnumber"] integerValue];
    }
}

@end
