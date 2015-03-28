//
//  BYDevice.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BYDevice.h"

@implementation BYDevice
- (instancetype)share {
    static BYDevice *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (device == nil) {
            device = [[BYDevice alloc] init];
        }
    });
    return device;
}


@end
