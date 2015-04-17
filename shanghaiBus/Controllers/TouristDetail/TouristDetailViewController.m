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
#import "TouristMessageViewController.h"

#import "WebImageView.h"
#import "TouristServiceInfoView.h"
#import "TouristServiceDetailView.h"
#import "TouristCommentView.h"
#import "TouristContectView.h"
#import "CommentObject.h"
#import "MessageObject.h"
#import "TouristHeaderView.h"
#import "CWStarRateView.h"
#import "Config.h"

@interface TouristDetailViewController () <UIScrollViewDelegate, TouristServiceDetailViewDelegate, TouristCommentViewDelegate, TouristContectViewDelegate>

@property (nonatomic, strong) NSMutableArray *arraySiteLine;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) TouristHeaderView *viewHeaderInfo;//头信息

@property (nonatomic, strong) UIScrollView *scrollImg;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *imageIndecator;//图片滑动指示

@property (nonatomic, strong) UIScrollView *scrollDetail;

@property (nonatomic, strong) TouristServiceInfoView *viewServiceInfo;
@property (nonatomic, strong) TouristServiceDetailView *viewServicePrice;//价格说明

@property (nonatomic, strong) TouristServiceDetailView *viewServiceOrder;//预订须知
@property (nonatomic, strong) TouristServiceDetailView *viewServiceDetail;//服务的详细说明

@property (nonatomic, strong) TouristCommentView *viewComment;//评论
@property (nonatomic, strong) TouristCommentView *viewMessage;//留言

@property (nonatomic, strong) TouristContectView *viewcontect;

@property (nonatomic, strong) CWStarRateView *starRateView;

//data
@property (nonatomic, strong) NSMutableArray *arrayMessage;
@property (nonatomic, strong) NSMutableArray *arrayComment;



@end

@implementation TouristDetailViewController

#pragma mark - getter&&setter Methods
- (TouristHeaderView *)viewHeaderInfo {
    if (_viewHeaderInfo == nil) {
        _viewHeaderInfo = [[TouristHeaderView alloc] init];
        _viewHeaderInfo.backgroundColor = [UIColor whiteColor];
    }
    return _viewHeaderInfo;
}

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

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

- (UIImageView *)imageIndecator {
    if (_imageIndecator == nil) {
        _imageIndecator = [[WebImageView alloc] init];
        _imageIndecator.image = [UIImage imageNamed:@"icon"];
        _imageIndecator.clipsToBounds = YES;
        _imageIndecator.userInteractionEnabled = YES;
    }
    return _imageIndecator;
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
        _viewComment.viewtype = VIEWTYPECOMMENT;
        _viewComment.clipsToBounds = YES;
    }
    return _viewComment;
}

- (TouristCommentView *)viewMessage {
    if (_viewMessage == nil) {
        _viewMessage = [[TouristCommentView alloc] init];
        _viewMessage.backgroundColor = [UIColor whiteColor];
        _viewMessage.delegate = self;
        _viewMessage.viewtype = VIEWTYPEMESSAGE;
        _viewMessage.clipsToBounds = YES;
    }
    return _viewMessage;
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
    NSString *title = @"";
    if (self.tourist.nuckname.length > 6) {
        title = [NSString stringWithFormat:@"%@...", [self.tourist.nuckname substringToIndex:6]];
    } else {
        title = self.tourist.nuckname;
    }
    [self setTitle:title];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    UIBarButtonItem *rightMessage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_message"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
//    rightMessage.imageInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
//    UIBarButtonItem *rightShare = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_share"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
    
//    UIButton *buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
//    [buttonMessage setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
//    buttonMessage.frame = CGRectMake(20, 10, 23, 23);
    
    UIButton *buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonShare setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    buttonShare.frame = CGRectMake(10, 0, 44, 44);
    
    UIView *viewAction = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [viewAction addSubview:buttonMessage];
    
    [viewAction addSubview:buttonShare];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:viewAction];
    
//    self.navigationItem.rightBarButtonItems = @[rightShare,rightMessage];
    [self initUI];
    [self requestData];
}

#pragma mark - private Methods
- (void)initUI {
    self.view.backgroundColor = BYBackColor;
    self.scrollDetail.backgroundColor = BYBackColor;
    self.scrollDetail.frame = self.view.bounds;
    self.scrollImg = [[UIScrollView alloc] init];
    self.scrollImg.contentSize = CGSizeMake(SCREENWIDTH, 150);
    self.scrollImg.delegate = self;
    self.scrollImg.tag = 101;
    self.scrollImg.pagingEnabled = YES;
    self.pageControl.frame = CGRectMake(0, 120, 100, 30);
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    [self.scrollImg addSubview:self.pageControl];
    [self.scrollDetail addSubview:self.viewHeaderInfo];
    [self.scrollDetail addSubview:self.scrollImg];
    [self.scrollDetail addSubview:self.viewServiceInfo];
    [self.scrollDetail addSubview:self.viewServicePrice];
    [self.scrollDetail addSubview:self.viewServiceOrder];
    [self.scrollDetail addSubview:self.viewServiceDetail];
    [self.scrollDetail addSubview:self.viewComment];
    [self.scrollDetail addSubview:self.viewMessage];
    [self.view addSubview:self.viewcontect];
    [self reDrawScrollView];
}

- (void)initData {
    
    self.arraySiteLine = [NSMutableArray array];
    self.arrayComment = [NSMutableArray array];
    self.arrayMessage = [NSMutableArray array];
    
}

