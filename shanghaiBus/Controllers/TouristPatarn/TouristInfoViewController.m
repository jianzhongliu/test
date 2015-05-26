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

@interface TouristInfoViewController ()<UITableViewDataSource ,UITableViewDelegate, UITextFieldDelegate, TouristInputCommonCellDelegate,TouristInputInfoViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableInfo;
@property (nonatomic, strong) TouristInputCommonCell *cellPhone;

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *nuckName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *servicearea;
@property (nonatomic, strong) NSString *language;

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
    TouristObject *tourist = [[UserCachBean share] touristInfo];
    self.icon = tourist.icon.length > 0 ? tourist.icon:@"";
    self.nuckName = tourist.nuckname.length > 0 ? tourist.nuckname:@"";
    self.servicearea = tourist.servicearea.length > 0 ? tourist.servicearea:@"";
    self.phone = tourist.phone.length > 0 ? tourist.phone:@"";
    self.gender = [NSString stringWithFormat:@"%ld", tourist.gender];
    self.language = tourist.language.length > 0 ? tourist.language:@"";
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
    [self requestData];
    
}
#pragma mark - networking
- (void)requestData {
    
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *identify = [[[UserCachBean share] touristInfo] identify];
    self.phone = self.cellPhone.textPhone.text;
    self.nuckName = [self.nuckName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.servicearea = [self.servicearea stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.language = [self.language stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"%@tourist/updateTouristBaseInfo",HOST];

    NSDictionary *dic = @{@"identify":identify, @"icon":self.icon, @"phone":self.phone, @"gender":self.gender, @"nuckname":self.nuckName, @"servicearea":self.servicearea, @"language":self.language};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {[self hideLoadWithAnimated:YES];
        [self showInfo:@"修改成功!"];
        [UserCachBean fetchTouristInfo];
        [self performSelector:@selector(didDismissMyInfo) withObject:nil afterDelay:2];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
    }];
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
                TouristInputCommonCell *cellIcon = [tableView dequeueReusableCellWithIdentifier:@"TouristInputCommonCell"];
                if (cellIcon == nil) {
                    cellIcon = [[TouristInputCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TouristInputCommonCell"];
                }
                cellIcon.cellType = CELLTYPEICON;
                [cellIcon configCellWithData:nil];
                cellIcon.contentView.backgroundColor = [UIColor whiteColor];
                return cellIcon;
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
            cellHeader.delegate = self;
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
                    dicData = @{@"title":@"昵称",@"content":self.nuckName};
                    
                }
                    break;
                case 1:
                {
                    dicData = @{@"title":@"所在地",@"content":self.servicearea};
                }
                    break;
                case 2:
                {
                    dicData = @{@"title":@"擅长语言",@"content":self.language};
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
            self.cellPhone = [tableView dequeueReusableCellWithIdentifier:@"TouristInputCommonCell"];
            if (self.cellPhone == nil) {
                self.cellPhone = [[TouristInputCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TouristInputCommonCell"];
            }
            self.cellPhone.cellType = CELLTYPEINPUT;
            [self.cellPhone configCellWithData:nil];
            self.cellPhone.textPhone.delegate = self;
            self.cellPhone.contentView.backgroundColor = [UIColor whiteColor];
            return self.cellPhone;
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
                    controller.delegate = self;
                    controller.tag = 1;
                    controller.textContent.text = self.nuckName;
                    [self.navigationController pushViewController:controller animated:YES];
                    
                }
                    break;
                case 1:
                {
                    //所在地
                    //昵称
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"所在地"];
                    controller.delegate = self;
                    controller.tag = 2;
                    controller.textContent.text = self.servicearea;
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                case 2:
                {
                    //擅长语言
                    //昵称
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"擅长语言"];
                    controller.delegate = self;
                    controller.tag = 3;
                    controller.textContent.text = self.language;
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

#pragma mark - TouristInputCommonCellDelegate
- (void)didGenderChange:(BOOL)gender {
    self.gender = [NSString stringWithFormat:@"%d", gender];
}

- (void)didUploadInfoWith:(NSString *) content tag:(NSInteger) tag {
    switch (tag) {
        case 1:
        {
            self.nuckName = content;
        }
            break;
        case 2:
        {
            self.servicearea = content;
        }
            break;
        case 3:
        {
            self.language = content;
        }
            break;
        default:
            break;
    }
    [self.tableInfo reloadData];
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
