//
//  Utils.m
//  ConpanyComment
//
//  Created by liujianzhong on 15/3/29.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils
+ (NSString *)MD5:(NSString *) str {
    str= [NSString stringWithFormat:@"%@!$&F^6a_?>", str];
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getCurrentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHssmm";
    NSString *dateString =  [formatter stringFromDate:date];
    return dateString;
}
@end
