//
//  TouristObject.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouristObject : NSObject

@property (nonatomic, copy)	NSString *identify;
@property (nonatomic, copy)	NSString *username;
@property (nonatomic, copy)	NSString *password;
@property (nonatomic, copy)	NSString *token;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, copy)	NSString *nuckname;
@property (nonatomic, copy)	NSString *name;
@property (nonatomic, copy)	NSString *icon;
@property (nonatomic, copy)	NSString *email;
@property (nonatomic, copy)	NSString *phone;
@property (nonatomic, copy) NSString *preBook;
@property (nonatomic, copy)	NSString *signature;
@property (nonatomic, copy)	NSString *servicearea;
@property (nonatomic, copy)	NSString *language;
@property (nonatomic, copy)	NSString *price;
@property (nonatomic, copy)	NSString *pricedetail;
@property (nonatomic, copy)	NSString *servicedetail;
@property (nonatomic, copy)	NSString *tag;
@property (nonatomic, copy)	NSString *images;
@property (nonatomic, assign)	float star;
@property (nonatomic, assign)	NSInteger usertype;//用户类型：1，普通用户，2认证中的导游，3认证通过的导游 默认是1
@property (nonatomic, assign)	float userlat;
@property (nonatomic, assign)	float userlng;
@property (nonatomic, copy)	NSString *otherinfoid;
@property (nonatomic, assign) NSInteger ordernumber;
@property (nonatomic, assign) NSInteger registerdate;
@property (nonatomic, assign) NSInteger commentnumber;
@property (nonatomic, assign) NSInteger messagenumber;
@property (nonatomic, strong) NSString *status;

- (void)configTouristWithDic:(NSDictionary *) dic;

@end
