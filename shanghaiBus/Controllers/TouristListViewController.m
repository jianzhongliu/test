//
//  BusStationDetailViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristListViewController.h"
#import "TouristListCell.h"
#import "TouristDetailViewController.h"

@interface TouristListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arrayTourist;
@property (nonatomic, strong) UIView *viewHeader;

@end

@implementation TouristListViewController

- (id)init{
    if (self == [super init]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.siteName];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initUI];
    [self requestData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark - private Methods
- (void)initUI {
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.table];
    
    self.viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.viewHeader.backgroundColor = [UIColor whiteColor];
//    self.table.tableHeaderView = self.viewHeader;
}

- (void)initData {
    
    self.arrayTourist = [NSMutableArray array];
    
}

- (void)reloadData {
    if (self.arrayTourist.count > 0) {
        [self.table reloadData];
    } else {
    //无数据
    }
}

- (void)requestData {
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *site = [self.siteName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, site];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@service/getServiceByCityName",HOST];
    NSDictionary *dic = @{@"date":currentTime,@"cityname":site,@"sign":sign};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *dataArray = [dic objectForKey:@"touristArray"];
            if (dataArray.count > 0) {
                [self.arrayTourist removeAllObjects];
                for (NSDictionary *dic in dataArray) {
                    TouristObject *site = [[TouristObject alloc] init];
                    [site configTouristWithDic:dic];
                    [self.arrayTourist addObject:site];
                }
                [self reloadData];
            }
        }
        [self hideLoadWithAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
    }];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayTourist.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"cell";
    TouristListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[TouristListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (self.arrayTourist.count > indexPath.row) {
        [cell resetCellDataWith:[self.arrayTourist objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TouristDetailViewController *controller = [[TouristDetailViewController alloc] init];
    TouristObject *tourist = (TouristObject *)[self.arrayTourist objectAtIndex:indexPath.row];
    controller.tourist = tourist;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //
}

@end
