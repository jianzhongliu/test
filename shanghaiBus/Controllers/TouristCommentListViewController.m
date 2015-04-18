//
//  TouristCommentListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/27.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristCommentListViewController.h"
#import "TouristAddCommentViewController.h"
#import "TouristCommentListCell.h"
#import "Config.h"

@interface TouristCommentListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TouristCommentListViewController
#pragma mark - lifecycleMethods
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = BYColorAlphaMake(77, 77, 77, 1);
    }
    return _tableView;
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
    self.view.alpha = 0.2;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.9 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)initData {
    self.arrayComment = [NSMutableArray array];
}

- (void)initUI {
    self.view.backgroundColor = BYColorFromHex(0x4c4c4c);

    UILabel *labelCommentNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 40)];
    labelCommentNumber.font = [UIFont systemFontOfSize:16];
    NSString *stringComment = [NSString stringWithFormat:@"%ld条点评", (long)self.tourist.commentnumber];
    labelCommentNumber.text = stringComment;
    labelCommentNumber.textColor = [UIColor whiteColor];
    [self.view addSubview:labelCommentNumber];
    
    UIButton *buttonAddComment = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAddComment.frame = CGRectMake(SCREENWIDTH - 60, 50, 50, 40);
    [buttonAddComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonAddComment setTitle:@"写点评" forState:UIControlStateNormal];
    [buttonAddComment addTarget:self action:@selector(didClickAddComment) forControlEvents:UIControlEventTouchUpInside];
    
    buttonAddComment.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:buttonAddComment];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, buttonAddComment.ctBottom + 20, SCREENWIDTH, 1)];
    viewLine.backgroundColor = BYColorFromHex(0xcccccc);
    [self.view addSubview:viewLine];
    
    self.tableView.frame = CGRectMake(0, viewLine.ctBottom + 1, SCREENWIDTH, SCREENHEIGHT - viewLine.ctTop - 60);
    [self.view addSubview:self.tableView];
    
    UIImageView *imageHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewLine.ctBottom, SCREENWIDTH, 10)];
    imageHeader.image = [UIImage imageNamed:@"con_header_line"];
    [self.view addSubview:imageHeader];
    
    UIImageView *viewFooter = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.tableView.ctBottom, SCREENWIDTH, 60)];
//    viewFooter.backgroundColor = BYColorAlphaMake(104, 110, 114, 1);
    viewFooter.image = [UIImage imageNamed:@"icon_close_back"];
    viewFooter.userInteractionEnabled = YES;
    [self.view addSubview:viewFooter];
    
    UIImageView *imageFooter = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewFooter.ctTop - 10, SCREENWIDTH, 10)];
    imageFooter.image = [UIImage imageNamed:@"icon_footer_line"];
    [self.view addSubview:imageFooter];
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake(0 , self.tableView.ctBottom + 10, SCREENWIDTH, 42);
    [buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonCancel setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [buttonCancel addTarget:self action:@selector(didClickDismissPage) forControlEvents:UIControlEventTouchUpInside];
//    [buttonCancel setTitle:@"写点评" forState:UIControlStateNormal];
    [self.view addSubview:buttonCancel];
}

#pragma mark - privateMethods
- (void)didClickDismissPage {
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

- (void)didClickAddComment {
    TouristAddCommentViewController *controller = [[TouristAddCommentViewController alloc] init];
    controller.tourist = self.tourist;
    [self presentViewController:controller animated:NO completion:nil];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayComment.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TouristCommentListCell *cell = [[TouristCommentListCell alloc] init];
    
    return [cell fetchCellHightWithData:[self.arrayComment objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    TouristCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 10000);
    if (cell == nil) {
        cell = [[TouristCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell configCellWithComment:[self.arrayComment objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
