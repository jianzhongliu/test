//
//  MessageListViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/19.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MessageInfoCell.h"
#import "TouristAddCommentViewController.h"
#import "TouristMessageViewController.h"
#import "Config.h"
#import "UIView+CTExtensions.h"

@interface MyMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIButton *buttonLeft;
@property (nonatomic, strong) UIButton *buttonRight;

@property (nonatomic, strong) UITableView *tableMessage;
@property (nonatomic, strong) NSMutableArray *arrayMessage;
@property (nonatomic, strong) NSMutableArray *arrayCommon;

@property (nonatomic, assign) BOOL isShowMessage;//YES表示显示Message，NO表示显示common

@end

@implementation MyMessageViewController


#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BYBackColor;
    self.tableMessage.backgroundColor = BYBackColor;
    [self initUI];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"一键全读" style:UIBarButtonItemStylePlain target:self action:@selector(didSaveInfo)];
//    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self setTitle:@"消息"];
    
}

- (void)initData {
    
    self.arrayMessage = [NSMutableArray array];
    self.arrayCommon = [NSMutableArray array];
    self.isShowMessage = YES;
}

- (void)initUI {
    self.navigationController.navigationBar.translucent = NO;
    self.buttonLeft.frame = CGRectMake(15, 10, (SCREENWIDTH - 30) /2, 30);
    self.buttonRight.frame = CGRectMake(self.buttonLeft.ctRight + 1, 10, (SCREENWIDTH - 30) /2, 30);
    
    [self.view addSubview:self.buttonLeft];
    [self.view addSubview:self.buttonRight];
    
    self.tableMessage.frame = CGRectMake(0, 50 , SCREENWIDTH, self.view.viewHeight - 158);
    [self.view addSubview:self.tableMessage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[UserCachBean share] isLogin]) {
        [self requestData];
    }
}

#pragma mark - requestData
- (void)requestData {
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = [[[UserCachBean share] touristInfo] identify];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@tourist/getCommentByUserId",HOST];
    NSDictionary *dic = @{@"date":currentTime,@"userid":userid,@"sign":sign};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hideLoadWithAnimated:YES];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"commentArray"] isKindOfClass:[NSDictionary class]]) {
                [self.arrayCommon removeAllObjects];
                CommentObject *comment = [[CommentObject alloc] init];
                [comment configCommentWithDic:[dic objectForKey:@"commentArray"]];
                [self.arrayCommon addObject:comment];
            } else {
                NSArray *commentArray = [dic objectForKey:@"commentArray"];
                
                if (commentArray.count > 0) {
                    [self.arrayCommon removeAllObjects];
                    for (NSDictionary *dic in commentArray) {
                        CommentObject *comment = [[CommentObject alloc] init];
                        [comment configCommentWithDic:dic];
                        [self.arrayCommon addObject:comment];
                    }
                }
            }
            if ([[dic objectForKey:@"messageArray"] isKindOfClass:[NSDictionary class]]) {
                [self.arrayMessage removeAllObjects];
                MessageObject *message = [[MessageObject alloc] init];
                [message configCommentWithDic:[dic objectForKey:@"messageArray"]];
                [self.arrayMessage addObject:message];
            } else {
                NSArray *messageArray = [dic objectForKey:@"messageArray"];
                if (messageArray.count > 0) {
                    [self.arrayMessage removeAllObjects];
                    for (NSDictionary *dic in messageArray) {
                        MessageObject *message = [[MessageObject alloc] init];
                        [message configCommentWithDic:dic];
                        [self.arrayMessage addObject:message];
                    }
                }
            }
            
            [self.tableMessage reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
    }];
}


#pragma mark - action && private Methods
- (void)didDismissMyInfo {
    [self.navigationController popViewControllerAnimated:YES];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSaveInfo {
    
    [self didDismissMyInfo];
}

- (void)didStatusChange:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:
        {
            self.isShowMessage = YES;
            self.buttonRight.enabled = YES;
            self.buttonLeft.enabled = NO;
        }
            break;
        case 102:
        {
            self.isShowMessage = NO;
            self.buttonLeft.enabled = YES;
            self.buttonRight.enabled = NO;
        }
            break;
        default:
            break;
    }
    [self.tableMessage reloadData];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isShowMessage == YES) {
        return self.arrayMessage.count;
    } else {
        return self.arrayCommon.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageInfoCell *cell = [[MessageInfoCell alloc] init];
    CGFloat cellHeight = 0;
    if (self.isShowMessage == YES) {
        [cell configCellWithMessage:[self.arrayMessage objectAtIndex:indexPath.row]];
    } else {
        [cell configCellWithComment:[self.arrayCommon objectAtIndex:indexPath.row]];
    }
    if (self.isShowMessage == YES) {
        cellHeight = [cell fetchCellHightWithData:[self.arrayMessage objectAtIndex:indexPath.row]];
    } else {
        cellHeight = [cell fetchCellHightWithData:[self.arrayCommon objectAtIndex:indexPath.row]];
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    MessageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MessageInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (self.isShowMessage == YES) {
        [cell configCellWithMessage:[self.arrayMessage objectAtIndex:indexPath.row]];
    } else {
        [cell configCellWithComment:[self.arrayCommon objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.isShowMessage == YES) {
//        MessageObject *message = [self.arrayMessage objectAtIndex:indexPath.row];
//        if (message.replycontent.length == 0 ) {
//            TouristMessageViewController *controller = [[TouristMessageViewController alloc] init];
//            controller.message = [self.arrayMessage objectAtIndex:indexPath.row];
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//    } else {
//        CommentObject *comment = [self.arrayCommon objectAtIndex:indexPath.row];
//        if (comment.replycontent.length == 0 ) {
//            TouristAddCommentViewController *controller = [[TouristAddCommentViewController alloc] init];
//            controller.commentReply = [self.arrayCommon objectAtIndex:indexPath.row];
//            [self presentViewController:controller animated:YES completion:nil];
//        }
//    }
    
    
}

#pragma mark - getter && setter
- (UITableView *)tableMessage {
    if (_tableMessage == nil) {
        _tableMessage = [[UITableView alloc] init];
        _tableMessage.delegate = self;
        _tableMessage.dataSource = self;
        _tableMessage.separatorColor = [UIColor clearColor];
        _tableMessage.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableMessage;
}
- (UIButton *)buttonLeft {
    if (_buttonLeft == nil) {
        _buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonLeft addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonLeft.selected = NO;
        _buttonLeft.tag = 101;
        _buttonLeft.backgroundColor = BYColor;
        _buttonLeft.enabled = NO;
        [_buttonLeft setTitle:@"留言消息" forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _buttonLeft.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonLeft;
}

- (UIButton *)buttonRight {
    if (_buttonRight == nil) {
        _buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonRight addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonRight.selected = NO;
        _buttonRight.tag = 102;
        _buttonRight.backgroundColor = BYColor;
        [_buttonRight setTitle:@"评论消息" forState:UIControlStateNormal];
        [_buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonRight setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _buttonRight.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonRight;
}

@end
