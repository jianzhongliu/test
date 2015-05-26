//
//  ServiceObject.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/23.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceObject : NSObject
@property (nonatomic, copy)	NSString *identify;
@property (nonatomic, copy)	NSString *touristid;
@property (nonatomic, copy)	NSString *servicearea;
@property (nonatomic, copy)	NSString *language;
@property (nonatomic, copy)	NSString *price;
@property (nonatomic, copy)	NSString *pricedetail;
@property (nonatomic, copy) NSString *preBook;
@property (nonatomic, copy)	NSString *servicedetail;
@property (nonatomic, copy)	NSString *images;
@property (nonatomic, assign)	float star;
@property (nonatomic, copy)	NSString *otherinfoid;
@property (nonatomic, assign) NSInteger ordernumber;
@property (nonatomic, assign) NSInteger registerdate;
@property (nonatomic, assign) NSInteger commentnumber;
@property (nonatomic, assign) NSInteger messagenumber;
@property (nonatomic, assign) double addDate;
@property (nonatomic, copy) NSString *status;

- (void)configTouristWithDic:(NSDictionary *) dic;

@end
