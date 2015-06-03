//
//  UserCachBean.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UserCachBean.h"
#import "AFNetworking.h"
#import "Utils.h"
#import "Config.h"

@implementation UserCachBean

+(void)load {
    [UserCachBean fetchLoginData];
    [UserCachBean fetchTouristInfo];
}

+ (instancetype)share {
    static UserCachBean *userCachBean = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userCachBean == nil) {
            userCachBean = [[UserCachBean alloc] init];
        }
    });
    return userCachBean;
}

+ (void)fetchLoginData {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"user.plist"];
    
    NSDictionary *dicUser = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    TouristObject *tourist = [[TouristObject alloc] init];
    [tourist configTouristWithDic:dicUser];
    [UserCachBean share].touristInfo = tourist;
    
}

+ (void)fetchTouristInfo {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = [[[UserCachBean share] touristInfo] identify];
    if (userid == nil) {
        return;
    }
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@tourist/getTouristCityId",HOST];
    NSDictionary *dic = @{@"date":currentTime,@"identify":userid,@"sign":sign};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSDictionary *dicTourits = [dic objectForKey:@"tourist"];
            if (dicTourits == nil) {
                return ;
            }
            TouristObject *tourist = [[TouristObject alloc] init];
            [tourist configTouristWithDic:dicTourits];
            [UserCachBean share].touristInfo = tourist;
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

- (BOOL)isLogin  {
    if ([[[UserCachBean share] touristInfo] identify] > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)clearLoginData {
    self.touristInfo = nil;
    NSDictionary *userDic = @{};
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"user.plist"];
    [userDic writeToFile:plistPath atomically:YES];
}

@end
