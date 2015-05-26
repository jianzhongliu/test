//
//  ServiceObject.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/23.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "ServiceObject.h"

@implementation ServiceObject
- (void)configTouristWithDic:(NSDictionary *) dic {
    
    if (dic && dic.count > 0) {
        self.identify = [dic objectForKey:@"identify"];
        self.touristid = [dic objectForKey:@"touristid"];
        self.servicearea = [dic objectForKey:@"servicearea"];
        self.language = [dic objectForKey:@"language"];
        self.price = [dic objectForKey:@"price"];
        self.pricedetail = [dic objectForKey:@"pricedetail"];
        self.preBook = [dic objectForKey:@"prebook"];
        self.servicedetail = [dic objectForKey:@"servicedetail"];
        self.images = [dic objectForKey:@"images"];
        self.otherinfoid = [dic objectForKey:@"otherinfoid"];
        self.ordernumber = [[dic objectForKey:@"ordernumber"] integerValue];
        self.registerdate = [[dic objectForKey:@"registerdate"] integerValue];
        self.commentnumber = [[dic objectForKey:@"commentnumber"] integerValue];
        self.messagenumber = [[dic objectForKey:@"messagenumber"] integerValue];
        self.addDate = [[dic objectForKey:@"adddate"] doubleValue];
        self.star = [[dic objectForKey:@"star"] floatValue];
        self.status = [dic objectForKey:@"status"];
    }
}

@end
