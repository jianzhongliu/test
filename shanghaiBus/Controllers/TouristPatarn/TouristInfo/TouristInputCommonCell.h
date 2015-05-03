//
//  TouristInputCommonCell.h
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/1.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CELLTYPE) {
    CELLTYPEICON = 1, //头像
    CELLTYPEINPUT = 2, //输入框
    CELLTYPEGENDER = 3, //性别
    CELLTYPECOMMON = 4, //普通cell
};

@protocol TouristInputCommonCellDelegate <NSObject>
/**
 性别切换，
 yes表示女
 no表示男
 */
- (void)didGenderChange:(BOOL) gender;

@end

@interface TouristInputCommonCell : UITableViewCell

@property (nonatomic, strong) UITextField *textPhone;

@property (nonatomic) CELLTYPE cellType;
@property (nonatomic, assign) id<TouristInputCommonCellDelegate> delegate;

- (void)configCellWithData:(id) celldata;


@end
