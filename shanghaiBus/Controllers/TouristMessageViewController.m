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
        _textPhone.borderStyle = UITextBorderStyleNone;
        
        _textPhone.textColor = [UIColor whiteColor];
        _textPhone.font = [UIFont systemFontOfSize:13];
    }
    return _textPhone;
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
    self.view.backgroundColor = BYColorFromHex(0x4c4c4c);

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENWIDTH - 60, 50, 50, 40);
    [button addTarget:self action:@selector(didclickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button];
    
    self.textCotent.frame = CGRectMake(10, button.ctBottom + 20, SCREENWIDTH - 20, 120);
    self.textCotent.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textCotent.layer.cornerRadius = 3;
    self.textCotent.layer.borderWidth = 1;
    [self.view addSubview:self.textCotent];
    
    self.labelPlaceHolder.frame = CGRectMake(23, self.textCotent.ctTop + 10, 200, 20);
    self.labelPlaceHolder.text = @"请输入留言内容，最多500个字...";
    [self.view addSubview:self.labelPlaceHolder];
    
    UILabel *labelTagPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, self.textCotent.ctBottom + 15, 180, 25)];
    labelTagPhone.text = @"联系方式(仅商家可见)";
    labelTagPhone.textColor = [UIColor whiteColor];
    labelTagPhone.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labelTagPhone];
    
    self.textPhone.frame = CGRectMake(10, labelTagPhone.ctBottom + 10, SCREENWIDTH - 20, 35);
    self.textPhone.backgroundColor = self.view.backgroundColor;
    self.textPhone.placeholder = @"   可留QQ/微信/手机";
    [self.textPhone setValue:BYColorFromHex(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    self.textPhone.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textPhone.layer.cornerRadius = 3;
    self.textPhone.layer.borderWidth = 1;
//    [self.textPhone setTintColor:[UIColor greenColor]];
    [self.view addSubview:self.textPhone];
    [self.textPhone drawPlaceholderInRect:CGRectMake(5, 0, self.textPhone.viewWidth, self.textPhone.viewWidth)];
    
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

}

#pragma mark - UITextViewDelegate && UITextFieldViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.labelPlaceHolder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {

}

#pragma mark - private Methods
- (void)didclickSubmit {
    [self.view endEditing:YES];
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