- (void)reDrawScrollView {
    
    [self.viewServiceInfo configViewWithData:self.tourist];
    [self.viewHeaderInfo configViewWithData:self.tourist];
    
    NSArray *arrayImage = [self.tourist.images componentsSeparatedByString:@"|"];
    NSInteger imageNumber = 1;
    if (arrayImage > 0 ) {
        imageNumber = arrayImage.count;
    }
    self.viewHeaderInfo.frame = CGRectMake(0, 0, SCREENWIDTH, 55);
    self.scrollImg.frame = CGRectMake(0, self.viewHeaderInfo.ctBottom, SCREENWIDTH, 150);
    self.scrollImg.contentSize = CGSizeMake(SCREENWIDTH * imageNumber, 150);
    [self setTouristImage];//加载导游图片
    
    [self.viewServicePrice configViewWithTitle:@"价格说明" detail:self.tourist.pricedetail];//价格说明
    [self.viewServiceOrder configViewWithTitle:@"预定须知" detail:self.tourist.servicedetail];//预定须知
    [self.viewServiceDetail configViewWithTitle:@"服务描述" detail:self.tourist.servicedetail];//服务描述
    
    self.viewServiceInfo.frame = CGRectMake(0, self.scrollImg.ctBottom, SCREENWIDTH, [self.viewServiceInfo fetchViewHight]);
    self.viewServicePrice.frame = CGRectMake(0, self.viewServiceInfo.ctBottom + 10, SCREENWIDTH, [self.viewServicePrice fetchViewHeight]);
    self.viewServiceOrder.frame = CGRectMake(0, self.viewServicePrice.ctBottom + 10, SCREENWIDTH, [self.viewServiceOrder fetchViewHeight]);
    self.viewServiceDetail.frame = CGRectMake(0, self.viewServiceOrder.ctBottom + 10, SCREENWIDTH, [self.viewServiceDetail fetchViewHeight]);
    self.viewComment.frame = CGRectMake(0, self.viewServiceDetail.ctBottom + 10, SCREENHEIGHT, [self.viewComment fetchViewHeight]);
    self.viewMessage.frame = CGRectMake(0, self.viewComment.ctBottom + 10, SCREENHEIGHT, [self.viewMessage fetchViewHeight]);
    self.scrollDetail.contentSize = CGSizeMake(0, self.viewMessage.ctBottom + 50);
    self.viewcontect.frame = CGRectMake(0, self.scrollDetail.ctBottom - 50, SCREENWIDTH, 50);
}

- (void)setTouristImage {
    [self.scrollImg removeAllSubView];
    NSArray *arrayImage = [self.tourist.images componentsSeparatedByString:@"|"];
    for (int i = 0; i < arrayImage.count ; i ++) {
        WebImageView *image = [[WebImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, 150)];
        image.backgroundColor = [UIColor greenColor];
        image.image = [UIImage imageNamed:@"icon"];
        image.imageUrl = [arrayImage objectAtIndex:i];
        [self.scrollImg addSubview:image];
        self.pageControl.numberOfPages = 5;
        
        
    }
    if (arrayImage.count == 0) {
        WebImageView *image = [[WebImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150)];
        image.image = [UIImage imageNamed:@"icon"];
        [self.scrollImg addSubview:image];
    }
}

- (void)reloadData {
//刷新出评论
    if (self.arrayComment.count > 0) {
        [self.viewComment configViewWithData:[self.arrayComment objectAtIndex:0] WithNumber:self.tourist.commentnumber];
    }
//刷新出留言
    if (self.arrayMessage.count > 0) {
        [self.viewMessage configViewWithMessage:[self.arrayMessage objectAtIndex:0] WithNumber:self.tourist.commentnumber];
    }
    
    if (self.arrayMessage.count > 0) {
        //刷新留言
    }
    [self reDrawScrollView];
}

- (void)requestData {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = self.tourist.identify;
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@tourist/getCommentByUserId",HOST];
    NSDictionary *dic = @{@"date":currentTime,@"userid":userid,@"sign":sign};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *commentArray = [dic objectForKey:@"commentArray"];
            if (commentArray.count > 0) {
                [self.arraySiteLine removeAllObjects];
                for (NSDictionary *dic in commentArray) {
                    CommentObject *comment = [[CommentObject alloc] init];
                    [comment configCommentWithDic:dic];
                    [self.arrayComment addObject:comment];
                }
            }
            NSArray *messageArray = [dic objectForKey:@"messageArray"];
            if (messageArray.count > 0) {
                [self.arraySiteLine removeAllObjects];
                for (NSDictionary *dic in messageArray) {
                    MessageObject *message = [[MessageObject alloc] init];
                    [message configCommentWithDic:dic];
                    [self.arrayMessage addObject:message];
                }
            }
            [self reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


#pragma mark - UISearchBarDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 101) {
        CGPoint point = scrollView.contentOffset;
        self.pageControl.currentPage = point.x / SCREENWIDTH;
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            self.viewcontect.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 101) {
        CGPoint point = scrollView.contentOffset;
        self.pageControl.currentPage = point.x / SCREENWIDTH;
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            self.viewcontect.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }

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
    controller.arrayComment = self.arrayComment;
    controller.tourist = self.tourist;
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}

- (void)didClickMessage {
    TouristMessageViewController *controller = [[TouristMessageViewController alloc] init];
    controller.tourist = self.tourist;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didClickPhone {
    NSURL *url = [NSURL URLWithString:@"telprompt://13916241357"];//这个方法可能会被拒
    [[UIApplication sharedApplication] openURL:url];
}

@end
