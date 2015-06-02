//
//  MainBusListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MainHomePageViewController.h"
#import "TouristDetailViewController.h"
#import "SearchObjectViewController.h"
#import "TouristBaseInfoViewController.h"
#import "AuthenticatedInfoViewController.h"
#import "UploadServiceViewController.h"
#import "ACWebViewController.h"

#import "HomeHeaderView.h"
#import "HomePageSepratorCell.h"
#import "HomePageSingleCell.h"
#import "TouristListViewController.h"
#import "Sites.h"

#import "UMSocial.h"

@interface MainHomePageViewController () <UITableViewDataSource, UITableViewDelegate, HomePageSepratorCellDelegate, HomeHeaderViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arraySiteLine;
@property (nonatomic, strong) NSMutableArray *arrayAD;//ad
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
    [self.view setBackgroundColor:BYBackColor];
    [self initUI];
    [self requestData];
    
//抓取携程当地有导游数据
//    [self testCtripdata];//
    [self.navigationItem setLeftBarButtonItem:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - private Methods
- (void)initUI {
    [self setTitle:@"首页"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(businessEnter)];
    rightItem.title = @"商家入驻";
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorColor = [UIColor clearColor];
    self.table.backgroundColor = BYColorFromHex(0xf5f5f5);
    [self.view addSubview:self.table];
    self.viewHeader = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 137)];
    self.viewHeader.delegate = self;
    self.table.tableHeaderView = self.viewHeader;
}

- (void)businessEnter{
    [self doLoginWithBlock:^(UserCachBean *userInfo, LOGINSTATUS status) {
        if ([[[UserCachBean share] touristInfo] usertype] != 3) {
            AuthenticatedInfoViewController *controller = [[AuthenticatedInfoViewController alloc] init];
            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:myNavController animated:YES completion:nil];
        } else {
            //当认证成功就可以直接发服务了
            
            UploadServiceViewController *controller = [[UploadServiceViewController alloc] init];
            UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:myNavController animated:YES completion:nil];
        }
    }];
}

- (void)initData {
    [self fetchLoginData];
    self.arraySiteLine = [NSMutableArray array];
    self.arrayAD = [NSMutableArray array];
}

- (void)fetchLoginData {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"user.plist"];
    
    NSDictionary *dicUser = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    TouristObject *tourist = [[TouristObject alloc] init];
    [tourist configTouristWithDic:dicUser];
    [UserCachBean share].touristInfo = tourist;
    
}

- (void)reloadData {
    if (self.arraySiteLine.count > 0) {
        [self.table reloadData];
    } else {
    //无数据
    }
}

- (void)testCtripdata {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
//http://m.ctrip.com/restapi/soa2/10397/GetNativeProductDetail?_fxpcqlniredt=09031119110012839181
    NSString *url = @"http://m.ctrip.com/restapi/soa2/10397/GetNativeProductDetail";
//    NSDictionary *dic = @{@"Language":@"0",@"Sex":@"0",@"CompanyLicense":@"0",@"GuideLicense":@"0",@"DriverLicense":@"0",@"SortType":@"0",@"DistrictId":@"2",@"ServiceType":@"1",@"PageIndex":@"1",@"PageSize":@"10",@"head":@{@"cid":@"09031119110012839181",@"ctok":@"351858059049938",@"cver":@"1.0",@"lang":@"01",@"sid":@"2328",@"syscode":@"09",@"auth":@""},@"contentType":@"json"};
//    {"Language":0,"Sex":0,"CompanyLicense":0,"GuideLicense":0,"DriverLicense":0,"SortType":0,"DistrictId":"2","ServiceType":1,"PageIndex":1,"PageSize":10,"head":{"cid":"09031119110012839181","ctok":"351858059049938","cver":"1.0","lang":"01","sid":"2328","syscode":"09","auth":""},"contentType":"json"}
    
    NSDictionary *dic = @{@"_fxpcqlniredt":@"09031119110012839181",@"NativeProductId":@"1897",@"head":@{@"cid":@"09031119110012839181",@"ctok":@"351858059049938",@"cver":@"1.0",@"lang":@"01",@"sid":@"2328",@"syscode":@"09",@"auth":@""},@"contentType":@"json"};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"OK====%@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog( @"error ==== %@", error);
    }];
}

