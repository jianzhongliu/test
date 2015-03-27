//
//  TouristCommentListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/27.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristCommentListViewController.h"

#import "TouristCommentListCell.h"
#import "Config.h"

@interface TouristCommentListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayComment;

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initData {
    self.arrayComment = [NSMutableArray array];
}

- (void)initUI {
    self.view.backgroundColor = BYColorAlphaMake(77, 77, 77, 1);

    UILabel *labelCommentNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 40)];
    labelCommentNumber.font = [UIFont systemFontOfSize:18];
    labelCommentNumber.text = @"100条评论";
    labelCommentNumber.textColor = [UIColor whiteColor];
    [self.view addSubview:labelCommentNumber];
    
    UIButton *buttonAddComment = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAddComment.frame = CGRectMake(SCREENWIDTH - 100, 50, 80, 40);
    [buttonAddComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonAddComment setTitle:@"写点评" forState:UIControlStateNormal];
    [buttonAddComment addTarget:self action:@selector(didClickAddComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAddComment];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 99, SCREENWIDTH, 1)];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewLine];
    
    self.tableView.frame = CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT - 100 - 60);
    [self.view addSubview:self.tableView];
    
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.ctBottom, SCREENWIDTH, 60)];
    viewFooter.backgroundColor = BYColorAlphaMake(104, 110, 114, 1);
    [self.view addSubview:viewFooter];
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake((SCREENWIDTH - 40) / 2, self.tableView.ctBottom + 10, 40, 40);
    [buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonCancel setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [buttonCancel addTarget:self action:@selector(didClickDismissPage) forControlEvents:UIControlEventTouchUpInside];
//    [buttonCancel setTitle:@"写点评" forState:UIControlStateNormal];
    [self.view addSubview:buttonCancel];
}

#pragma mark - privateMethods
- (void)didClickDismissPage {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TouristCommentListCell *cell = [[TouristCommentListCell alloc] init];
    return [cell fetchCellHightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    TouristCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 10000);
    if (cell == nil) {
        cell = [[TouristCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell configCellWithData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
