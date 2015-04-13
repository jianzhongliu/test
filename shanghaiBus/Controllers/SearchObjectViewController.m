//
//  SearchObjectViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "SearchObjectViewController.h"
#import "TouristListViewController.h"

@interface SearchObjectViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    BOOL isHasResult;
}
@property (nonatomic, strong) UISearchBar *searchInput;
@property (nonatomic, strong) UITableView *tableList;

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;

@property (nonatomic, strong) NSMutableArray *arraySectionStatus;
//搜索结果
@property (nonatomic, strong) NSMutableArray *arraySearchCitys;

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
    isHasResult = NO;
    self.arraySearchCitys = [NSMutableArray array];
    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
    self.keys = [NSMutableArray array];
    self.arraySectionStatus = [NSMutableArray array];
    self.arrayCitys = [NSMutableArray array];
    [self getCityData];
}

- (void)didClickHeader:(id) sender {
    UIButton *button = (UIButton *)sender;
    if ([[self.arraySectionStatus objectAtIndex:button.tag] isEqualToString:@"1"]) {
        [self.arraySectionStatus replaceObjectAtIndex:button.tag withObject:@"0"];
    } else {
        [self.arraySectionStatus replaceObjectAtIndex:button.tag withObject:@"1"];
    }
    
    [self.tableList reloadSections:[[NSIndexSet alloc] initWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加热门城市
    NSString *strHot = @"热";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
    for (NSString *str in self.keys) {
        if ([str isEqualToString:@"热"]) {
            [self.arraySectionStatus addObject:@"1"];
        } else {
            [self.arraySectionStatus addObject:@"0"];
        }
    }
}

- (void)getCityByName:(NSString *) name {
    [self.arraySearchCitys removeAllObjects];
    
    for (NSString *str in self.keys) {
        NSArray *arrayCity = [self.cities objectForKey:str];
        for (NSString *cityName in arrayCity) {
            if ([cityName rangeOfString:name].location != NSNotFound) {
                [self.arraySearchCitys addObject:cityName];
            }
        }
    }
    if (self.arraySearchCitys.count == 0) {
        [self.arraySearchCitys addObject:name];
    }
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchInput.frame = CGRectMake(0, 0, SCREENHEIGHT, 40);
    self.tableList.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.tableList.tableHeaderView = self.searchInput;
    [self.view addSubview:self.tableList];

}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isHasResult == YES) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    UIButton *buttonHeader = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonHeader.frame = bgView.bounds;
    buttonHeader.tag = section;
    [buttonHeader addTarget:self action:@selector(didClickHeader:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:buttonHeader];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, 39, SCREENWIDTH - 20 , 1)];
    viewLine.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:viewLine];
    return bgView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isHasResult == YES) {
        return 1;
    } else {
        return [_keys count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isHasResult == YES) {
        return self.arraySearchCitys.count;
    }
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    if ([[self.arraySectionStatus objectAtIndex:section] isEqualToString:@"1"]) {
        return [citySection count];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (isHasResult == YES) {
        return 0;
    } else {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, 39, SCREENWIDTH - 20 , 1)];
        viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.3);
        [cell.contentView addSubview:viewLine];
    }
    if (isHasResult == YES) {
        if (indexPath.row < self.arraySearchCitys.count) {
            cell.textLabel.text = [self.arraySearchCitys objectAtIndex:indexPath.row];
        }
    } else {
        NSString *key = [_keys objectAtIndex:indexPath.section];
        cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TouristListViewController *controller = [[TouristListViewController alloc] init];
    if (isHasResult == YES) {
        controller.siteName = [self.arraySearchCitys objectAtIndex:indexPath.row];
    } else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        controller.siteName = cell.textLabel.text;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length > 0) {
        isHasResult = YES;
    } else {
        isHasResult = NO;
    }
    [self getCityByName:searchBar.text];
    [self.tableList reloadData];
}

@end
