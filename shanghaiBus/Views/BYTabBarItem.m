//
//  BYTabBarItem.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/18.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BYTabBarItem.h"

@implementation BYTabBarItem

//自定义高亮图，如不需请隐藏该方法
- (UIImage *)selectedImage{
    return self.highlightedImage;
}

- (UIImage *)unselectedImage{
    return self.image;
}

//半透白框撑满，如不需请隐藏该方法
- (UIEdgeInsets)imageInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
