//
//  BusStationListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "BusStationListViewController.h"
#import "BusStationDetailViewController.h"

@interface BusStationListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arraySiteLine;
@property (nonatomic, strong) UIView *viewHeader;

@end

@implementation BusStationListViewController

- (id)init{
    if (self == [super init]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initUI];
    [self requestData];
}

#pragma mark - private Methods
- (void)initUI {
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];

    self.viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.viewHeader.backgroundColor = [UIColor whiteColor];
    self.table.tableHeaderView = self.viewHeader;
}

- (void)initData {
    
    self.arraySiteLine = [NSMutableArray array];
    
}

- (void)requestData {
    NSString *url = [NSString stringWithFormat:@"http://61.129.57.96:8014/Project/Ver1/getLine.ashx?lineid=001400&my=AE33B4AD0E571A40B60A8429E5925F16&t=2015-03-2200:18"];
    [self requestBusData:url];
    __weak __typeof(self) blockSelf = self;
    self.busData = ^(AFHTTPRequestOperation *operation, BOOL status) {
        NSLog(@"%@",operation.responseString);
        if (YES == status) {
            NSArray *station = [operation.responseString componentsSeparatedByString:@"<zdmc>"];
            for (NSString *stationString in station) {
                NSArray *tempArray = [stationString componentsSeparatedByString:@"</zdmc>"];
                if (tempArray.count > 0) {
                    [blockSelf.arraySiteLine addObject:[tempArray objectAtIndex:0]];
                }
            }
            [blockSelf.table reloadData];
        } else {
            
        }
    };
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arraySiteLine.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.backgroundColor = [UIColor clearColor];
    if (self.arraySiteLine.count > indexPath.row) {
        label.text = [self.arraySiteLine objectAtIndex:indexPath.row];
    }
    [cell.contentView addSubview:label];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusStationDetailViewController *controller = [[BusStationDetailViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    //
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //
}



@end
