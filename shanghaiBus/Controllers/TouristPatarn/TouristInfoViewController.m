//
//  TouristInfoViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/1.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristInfoViewController.h"
#import "TouristInputCommonCell.h"
#import "TouristInputInfoViewController.h"

@interface TouristInfoViewController ()<UITableViewDataSource ,UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableInfo;

@end

@implementation TouristInfoViewController

- (UITableView *)tableInfo {
    if (_tableInfo == nil) {
        _tableInfo = [[UITableView alloc] init];
        _tableInfo.delegate = self;
        _tableInfo.dataSource = self;
        _tableInfo.separatorColor = [UIColor clearColor];
        _tableInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableInfo.backgroundColor = BYBackColor;
        
    }
    return _tableInfo;
}

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initData {
    
}

- (void)initUI {
    self.view.backgroundColor = BYBackColor;
    [self setTitle:@"商家信息"];
    self.tableInfo.frame = self.view.bounds;
    [self.view addSubview:self.tableInfo];
    
    [self setRightButtonWithTitle:@"保存"];
}

#pragma mark - Action Methods
- (void)didTapTable {
    if (self.tableInfo.viewY < 0) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableInfo.viewY = 0;
        } completion:nil];
    }
}

- (void)didRightClick {
    [self didLeftClick];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfLine = 0;
    switch (section) {
        case 0:
        {
            numberOfLine = 1;
        }
            break;
        case 2:
        {
            numberOfLine = 1;
        }
            break;
        case 4:
        {
            numberOfLine = 3;
        }
            break;
        case 6:
        {
            numberOfLine = 1;
        }
            break;
        default: {
            numberOfLine = 0;
        }
            break;
    }
    return numberOfLine;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                TouristInputCommonCell *cellHeader = [tableView dequeueReusableCellWithIdentifier:@"TouristInputCommonCell"];
                if (cellHeader == nil) {
                    cellHeader = [[TouristInputCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TouristInputCommonCell"];
                }
                cellHeader.cellType = CELLTYPEICON;
                [cellHeader configCellWithData:nil];
                cellHeader.contentView.backgroundColor = [UIColor whiteColor];
                return cellHeader;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                }
                cell.textLabel.text = @"title";
                return cell;
            }
        }
            break;
        case 2:
        {
            TouristInputCommonCell *cellHeader = [tableView dequeueReusableCellWithIdentifier:@"TouristInputCommonCell"];
            if (cellHeader == nil) {
                cellHeader = [[TouristInputCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TouristInputCommonCell"];
            }
            cellHeader.cellType = CELLTYPEGENDER;
            [cellHeader configCellWithData:nil];
            cellHeader.contentView.backgroundColor = [UIColor whiteColor];
            return cellHeader;
        }
            break;
        case 4:
        {
            
            TouristInputCommonCell *cellHeader = [tableView dequeueReusableCellWithIdentifier:@"TouristInputCommonCell"];
            if (cellHeader == nil) {
                cellHeader = [[TouristInputCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TouristInputCommonCell"];
            }
            cellHeader.cellType = CELLTYPECOMMON;
            NSDictionary *dicData;
            switch (indexPath.row) {
                case 0:
                {
                    dicData = @{@"title":@"昵称",@"content":@"小鸭子"};
                    
                }
                    break;
                case 1:
                {
                    dicData = @{@"title":@"所在地",@"content":@"普通话，英语"};
                }
                    break;
                case 2:
                {
                    dicData = @{@"title":@"擅长语言",@"content":@"上海"};
                }
                    break;
                default:
                    break;
            }
            
            [cellHeader configCellWithData:dicData];
            cellHeader.contentView.backgroundColor = [UIColor whiteColor];
            return cellHeader;
        }
        case 6:
        {
            TouristInputCommonCell *cellHeader = [tableView dequeueReusableCellWithIdentifier:@"TouristInputCommonCell"];
            if (cellHeader == nil) {
                cellHeader = [[TouristInputCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TouristInputCommonCell"];
            }
            cellHeader.cellType = CELLTYPEINPUT;
            [cellHeader configCellWithData:nil];
            cellHeader.textPhone.delegate = self;
            cellHeader.contentView.backgroundColor = [UIColor whiteColor];
            return cellHeader;
        }
            break;
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
            cell.textLabel.text = @"title";
            return cell;
        }
            break;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                //头像
            }
        }
            break;
        case 2:
        {
            //性别
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //昵称
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"昵称"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
                    
                }
                    break;
                case 1:
                {
                    //所在地
                    //昵称
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"所在地"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                case 2:
                {
                    //擅长语言
                    //昵称
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"擅长语言"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
        case 6:
        {
            //电话号码
        }
            break;
        default: {

        }
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self didTapTable];
}

#pragma mark - UITextDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        self.tableInfo.viewY = -100;
    } completion:nil];
}

@end
