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
@property (nonatomic, assign)	int gender;
@property (nonatomic, assign)	int birthday;
@property (nonatomic, copy)	NSString *nuckname;
@property (nonatomic, copy)	NSString *name;
@property (nonatomic, copy)	NSString *icon;
@property (nonatomic, copy)	NSString *email;
@property (nonatomic, copy)	NSString *phone;
@property (nonatomic, copy)	NSString *signature;
@property (nonatomic, copy)	NSString *servicearea;
@property (nonatomic, copy)	NSString *language;
@property (nonatomic, copy)	NSString *price;
@property (nonatomic, copy)	NSString *pricedetail;
@property (nonatomic, copy)	NSString *servicedetail;
@property (nonatomic, copy)	NSString *tag;
@property (nonatomic, copy)	NSString *images;
@property (nonatomic, assign)	float star;
@property (nonatomic, assign)	int usertype;
@property (nonatomic, assign)	float userlat;
@property (nonatomic, assign)	float userlng;
@property (nonatomic, copy)	NSString *otherinfoid;
@property (nonatomic, assign)	int ordernumber;
@property (nonatomic, assign)	int registerdate;

@end
