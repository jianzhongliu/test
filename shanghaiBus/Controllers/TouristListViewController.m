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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initUI];
    [self requestData];
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

- (void)requestData {
    TouristObject *tourist = [[TouristObject alloc] init];
    tourist.icon = @"";
    tourist.signature = @"万浪从中过, 落地滴水不沾身！";
    tourist.nuckname = @"小鑫呱呱";
    tourist.price = @"300";
    [self.arrayTourist addObject:tourist];
    
    TouristObject *tourist1 = [[TouristObject alloc] init];
    tourist1.icon = @"http://hiphotos.baidu.com/lvpics/pic/item/4bed2e738bd4b31cdbab170c87d6277f9f2ff8f6.jpg";
    tourist1.signature = @"服务周到，300包日！";
    tourist1.nuckname = @"华子呱呱";
    tourist1.price = @"300";
    [self.arrayTourist addObject:tourist1];
    
    TouristObject *tourist2 = [[TouristObject alloc] init];
    tourist2.icon = @"http://hiphotos.baidu.com/lvpics/pic/item/a71ea8d3fd1f413491cc9eb6251f95cad0c85e7a.jpg";
    tourist2.signature = @"没人比这个更便宜了，没人比这个服务更周到了！";
    tourist2.nuckname = @"小豪豪呱呱";
    tourist2.price = @"50";
    [self.arrayTourist addObject:tourist2];
    
    TouristObject *tourist3 = [[TouristObject alloc] init];
    tourist3.icon = @"http://hiphotos.baidu.com/lvpics/pic/item/f703738da9773912e1b106d6f8198618377ae2f6.jpg";
    tourist3.signature = @"只服务有缘人，再多钱哥都不要！";
    tourist3.nuckname = @"佩佩";
    tourist3.price = @"100";
    [self.arrayTourist addObject:tourist3];
    
    TouristObject *tourist4 = [[TouristObject alloc] init];
    tourist4.icon = @"http://hiphotos.baidu.com/lvpics/pic/item/8b82b9014a90f603244b078f3912b31bb151ed7b.jpg";
    tourist4.signature = @"王子式的服务试过吗！";
    tourist4.nuckname = @"王+的+子";
    tourist4.price = @"1";
    [self.arrayTourist addObject:tourist4];
    
    TouristObject *tourist5 = [[TouristObject alloc] init];
    tourist5.icon = @"http://hiphotos.baidu.com/lvpics/pic/item/f703738da9773912e1b106d6f8198618377ae2f6.jpg";
    tourist5.signature = @"没有服务就是最好的服务（我永远不懂）";
    tourist5.nuckname = @"干哥";
    tourist5.price = @"0.5";
    [self.arrayTourist addObject:tourist5];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayTourist.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
