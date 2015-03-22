//
//  MainBusListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MainHomePageViewController.h"
#import "BusStationListViewController.h"
#import "HomeHeaderView.h"
#import "HomePageSepratorCell.h"

#import "Sites.h"

@interface MainHomePageViewController () <UITableViewDataSource, UITableViewDelegate, HomePageSepratorCellDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arraySiteLine;
@property (nonatomic, strong) HomeHeaderView *viewHeader;

@end

@implementation MainHomePageViewController

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
    self.table.backgroundColor = BYColorFromHex(0x999999);
    [self.view addSubview:self.table];
    self.viewHeader = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 85)];
//    self.viewHeader.delegate = self;
    self.table.tableHeaderView = self.viewHeader;
}

- (void)initData {
    
    self.arraySiteLine = [NSMutableArray array];
    
}

- (void)requestData {
    [self.arraySiteLine removeAllObjects];
    Sites *site = [[Sites alloc] init];
    site.imageUrl = @"http://hiphotos.baidu.com/lvpics/pic/item/0db2c9cae7029b2af31fe713.jpg";
    site.siteName = @"西湖";
    site.touristNumber = @"150";
    [self.arraySiteLine addObject:site];
    
    Sites *site1 = [[Sites alloc] init];
    site1.imageUrl = @"http://hiphotos.baidu.com/lvpics/pic/item/0b3a1c08063d9bbd63d98613.jpg";
    site1.siteName = @"西塘";
    site1.touristNumber = @"250";
    [self.arraySiteLine addObject:site1];
    
    Sites *site2 = [[Sites alloc] init];
    site2.imageUrl = @"http://hiphotos.baidu.com/lvpics/pic/item/0824ab18972bd4071e50504a7b899e510eb309f5.jpg";
    site2.siteName = @"张家界";
    site2.touristNumber = @"170";
    [self.arraySiteLine addObject:site2];
    
    Sites *site3 = [[Sites alloc] init];
    site3.imageUrl = @"http://hiphotos.baidu.com/lvpics/pic/item/d157172492cf0647d50742e0.jpg";
    site3.siteName = @"丽江";
    site3.touristNumber = @"190";
    [self.arraySiteLine addObject:site3];
    
    Sites *site4 = [[Sites alloc] init];
    site4.imageUrl = @"http://hiphotos.baidu.com/lvpics/pic/item/54baacfbd2c1fc4e4e4aeae1.jpg";
    site4.siteName = @"北京";
    site4.touristNumber = @"40";
    [self.arraySiteLine addObject:site4];
    
    [self.table reloadData];
    
    NSArray *arrayImg = @[@"http://hiphotos.baidu.com/lvpics/pic/item/83025aafa40f4bfbc7471de3034f78f0f63618f5.jpg",@"http://hiphotos.baidu.com/lvpics/pic/item/83025aafa40f4bfbc7471de3034f78f0f63618f5.jpg",@"http://hiphotos.baidu.com/lvpics/pic/item/83025aafa40f4bfbc7471de3034f78f0f63618f5.jpg"];
    NSMutableDictionary *dicParam = [NSMutableDictionary dictionary];
    [dicParam setValue:arrayImg forKey:@"img"];
    [self.viewHeader resetDataToView:dicParam];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.arraySiteLine.count / 2  < self.arraySiteLine.count / 2.0f) {
        return self.arraySiteLine.count / 2 +1;
    } else {
        return self.arraySiteLine.count / 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 0) {
        return [HomePageSepratorCell fetchCellHeight];
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    viewSection.backgroundColor = [UIColor whiteColor];
    UILabel *labelSection = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 70, 20)];
    labelSection.text = @"热门景区";
    labelSection.font = [UIFont boldSystemFontOfSize:12];
    labelSection.textColor = BYColorAlphaMake(0, 0, 0, 0.7);
    [viewSection addSubview:labelSection];
    viewSection.backgroundColor = viewSection.backgroundColor;
    return viewSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"cell";
    HomePageSepratorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[HomePageSepratorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.delegate = self;
    }
    NSMutableArray *arrayCell = [NSMutableArray array];
    if (self.arraySiteLine.count > indexPath.row * 2) {
        [arrayCell addObject:[self.arraySiteLine objectAtIndex:indexPath.row * 2]];
        if (self.arraySiteLine.count > indexPath.row * 2 + 1) {
           [arrayCell addObject:[self.arraySiteLine objectAtIndex:(indexPath.row *2 +1)]];
        }
    }

    [cell resetDataWith:arrayCell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusStationListViewController *controller = [[BusStationListViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
//
}

- (void)didClickImageAtCell:(HomePageSepratorCell *)cell withIndex:(NSInteger)index {


}
@end
