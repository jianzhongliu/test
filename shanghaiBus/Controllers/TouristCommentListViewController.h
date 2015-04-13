//
//  TouristCommentListViewController.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/27.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
#import "TouristObject.h"

@interface TouristCommentListViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *arrayComment;
@property (nonatomic, strong) TouristObject *tourist;

@end
