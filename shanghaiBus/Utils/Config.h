//
//  Config.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/22.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//
#import "UIView+CTExtensions.h"
#import "UILabel+HightLight.h"
#import "Utils.h"

#ifndef shanghaiBus_Config_h

#define shanghaiBus_Config_h

//#define HOST @"http://115.28.58.185/B-Y/REST/"
#define HOST @"http://localhost:8080/B-Y/REST/"
//#define HOST @"http://192.168.1.102:8080/B-Y/REST/"

#define API_PhotoUpload @"http://upd1.ajkimg.com/upload"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#define BYColorMake(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define BYColorAlphaMake(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define BYColorFromHex(rgb)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]

#define BYColor BYColorFromHex(0x22b9f7)
#define BYBackColor BYColorFromHex(0xf5f5f5)
#define BYLineSepratorColor BYColorFromHex(0xdddddd)
#define BYBlackColor BYColorFromHex(0x333333);
//title设置为18


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#endif