//http://m.ctrip.com/restapi/soa2/10397/GetNativeProductDetail?_fxpcqlniredt=09031119110012839181
- (void)requestData {
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = @"0";
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@scenary/getHotScenary",HOST];
    NSDictionary *dic = @{@"date":currentTime,@"userid":userid,@"sign":sign};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *dataArray = [dic objectForKey:@"dataArray"];
            if (dataArray.count > 0) {
                [self.arraySiteLine removeAllObjects];
                for (NSDictionary *dic in dataArray) {
                    Sites *site = [[Sites alloc] init];
                    [site configSiteWithDic:dic];
                    [self.arraySiteLine addObject:site];
                }
                [self reloadData];
            }
            //广告
            if ([[dic objectForKey:@"arrayBanners"] isKindOfClass:[NSArray class]]) {
                [self.arrayAD addObjectsFromArray:[dic objectForKey:@"arrayBanners"]];
            } else if ([[dic objectForKey:@"arrayBanners"] count] > 0 ){
                [self.arrayAD addObject:[dic objectForKey:@"arrayBanners"]];
            }
            NSMutableDictionary *dicParam = [NSMutableDictionary dictionary];
            [dicParam setValue:self.arrayAD forKey:@"img"];
            [self.viewHeader resetDataToView:dicParam];
            [self.table reloadData];
        }
        [self hideLoadWithAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
    }];
//    
//    NSArray *arrayImg = @[@"http://hiphotos.baidu.com/lvpics/pic/item/83025aafa40f4bfbc7471de3034f78f0f63618f5.jpg",@"http://hiphotos.baidu.com/lvpics/pic/item/1f178a82b9014a90b8a9c50aa9773912b21beef6.jpg"];
//    NSMutableDictionary *dicParam = [NSMutableDictionary dictionary];
//    [dicParam setValue:arrayImg forKey:@"img"];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.arraySiteLine.count == 0) {
        return 0;
    }
    
    if ((self.arraySiteLine.count - 1)/ 2  < (self.arraySiteLine.count - 1) / 2.0f) {
        return (self.arraySiteLine.count - 1) / 2 +1 +1;
    } else {
        return (self.arraySiteLine.count - 1) / 2 + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        return [HomePageSepratorCell fetchCellHeight];
    } else {
        return [HomePageSingleCell fetchCellHeight] + 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    viewSection.backgroundColor = BYColorFromHex(0xf5f5f5);
    UILabel *labelSection = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 70, 20)];
    labelSection.text = @"热门景区";
    labelSection.font = [UIFont boldSystemFontOfSize:14];
    labelSection.textColor = BYColorAlphaMake(0, 0, 0, 0.7);
    [viewSection addSubview:labelSection];
    viewSection.backgroundColor = viewSection.backgroundColor;
    
    UIImageView *imageSearchBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 18, 3, 12)];
    imageSearchBack.image = [UIImage imageNamed:@"icon_hot_scenery"];
    [viewSection addSubview:imageSearchBack];
    
    return viewSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   
    if (indexPath.row == 0) {
        static NSString *cellIdentifySingle = @"HomePageSingleCell";
        HomePageSingleCell *cellSingle = [tableView dequeueReusableCellWithIdentifier:cellIdentifySingle];
        if (cellSingle == nil) {
            cellSingle = [[HomePageSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifySingle];
            cellSingle.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.arraySiteLine.count > indexPath.row) {
            [cellSingle resetDataWith:[self.arraySiteLine objectAtIndex:indexPath.row]];
        }
        return cellSingle;
    } else {
        static NSString *cellIdentify = @"cell";
        HomePageSepratorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil) {
            cell = [[HomePageSepratorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.delegate = self;
        }
        NSMutableArray *arrayCell = [NSMutableArray array];
        if (self.arraySiteLine.count - 1 > (indexPath.row - 1)* 2) {
            [arrayCell addObject:[self.arraySiteLine objectAtIndex:(indexPath.row - 1)* 2]];
            if (self.arraySiteLine.count- 1 > (indexPath.row - 1) * 2 +1) {
                [arrayCell addObject:[self.arraySiteLine objectAtIndex:(indexPath.row - 1) * 2 +1]];
            }
        }
        
        [cell resetDataWith:arrayCell];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TouristListViewController *controller = [[TouristListViewController alloc] init];
    Sites *site = (Sites *)[self.arraySiteLine objectAtIndex:0];
    controller.siteName = site.cityname;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
//
}

- (void)didClickImageAtCell:(HomePageSepratorCell *)cell withIndex:(NSInteger)index {
    TouristListViewController *controller = [[TouristListViewController alloc] init];
    Sites *site = (Sites *)[self.arraySiteLine objectAtIndex:index];
    controller.siteName = site.cityname;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)didClickHeaderImageBannerAtIndex:(NSInteger )index withUrl:(NSDictionary *) dic {
    ACWebViewController *controller = [[ACWebViewController alloc] init];
    controller.initialURL = [NSURL URLWithString:[dic objectForKey:@"detailUrl"]];
    [controller setTitle:[dic objectForKey:@"title"]];
    controller.hidesBottomBarWhenPushed = YES;
    controller.hideToolbar = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickHeaderSearch {
    SearchObjectViewController *controller = [[SearchObjectViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
//ACWebViewController
@end
