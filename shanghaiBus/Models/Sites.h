//
//  Sites.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/**
 首页的景点object
 */
@interface Sites : NSObject

@property (nonatomic, copy) NSString *cityid;
@property (nonatomic, copy) NSString *cityname;
@property (nonatomic, assign) NSInteger date;
@property (nonatomic, assign) NSInteger identify;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, assign) NSInteger ordernumber;
@property (nonatomic, assign) NSInteger scenerynumber;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, copy) NSString *senaryname;
@property (nonatomic, assign) NSInteger touristnumber;
@property (nonatomic, copy) NSString *mainImage;

- (void)configSiteWithDic:(NSDictionary *)dic;

@end
