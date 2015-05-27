//
//  TouristMessageViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/27.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
#import "TouristObject.h"
#import "MessageObject.h"

@interface TouristMessageViewController : BaseViewController

@property (nonatomic, strong) TouristObject *tourist;
@property (nonatomic, strong) MessageObject *message;//留言

@end
