//
//  BusStationListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristDetailViewController.h"
#import "TouristListViewController.h"
#import "WebImageView.h"
#import "TouristServiceInfoView.h"
#import "TouristServiceDetailView.h"

@interface TouristDetailViewController () <UIScrollViewDelegate, TouristServiceDetailViewDelegate>

@property (nonatomic, strong) NSMutableArray *arraySiteLine;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UIScrollView *scrollImg;

@property (nonatomic, strong) UIScrollView *scrollDetail;
@property (nonatomic, strong) TouristServiceInfoView *viewServiceInfo;
@property (nonatomic, strong) TouristServiceDetailView *viewServiceDetail;//服务的详细说明
@property (nonatomic, strong) TouristServiceDetailView *viewServiceOrder;//服务的详细说明
@end

@implementation TouristDetailViewController

#pragma mark - getter&&setter Methods
- (TouristServiceInfoView *)viewServiceInfo {
    if (_viewServiceInfo == nil) {
        _viewServiceInfo = [[TouristServiceInfoView alloc] init];
        _viewServiceInfo.backgroundColor = [UIColor whiteColor];
        
    }
    return _viewServiceInfo;
}

- (UIScrollView *)scrollDetail {
    if (_scrollDetail == nil) {
        _scrollDetail = [[UIScrollView alloc] init];
        _scrollDetail.delegate = self;
        _scrollDetail.pagingEnabled = NO;
        _scrollDetail.scrollEnabled = YES;
        _scrollDetail.showsHorizontalScrollIndicator = NO;
        _scrollDetail.backgroundColor = BYColor;
        [self.view addSubview:_scrollDetail];
    }
    return  _scrollDetail;
}

- (TouristServiceDetailView *)viewServiceDetail {
    if (_viewServiceDetail == nil) {
        _viewServiceDetail = [[TouristServiceDetailView alloc] init];
        _viewServiceDetail.backgroundColor = [UIColor whiteColor];
        _viewServiceDetail.delegate = self;
    }
    return _viewServiceDetail;
}

- (TouristServiceDetailView *)viewServiceOrder {
    if (_viewServiceOrder == nil) {
        _viewServiceOrder = [[TouristServiceDetailView alloc] init];
        _viewServiceOrder.backgroundColor = [UIColor whiteColor];
        _viewServiceOrder.delegate = self;
    }
    return _viewServiceOrder;
}

#pragma mark - lifeCycle Methods
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
    
    self.scrollDetail.frame = self.view.bounds;
    
    self.scrollImg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150)];
    self.scrollImg.delegate = self;
    self.scrollImg.contentSize = CGSizeMake(SCREENWIDTH * 5, 150);
    self.scrollImg.pagingEnabled = YES;
    [self.scrollDetail addSubview:self.scrollImg];
    [self.scrollDetail addSubview:self.viewServiceDetail];
    [self.scrollDetail addSubview:self.viewServiceInfo];
    [self.scrollDetail addSubview:self.viewServiceOrder];
}

- (void)initData {
    
    self.arraySiteLine = [NSMutableArray array];
    
}

- (void)reDrawScrollView {
    [self.viewServiceInfo configViewWithData:nil];
    [self.viewServiceDetail configViewWithTitle:@"价格说明" detail:@"没什么好描述的iewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetail"];//价格说明
    [self.viewServiceOrder configViewWithTitle:@"预定须知" detail:@"没什么好说的viewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetail"];//预定须知
    self.viewServiceInfo.frame = CGRectMake(0, 150, SCREENWIDTH, [self.viewServiceInfo fetchViewHight]);
    
    self.viewServiceDetail.frame = CGRectMake(0, self.viewServiceInfo.ctBottom, SCREENWIDTH, [self.viewServiceDetail fetchViewHeight]);
    
    self.viewServiceOrder.frame = CGRectMake(0, self.viewServiceDetail.ctBottom, SCREENWIDTH, [self.viewServiceDetail fetchViewHeight]);
    self.scrollDetail.contentSize = CGSizeMake(0, self.viewServiceOrder.ctBottom);
}

- (void)requestData {
    for (int i = 0; i < 5; i ++) {
        WebImageView *image = [[WebImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, 150)];
        image.imageUrl = @"http://hiphotos.baidu.com/lvpics/pic/item/3812b31bb051f819dbde9882dab44aed2f73e77b.jpg";
        [self.scrollImg addSubview:image];
    }
    [self reDrawScrollView];
}


#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //
}

- (void)didTouristServiceDetailInfoDisplayChanged:(TouristServiceDetailView *)detailView status:(BOOL)status{
    detailView.isShow = status;
    [self reDrawScrollView];
}

@end
