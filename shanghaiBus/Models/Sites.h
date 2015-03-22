//
//  Sites.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 首页的景点object
 */
@interface Sites : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *siteName;
@property (nonatomic, copy) NSString *touristNumber;

@end
