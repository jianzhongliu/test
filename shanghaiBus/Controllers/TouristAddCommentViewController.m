//
//  TouristAddCommentViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristAddCommentViewController.h"
#import "CWStarRateView.h"

@interface TouristAddCommentViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textCotent;
@property (nonatomic, strong) UILabel *labelContect;
@property (nonatomic, strong) UILabel *labelPlaceHolder;

@property (nonatomic, strong) CWStarRateView *starRateView;

@end

@implementation TouristAddCommentViewController

- (UITextView *)textCotent {
    if (_textCotent == nil) {
        _textCotent = [[UITextView alloc] init];
        _textCotent.textColor = [UIColor whiteColor];
        _textCotent.backgroundColor = [UIColor clearColor];
        _textCotent.delegate = self;
    }
    return _textCotent;
}

- (UILabel *)labelContect {
    if (_labelContect == nil) {
        _labelContect = [[UILabel alloc] init];
        _labelContect.numberOfLines = 0;
        _labelContect.lineBreakMode = NSLineBreakByCharWrapping;
        _labelContect.textColor = [UIColor whiteColor];
        _labelContect.font = [UIFont systemFontOfSize:13];
    }
    return _labelContect;
}

- (UILabel *)labelPlaceHolder {
    if (_labelPlaceHolder == nil) {
        _labelPlaceHolder = [[UILabel alloc] init];
        _labelPlaceHolder.numberOfLines = 0;
        _labelPlaceHolder.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPlaceHolder.textColor = [UIColor whiteColor];
        _labelPlaceHolder.font = [UIFont systemFontOfSize:13];
    }
    return _labelPlaceHolder;
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
    [UIView animateWithDuration:0.9 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initData {
    
}

- (void)initUI {
    self.view.backgroundColor = BYColorFromHex(0x4c4c4c);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENWIDTH - 60, 50, 50, 40);
    [button addTarget:self action:@selector(didclickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, button.ctBottom + 20, SCREENWIDTH, 1)];
    viewLine.backgroundColor = BYColorFromHex(0xcccccc);
    [self.view addSubview:viewLine];
    
    UILabel *labelScore = [[UILabel alloc] initWithFrame:CGRectMake(10, viewLine.ctBottom + 15, SCREENWIDTH - 20, 20)];
    labelScore.font = [UIFont systemFontOfSize:14];
    labelScore.textColor = [UIColor whiteColor];
    labelScore.text = @"总体评分";
    labelScore.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelScore];
    
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 180)/2, labelScore.ctBottom + 15, 180, 40) numberOfStars:5];
    self.starRateView.scorePercent = 1;
    self.starRateView.enable = YES;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    self.starRateView.scorePercent = 0.8;
    [self.view addSubview:self.starRateView];
    

    
    self.textCotent.frame = CGRectMake(10, self.starRateView.ctBottom + 20, SCREENWIDTH - 20, 120);
    self.textCotent.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textCotent.layer.cornerRadius = 3;
    self.textCotent.layer.borderWidth = 1;
    [self.view addSubview:self.textCotent];
    
    self.labelPlaceHolder.frame = CGRectMake(23, self.textCotent.ctTop + 10, 200, 20);
    self.labelPlaceHolder.text = @"请输入评价内容，最多200个字...";
    [self.view addSubview:self.labelPlaceHolder];
    
    
    UIImageView *viewFooter = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.ctBottom - 60, SCREENWIDTH, 60)];
    //    viewFooter.backgroundColor = BYColorAlphaMake(104, 110, 114, 1);
    viewFooter.image = [UIImage imageNamed:@"icon_close_back"];
    viewFooter.userInteractionEnabled = YES;
    [self.view addSubview:viewFooter];
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake(0 , 0, SCREENWIDTH, 60);
    [buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonCancel setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [buttonCancel addTarget:self action:@selector(didClickDismissPage) forControlEvents:UIControlEventTouchUpInside];
    //    [buttonCancel setTitle:@"写点评" forState:UIControlStateNormal];
    [viewFooter addSubview:buttonCancel];
    
    //回复评论，不能能打分
    if (self.commentReply != nil) {
        labelScore.hidden = YES;
        self.starRateView.hidden = YES;
    }
}

- (void)requestDate {
    [self.textCotent resignFirstResponder];
    
    if (self.textCotent.text.length == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"评论不能为空";
        hud.yOffset = 185;
        [hud hide:YES afterDelay:2];
        return;
    }
    
    if (self.textCotent.text.length > 200) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"评论内容不能超过200字";
        hud.yOffset = 185;
        [hud hide:YES afterDelay:2];
        return;
    }
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = self.tourist.identify;
    NSString *score = [NSString stringWithFormat:@"%.0f",self.starRateView.scorePercent * 5];
    NSString *contrnt = [self.textCotent.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@tourist/addComment",HOST];
    NSDictionary *dic = @{@"identify":currentTime,@"commentdate":currentTime,@"userid":userid,@"touristid":self.tourist.identify,@"content":contrnt,@"score":score,@"sign":sign};
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"status"] integerValue] == 1) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        [self hideLoadWithAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
    }];

}

- (void)replyComment {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = [[[UserCachBean share] touristInfo] identify];
    NSString *content = [self.textCotent.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@tourist/replyComment",HOST];
    
    NSDictionary *dic = @{@"identify":self.commentReply.identity,@"replydate":currentTime,@"userid":self.commentReply.userId,@"touristid":self.commentReply.touristId, @"replycontent":content,@"sign":sign};

    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([[dic objectForKey:@"status"] integerValue] == 1) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        [self hideLoadWithAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
    }];
}

#pragma mark - UITextViewDelegate && UITextFieldViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.labelPlaceHolder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

#pragma mark - private Methods
- (void)didclickSubmit {
    if (self.commentReply == nil) {
        [self requestDate];
    } else {
        [self replyComment];
    }
}

- (void)didTapView {
    [self.view endEditing:YES];
    if (self.textCotent.text.length < 1) {
        self.labelPlaceHolder.hidden = NO;
    }
}

- (void)didClickDismissPage {
    [UIView animateWithDuration:0.1 animations:^{
        self.view.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}
@end
