//
//  UploadServiceViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UploadServiceViewController.h"
#import "UploadInfoCommonInputView.h"
#import "TouristInputInfoViewController.h"

#import "ImageScrollView.h"

@interface UploadServiceViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableList;

@property (nonatomic, strong) ImageScrollView *imageList;

@property (nonatomic, strong) UploadInfoCommonInputView *viewTitle;
@property (nonatomic, strong) UploadInfoCommonInputView *viewPrice;
@property (nonatomic, strong) UploadInfoCommonInputView *viewArea;
@property (nonatomic, strong) UploadInfoCommonInputView *viewLanguage;
@property (nonatomic, strong) UploadInfoCommonInputView *viewPriceDetail;
@property (nonatomic, strong) UploadInfoCommonInputView *viewPreBook;
@property (nonatomic, strong) UploadInfoCommonInputView *viewService;

@end

@implementation UploadServiceViewController

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYBackColor;
    [self initUI];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(didSaveInfo)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self setTitle:@"发布服务信息"];
    
}

- (void)initData {
    
}

- (void)initUI {
    self.tableList.frame = self.view.bounds;
    [self.view addSubview:self.tableList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - action && private Methods
- (void)didDismissMyInfo {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSaveInfo {
    
    [self didDismissMyInfo];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    switch (section) {
        case 0:
        {
            number = 2;
        }
            break;
        case 2:
        {
            number = 2;
        }
            break;
        case 4:
        {
            number = 3;
        }
            break;
        default:
            break;
    }
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    NSArray *subview = [cell subviews];
    for (UIView *view in subview) {
        if ([view isKindOfClass:[UploadInfoCommonInputView class]]) {
            [view removeFromSuperview];
        }
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.viewTitle configViewWithTitle:@"标    题"];
                    [cell addSubview:self.viewTitle];
                }
                    break;
                case 1:
                {
                    [self.viewPrice configViewWithTitle:@"价     格"];
                    [cell addSubview:self.viewPrice];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.viewArea configViewWithTitle:@"导游区域"];
                    [cell addSubview:self.viewArea];
                }
                    break;
                case 1:
                {
                    [self.viewLanguage configViewWithTitle:@"擅长语言"];
                    [cell addSubview:self.viewLanguage];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.viewPriceDetail configViewWithTitle:@"价格说明"];
                    [cell addSubview:self.viewPriceDetail];
                }
                    break;
                case 1:
                {
                    [self.viewPreBook configViewWithTitle:@"预订须知"];
                    [cell addSubview:self.viewPreBook];
                }
                    break;
                case 2:
                {
                    [self.viewService configViewWithTitle:@"服务描述"];
                    [cell addSubview:self.viewService];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"标题"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewTitle configViewWithTitle:@"标    题"];
//                    [cell addSubview:self.viewTitle];
                }
                    break;
                case 1:
                {
                    [self.viewPrice.textInput becomeFirstResponder];
//                    [self.viewPrice configViewWithTitle:@"价     格"];
//                    [cell addSubview:self.viewPrice];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"导游区域"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewArea configViewWithTitle:@"导游区域"];
//                    [cell addSubview:self.viewArea];
                }
                    break;
                case 1:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"擅长语言"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewLanguage configViewWithTitle:@"擅长语言"];
//                    [cell addSubview:self.viewLanguage];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"价格说明"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewPriceDetail configViewWithTitle:@"价格说明"];
//                    [cell addSubview:self.viewPriceDetail];
                }
                    break;
                case 1:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"预订须知"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewPreBook configViewWithTitle:@"预订须知"];
//                    [cell addSubview:self.viewPreBook];
                }
                    break;
                case 2:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"服务描述"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewService configViewWithTitle:@"服务描述"];
//                    [cell addSubview:self.viewService];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter && setter

- (UITableView *)tableList {
    if (_tableList == nil) {
        _tableList = [[UITableView alloc] init];
        _tableList.delegate = self;
        _tableList.dataSource = self;
        _tableList.separatorColor = [UIColor clearColor];
        _tableList.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableList;
}

- (ImageScrollView *)imageList {
    if (_imageList == nil) {
        _imageList = [[ImageScrollView alloc] init];
    }
    return _imageList;
}

- (UploadInfoCommonInputView *)viewTitle {
    if (_viewTitle == nil) {
        _viewTitle = [[UploadInfoCommonInputView alloc] init];
        _viewTitle.viewType = VIEWTYPENAME;
    }
    return _viewTitle;
}

- (UploadInfoCommonInputView *)viewPrice {
    if (_viewPrice == nil) {
        _viewPrice = [[UploadInfoCommonInputView alloc] init];
        _viewPrice.viewType = VIEWTYPEPRICE;
    }
    return _viewPrice;
}

- (UploadInfoCommonInputView *)viewArea {
    if (_viewArea == nil) {
        _viewArea = [[UploadInfoCommonInputView alloc] init];
        _viewArea.viewType = VIEWTYPENAME;
    }
    return _viewArea;
}

- (UploadInfoCommonInputView *)viewLanguage {
    if (_viewLanguage == nil) {
        _viewLanguage = [[UploadInfoCommonInputView alloc] init];
        _viewLanguage.viewType = VIEWTYPENAME;
    }
    return _viewLanguage;
}

- (UploadInfoCommonInputView *)viewPriceDetail {
    if (_viewPriceDetail == nil) {
        _viewPriceDetail = [[UploadInfoCommonInputView alloc] init];
        _viewPriceDetail.viewType = VIEWTYPENAME;
    }
    return _viewPriceDetail;
}

- (UploadInfoCommonInputView *)viewPreBook {
    if (_viewPreBook == nil) {
        _viewPreBook = [[UploadInfoCommonInputView alloc] init];
        _viewPreBook.viewType = VIEWTYPENAME;
    }
    return _viewPreBook;
}

- (UploadInfoCommonInputView *)viewService {
    if (_viewService == nil) {
        _viewService = [[UploadInfoCommonInputView alloc] init];
        _viewService.viewType = VIEWTYPENAME;
    }
    return _viewService;
}

@end
