//
//  SearchObjectViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "SearchObjectViewController.h"

@interface SearchObjectViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchInput;
@property (nonatomic, strong) UITableView *tableList;

@end

@implementation SearchObjectViewController
- (UISearchBar *)searchInput {
    if (_searchInput == nil) {
        _searchInput = [[UISearchBar alloc] init];
        _searchInput.placeholder = @"搜目的地 景区 关键字";
        _searchInput.delegate = self;
    }
    return _searchInput;
}

- (UITableView *)tableList {
    if (_tableList == nil) {
        _tableList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableList.delegate = self;
        _tableList.dataSource = self;
        _tableList.separatorColor = [UIColor clearColor];
        _tableList.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableList;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchInput.frame = CGRectMake(0, 0, SCREENHEIGHT, 40);
    self.tableList.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.tableList.tableHeaderView = self.searchInput;
    [self.view addSubview:self.tableList];

}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    viewback.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.03);
    
    UILabel *labelSectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH, 40)];
    labelSectionHeader.text = @"热门搜索";
    labelSectionHeader.backgroundColor = [UIColor clearColor];
    [viewback addSubview:labelSectionHeader];
    return viewback;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 40)];
    labelContent.text = @"上海";
    [cell.contentView addSubview:labelContent];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, labelContent.ctBottom - 1, SCREENWIDTH - 20, 1)];
    viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    [cell addSubview:viewLine];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

}

@end
