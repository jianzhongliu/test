//
//  TouristMessageViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/27.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "TouristMessageViewController.h"
#import "TouristAddCommentViewController.h"

@interface TouristMessageViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextView *textCotent;
@property (nonatomic, strong) UITextField *textPhone;
@property (nonatomic, strong) UILabel *labelContect;
@property (nonatomic, strong) UILabel *labelPlaceHolder;

@end

@implementation TouristMessageViewController

- (UITextView *)textCotent {
    if (_textCotent == nil) {
        _textCotent = [[UITextView alloc] init];
        _textCotent.textColor = [UIColor whiteColor];
        _textCotent.backgroundColor = [UIColor clearColor];
        _textCotent.delegate = self;
    }
    return _textCotent;
}

- (UITextField *)textPhone {
    if (_textPhone == nil) {
        _textPhone = [[UITextField alloc] init];
        _textPhone.textColor = [UIColor whiteColor];
        _textPhone.font = [UIFont systemFontOfSize:13];
    }
    return _textPhone;
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initData {
    
}

- (void)initUI {
    self.view.backgroundColor = BYColorAlphaMake(77, 77, 77, 1);

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENWIDTH - 60, 30, 45, 40);
    [button addTarget:self action:@selector(didclickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, 1)];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewLine];
    
    self.labelPlaceHolder.frame = CGRectMake(13, 85, 200, 20);
    self.labelPlaceHolder.text = @"请输入留言内容，最多500个字...";
    [self.view addSubview:self.labelPlaceHolder];
    
    self.textCotent.frame = CGRectMake(10, 85, SCREENWIDTH - 20, 140);
    [self.view addSubview:self.textCotent];
    
    UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.textCotent.ctBottom + 1, SCREENWIDTH, 1)];
    viewLine2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewLine2];
    
    UILabel *labelTagPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, self.textCotent.ctBottom +10, 80, 25)];
    labelTagPhone.text = @"联系方式";
    labelTagPhone.textColor = [UIColor whiteColor];
    labelTagPhone.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labelTagPhone];
    
    self.textPhone.frame = CGRectMake(95, self.textCotent.ctBottom + 10, SCREENWIDTH - 110, 25);
    self.textPhone.placeholder = @"仅商家可见";
    [self.view addSubview:self.textPhone];
    
    self.labelContect.frame = CGRectMake(10, self.textPhone.ctBottom + 5, SCREENWIDTH - 20, 20);
    self.labelContect.text = @"选填，可留QQ、微信、手机";
    [self.view addSubview:self.labelContect];
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake((SCREENWIDTH - 40) / 2, self.view.ctBottom - 60, 42, 42);
    [buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonCancel setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [buttonCancel addTarget:self action:@selector(didClickDismissPage) forControlEvents:UIControlEventTouchUpInside];
    //    [buttonCancel setTitle:@"写点评" forState:UIControlStateNormal];
    [self.view addSubview:buttonCancel];

}

#pragma mark - UITextViewDelegate && UITextFieldViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.labelPlaceHolder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {

}

#pragma mark - private Methods
- (void)didclickSubmit {
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *userid = self.tourist.identify;
    NSString *content = [self.textCotent.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, userid];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@tourist/addMessage",HOST];
    NSDictionary *dic = @{@"identify":currentTime,@"commentdate":currentTime,@"userid":userid,@"touristid":self.tourist.identify,@"content":content,@"phonenumber":self.textPhone.text ,@"sign":sign};
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
        [self showInfo:operation.responseString ];
    }];
}

- (void)didTapView {
    [self.view endEditing:YES];
    if (self.textCotent.text.length < 1) {
        self.labelPlaceHolder.hidden = NO;
    }
}

- (void)didClickDismissPage {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
