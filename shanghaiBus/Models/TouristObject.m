//
//  TouristObject.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristObject.h"

@implementation TouristObject

- (void)configTouristWithDic:(NSDictionary *) dic {

    if (dic && dic.count > 0) {
        self.identify = [dic objectForKey:@"identify"];
        self.username = [dic objectForKey:@"username"];
        self.password = [dic objectForKey:@"password"];
        self.token = [dic objectForKey:@"token"];
        self.gender = [[dic objectForKey:@"gender"] integerValue];
        self.birthday = [[dic objectForKey:@"birthday"] integerValue];
        self.nuckname = [dic objectForKey:@"nuckname"];
        self.name = [dic objectForKey:@"name"];
        self.icon = [dic objectForKey:@"icon"];
        self.email = [dic objectForKey:@"email"];
        self.phone = [dic objectForKey:@"phone"];
        self.preBook = [dic objectForKey:@"preBook"];
        self.signature = [dic objectForKey:@"signature"];
        self.servicearea = [dic objectForKey:@"servicearea"];
        self.language = [dic objectForKey:@"language"];
        self.price = [dic objectForKey:@"price"];
        self.pricedetail = [dic objectForKey:@"pricedetail"];
        self.servicedetail = [dic objectForKey:@"servicedetail"];
        self.tag = [dic objectForKey:@"tag"];
        self.images = [dic objectForKey:@"images"];
        self.star = [[dic objectForKey:@"star"] integerValue];
        self.usertype = [[dic objectForKey:@"usertype"] integerValue];
        self.userlat = [[dic objectForKey:@"userlat"] floatValue];
        self.userlng = [[dic objectForKey:@"userlng"] floatValue];
        self.otherinfoid = [dic objectForKey:@"otherinfoid"];
        self.ordernumber = [[dic objectForKey:@"ordernumber"] integerValue];
        self.registerdate = [[dic objectForKey:@"registerdate"] integerValue];
        self.commentnumber = [[dic objectForKey:@"commentnumber"] integerValue];
        self.messagenumber = [[dic objectForKey:@"messagenumber"] integerValue];
        self.status = [dic objectForKey:@"status"];
    }
}

@end
