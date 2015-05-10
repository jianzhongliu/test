//
//  AuthenticatedInfoViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/5/3.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "AuthenticatedInfoViewController.h"
#import "CommonInputView.h"
#import "WebImageView.h"
#import <SMS_SDK/SMS_SDK.h>

@interface AuthenticatedInfoViewController ()
{
    long caculateTime;
}
@property (nonatomic, strong) UIScrollView *scrollViewBG;
@property (nonatomic, strong) CommonInputView *viewName;
@property (nonatomic, strong) CommonInputView *viewIdentify;
@property (nonatomic, strong) CommonInputView *viewPhone;
@property (nonatomic, strong) CommonInputView *viewCode;
@property (nonatomic, strong) UIButton *buttonCheckcode;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *labelPicture;
@property (nonatomic, strong) UIView *viewPicktureBG;
@property (nonatomic, strong) WebImageView *imageViewPicture;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIButton *buttonAddPicture;

@end

@implementation AuthenticatedInfoViewController

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
    caculateTime = 60;
}

- (void)initUI {
    [self setTitle:@"实名验证"];
    
    [self setRightButtonWithTitle:@"下一步"];
    
    self.scrollViewBG.frame = self.view.bounds;
    [self.view addSubview:self.scrollViewBG];
    
    self.viewName.frame= CGRectMake(0, 10, SCREENWIDTH, 44);
    [self.viewName configViewWithData:nil];
    [self.scrollViewBG addSubview:self.viewName];
    
    self.viewIdentify.frame = CGRectMake(0, self.viewName.ctBottom + 10, SCREENWIDTH, 44);
    [self.viewIdentify configViewWithData:nil];
    [self.scrollViewBG addSubview:self.viewIdentify];
    
    self.viewPhone.frame = CGRectMake(0, self.viewIdentify.ctBottom, SCREENWIDTH, 44);
    [self.viewPhone configViewWithData:nil];
    [self.scrollViewBG addSubview:self.viewPhone];
    
    self.viewCode.frame = CGRectMake(0, self.viewPhone.ctBottom, SCREENWIDTH, 44);
    [self.viewCode configViewWithData:nil];
    [self.scrollViewBG addSubview:self.viewCode];

    self.buttonCheckcode.frame = CGRectMake(SCREENWIDTH - 90, self.viewCode.ctTop + 5, 70, 35);
    [self.scrollViewBG addSubview:self.buttonCheckcode];
    
    self.labelPicture.frame = CGRectMake(10, self.viewCode.ctBottom + 10, 100, 25);
    [self.scrollViewBG addSubview:self.labelPicture];
    
    self.viewPicktureBG.frame = CGRectMake(0, self.labelPicture.ctBottom + 3, SCREENWIDTH, 200);
    [self.scrollViewBG addSubview:self.viewPicktureBG];
    
    self.imageViewPicture.frame = CGRectMake((SCREENWIDTH - 100) / 2, (self.viewPicktureBG.viewHeight - 100) / 2, 100, 100);
    
    [self.viewPicktureBG addSubview:self.imageViewPicture];
    
    self.viewLine.frame = CGRectMake(0, self.viewPicktureBG.ctBottom - 1, SCREENWIDTH, 1);
    [self.scrollViewBG addSubview:self.viewLine];
    
    self.buttonAddPicture.frame = CGRectMake(0, self.viewPicktureBG.ctBottom , SCREENWIDTH, 45);
    [self.scrollViewBG addSubview:self.buttonAddPicture];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(didTapBackGround)];
    [self.scrollViewBG addGestureRecognizer:tap];

}

#pragma  mark - Action Methods
- (void)didTapBackGround {
    [self.view endEditing:YES];
}

- (void)didRightClick {
    
    [self checkCode];
}

- (void)didAddPicture {

}

- (void)didClickCheckcode:(id) sender {
    if (self.viewPhone.textInput.text.length != 11) {
        [self showInfo:@"电话号码格式不对"];
        return;
    }
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeClock) userInfo:nil repeats:YES];
    }
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.viewPhone.textInput.text
                                          zone:@"86"
                                        result:^(SMS_SDKError *error)
     {
         if (!error)
         {
             
         }
         else
         {
             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                 otherButtonTitles:nil, nil];
             [alert show];
         }
     }];
}

- (void)timeClock {
    NSString *titleCode = @"";
    if (caculateTime > 0) {
        titleCode = [NSString stringWithFormat:@"%ldS", caculateTime];
        self.buttonCheckcode.enabled = NO;
    } else {
        titleCode = @"获取验证码";
        self.buttonCheckcode.enabled = YES;
    }
    caculateTime --;
    [_buttonCheckcode setTitle:titleCode forState:UIControlStateNormal];
    
}

