//
//  BusStationListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/21.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristDetailViewController.h"
#import "TouristListViewController.h"
#import "TouristCommentListViewController.h"

#import "WebImageView.h"
#import "TouristServiceInfoView.h"
#import "TouristServiceDetailView.h"
#import "TouristCommentView.h"
#import "TouristContectView.h"

@interface TouristDetailViewController () <UIScrollViewDelegate, TouristServiceDetailViewDelegate, TouristCommentViewDelegate, TouristContectViewDelegate>

@property (nonatomic, strong) NSMutableArray *arraySiteLine;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UIScrollView *scrollImg;

@property (nonatomic, strong) UIScrollView *scrollDetail;
@property (nonatomic, strong) TouristServiceInfoView *viewServiceInfo;
@property (nonatomic, strong) TouristServiceDetailView *viewServicePrice;//价格说明

@property (nonatomic, strong) TouristServiceDetailView *viewServiceOrder;//预订须知
@property (nonatomic, strong) TouristServiceDetailView *viewServiceDetail;//服务的详细说明

@property (nonatomic, strong) TouristCommentView *viewComment;

@property (nonatomic, strong) TouristContectView *viewcontect;

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
        _scrollDetail.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_scrollDetail];
    }
    return  _scrollDetail;
}

- (TouristServiceDetailView *)viewServicePrice {
    if (_viewServicePrice == nil) {
        _viewServicePrice = [[TouristServiceDetailView alloc] init];
        _viewServicePrice.backgroundColor = [UIColor whiteColor];
        _viewServicePrice.delegate = self;
        _viewServicePrice.clipsToBounds = YES;
    }
    return _viewServicePrice;
}

- (TouristServiceDetailView *)viewServiceOrder {
    if (_viewServiceOrder == nil) {
        _viewServiceOrder = [[TouristServiceDetailView alloc] init];
        _viewServiceOrder.backgroundColor = [UIColor whiteColor];
        _viewServiceOrder.delegate = self;
        _viewServiceOrder.clipsToBounds = YES;
    }
    return _viewServiceOrder;
}

- (TouristServiceDetailView *)viewServiceDetail {
    if (_viewServiceDetail == nil) {
        _viewServiceDetail = [[TouristServiceDetailView alloc] init];
        _viewServiceDetail.backgroundColor = [UIColor whiteColor];
        _viewServiceDetail.delegate = self;
        _viewServiceDetail.clipsToBounds = YES;
    }
    return _viewServiceDetail;
}

- (TouristCommentView *)viewComment {
    if (_viewComment == nil) {
        _viewComment = [[TouristCommentView alloc] init];
        _viewComment.backgroundColor = [UIColor whiteColor];
        _viewComment.delegate = self;
        _viewComment.clipsToBounds = YES;
    }
    return _viewComment;
}

- (TouristContectView *)viewcontect {
    if (_viewcontect == nil) {
        _viewcontect = [[TouristContectView alloc] init];
        _viewcontect.backgroundColor = [UIColor whiteColor];
        _viewcontect.delegate = self;
        _viewcontect.clipsToBounds = YES;
    }
    return _viewcontect;
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
    [self.scrollDetail addSubview:self.viewServiceInfo];
    [self.scrollDetail addSubview:self.viewServicePrice];
    [self.scrollDetail addSubview:self.viewServiceOrder];
    [self.scrollDetail addSubview:self.viewServiceDetail];
    [self.scrollDetail addSubview:self.viewComment];
    [self.view addSubview:self.viewcontect];
}

- (void)initData {
    
    self.arraySiteLine = [NSMutableArray array];
    
}

- (void)reDrawScrollView {
    [self.viewServiceInfo configViewWithData:nil];
    [self.viewServicePrice configViewWithTitle:@"价格说明" detail:@"没什么好描述的iewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetail"];//价格说明
    [self.viewServiceOrder configViewWithTitle:@"预定须知" detail:@"没什么好说的viewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetail"];//预定须知
    
    [self.viewServiceDetail configViewWithTitle:@"服务描述" detail:@"没什么好说的viewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetailviewServiceDetail"];//服务描述
    [self.viewComment configViewWithData:nil];
    self.viewServiceInfo.frame = CGRectMake(0, 150, SCREENWIDTH, [self.viewServiceInfo fetchViewHight]);
    
    self.viewServicePrice.frame = CGRectMake(0, self.viewServiceInfo.ctBottom, SCREENWIDTH, [self.viewServicePrice fetchViewHeight]);
    
    self.viewServiceOrder.frame = CGRectMake(0, self.viewServicePrice.ctBottom, SCREENWIDTH, [self.viewServiceOrder fetchViewHeight]);
    
    self.viewServiceDetail.frame = CGRectMake(0, self.viewServiceOrder.ctBottom, SCREENWIDTH, [self.viewServiceDetail fetchViewHeight]);
    
    self.viewComment.frame = CGRectMake(0, self.viewServiceDetail.ctBottom, SCREENHEIGHT, [self.viewComment fetchViewHeight]);
    
    self.scrollDetail.contentSize = CGSizeMake(0, self.viewComment.ctBottom + 40);
    self.viewcontect.frame = CGRectMake(0, self.scrollDetail.ctBottom - 40, SCREENWIDTH, 40);
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 animations:^{
        self.viewcontect.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 animations:^{
        self.viewcontect.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

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

- (void)didTouristServiceCommentInfoDisplayChanged:(TouristCommentView*) detailView status:(BOOL) status {
    [self reDrawScrollView];
}

- (void)didTouristServiceDetailClick:(TouristObject *) tourist {
//取评论详情列表
    TouristCommentListViewController *controller = [[TouristCommentListViewController alloc] init];
    [self presentViewController:controller animated:YES completion:^{
        
    }];
    
}

- (void)didClickMessage {

}

- (void)didClickPhone {

}
@end
