//
//  MyMessageViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/18.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MessageInfoCell.h"
#import "Config.h"

@interface MyMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *buttonLeft;
@property (nonatomic, strong) UIButton *buttonRight;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayMessage;

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
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self setTitle:@"我的消息"];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.viewX = SCREENWIDTH;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.viewX = 0;
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)initData {

    self.arrayMessage = [NSMutableArray array];

}

- (void)initUI {
    
    self.buttonLeft.frame = CGRectMake(15, 74, (SCREENWIDTH - 30) /2, 30);
    self.buttonRight.frame = CGRectMake(self.buttonLeft.ctRight + 1, 74, (SCREENWIDTH - 30) /2, 30);
    
    [self.view addSubview:self.buttonLeft];
    [self.view addSubview:self.buttonRight];
    
    self.tableView.frame = CGRectMake(0, self.buttonRight.ctBottom + 10 , SCREENWIDTH, SCREENHEIGHT - 55);
    [self.view addSubview:self.tableView];
    
}

#pragma mark - action && privateMethods
- (void)didStatusChange:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:
        {
            self.buttonRight.enabled = YES;
            self.buttonLeft.enabled = NO;
            [self.tableView reloadData];
        }
            break;
        case 102:
        {
            self.buttonLeft.enabled = YES;
            self.buttonRight.enabled = NO;
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    MessageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MessageInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - getter && setter
- (UIButton *)buttonLeft {
    if (_buttonLeft == nil) {
        _buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonLeft addTarget:self action:@selector(didStatusChange:) forControlEvents:UIControlEventTouchUpInside];
        _buttonLeft.selected = NO;
        _buttonLeft.tag = 101;
        _buttonLeft.backgroundColor = BYColor;
        [_buttonLeft setTitle:@"对话消息" forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
        [_buttonRight setTitle:@"系统消息" forState:UIControlStateNormal];
        [_buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buttonRight.titleLabel.font = [UIFont systemFontOfSize:13];
        _buttonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonRight;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