//验证手机验证码
- (void)checkCode {
    [self.view endEditing:YES];
    if (self.viewCode.textInput.text.length != 4){
        [self showInfo:@"验证码格式不正确"];
        return;
    }
    [self showLoadingActivity:YES];
    [SMS_SDK commitVerifyCode:self.viewCode.textInput.text result:^(enum SMS_ResponseState state) {
        if (state == SMS_ResponseStateSuccess) {
//            NSString *phoneNo = self.textName.text;
//            NSString *userName = [NSString stringWithFormat:@"%@*****%@", [phoneNo substringWithRange:NSMakeRange(0, 3)], [phoneNo substringWithRange:NSMakeRange(phoneNo.length - 3, 3)]];
//            NSDictionary *dic = @{@"usid":phoneNo,@"token":phoneNo,@"username":userName,@"icon":phoneNo};
//            [self requestThirdPartLoginWith:dic];
        } else {
            [self hideLoadWithAnimated:YES];
            [self showInfo:@"验证码错误！"];
            
            //失败
        }
    }];

}
#pragma mark - //////////////////////////////////////////////////////////
#pragma mark - //////////////////////////////////////////////////////////
#pragma mark - getter && setter

- (UIScrollView *)scrollViewBG {
    if (_scrollViewBG == nil) {
        _scrollViewBG = [[UIScrollView alloc] init];
        //        _scrollViewBG.delegate = self;
        _scrollViewBG.backgroundColor = BYBackColor;
        _scrollViewBG.pagingEnabled = NO;
        _scrollViewBG.scrollEnabled = YES;
        _scrollViewBG.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    }
    return _scrollViewBG;
}


- (CommonInputView *)viewName {
    if (_viewName == nil) {
        _viewName = [[CommonInputView alloc] init];
        _viewName.backgroundColor = [UIColor whiteColor];
        _viewName.viewType = VIEWTYPENAME;
    }
    return _viewName;
}

- (CommonInputView *)viewIdentify {
    if (_viewIdentify == nil) {
        _viewIdentify = [[CommonInputView alloc] init];
        _viewIdentify.backgroundColor = [UIColor whiteColor];
        _viewIdentify.viewType = VIEWTYPEIDENTIFY;
    }
    return _viewIdentify;
}

- (CommonInputView *)viewPhone {
    if (_viewPhone == nil) {
        _viewPhone = [[CommonInputView alloc] init];
        _viewPhone.backgroundColor = [UIColor whiteColor];
        _viewPhone.textInput.keyboardType = UIKeyboardTypePhonePad;
        _viewPhone.viewType = VIEWTYPEPHONE;
    }
    return _viewPhone;
}

- (CommonInputView *)viewCode {
    if (_viewCode == nil) {
        _viewCode = [[CommonInputView alloc] init];
        _viewCode.backgroundColor = [UIColor whiteColor];
        _viewCode.textInput.keyboardType = UIKeyboardTypeNumberPad;
        _viewCode.viewType = VIEWTYPECODE;
    }
    return _viewCode;
}

- (UIButton *)buttonCheckcode {
    if (_buttonCheckcode == nil) {
        _buttonCheckcode = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCheckcode setBackgroundColor:BYColor];
        //        [_buttonCheckcode setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        //        [_buttonCheckcode setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonCheckcode addTarget:self action:@selector(didClickCheckcode:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonCheckcode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _buttonCheckcode.titleLabel.font = [UIFont systemFontOfSize:12];
        _buttonCheckcode.selected = NO;
    }
    return _buttonCheckcode;
}

- (UILabel *)labelPicture {
    if (_labelPicture == nil) {
        _labelPicture = [[UILabel alloc] init];
        _labelPicture.numberOfLines = 0;
        _labelPicture.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPicture.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelPicture.font = [UIFont systemFontOfSize:13];
        _labelPicture.backgroundColor = [UIColor clearColor];
        _labelPicture.text = @"手持身份证照片";
    }
    return _labelPicture;
}

- (UIView *)viewPicktureBG {
    if (_viewPicktureBG == nil) {
        _viewPicktureBG = [[UIView alloc] init];
        _viewPicktureBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewPicktureBG;
}

- (WebImageView *)imageViewPicture {
    if (_imageViewPicture == nil) {
        _imageViewPicture = [[WebImageView alloc] init];
        _imageViewPicture.image = [UIImage imageNamed:@"icon_picture"];
        _imageViewPicture.clipsToBounds = YES;
        _imageViewPicture.userInteractionEnabled = YES;
    }
    return _imageViewPicture;
}
- (UIView *)viewLine {
    if (_viewLine == nil) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = BYColorAlphaMake(0, 0, 0, 0.1);
    }
    return _viewLine;
}
- (UIButton *)buttonAddPicture {
    if (_buttonAddPicture == nil) {
        _buttonAddPicture = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonAddPicture setImage:[UIImage imageNamed:@"icon_star_hilight"] forState:UIControlStateNormal];
        [_buttonAddPicture setBackgroundColor:[UIColor whiteColor]];
        [_buttonAddPicture addTarget:self action:@selector(didAddPicture) forControlEvents:UIControlEventTouchUpInside];
        [_buttonAddPicture setTitle:@"添加照片" forState:UIControlStateNormal];
//        _buttonAddPicture.selected = NO;
        [_buttonAddPicture setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonAddPicture.titleLabel.font = [UIFont systemFontOfSize:13];
//        _buttonAddPicture.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _buttonAddPicture;
    
}

@end