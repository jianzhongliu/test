//
//  PhoneLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/29.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "RegisterViewController.h"
#import "SettingPasswordViewController.h"
#import "WebImageView.h"
#import <SMS_SDK/SMS_SDK.h>
#import "TouristObject.h"
#import "UserCachBean.h"

@interface RegisterViewController ()
{
    NSInteger caculateTime;
}
//@property (nonatomic, strong) UIButton *buttonForgetPass;
//@property (nonatomic, strong) UIButton *buttonRegister;

@property (nonatomic, strong) WebImageView *imageView;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelPass;

@property (nonatomic, strong) UITextField *textName;
@property (nonatomic, strong) UITextField *textPass;

@property (nonatomic, strong) UIButton *buttonCheckcode;

@property (nonatomic, strong) UIButton *buttonNextStep;

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation RegisterViewController
#pragma mark - getter&&setter

- (UILabel *)labelName {
    if (_labelName == nil) {
        _labelName = [[UILabel alloc] init];
        _labelName.numberOfLines = 0;
        _labelName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelName.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelName.font = [UIFont systemFontOfSize:13];
    }
    return _labelName;
}

- (UILabel *)labelPass {
    if (_labelPass == nil) {
        _labelPass = [[UILabel alloc] init];
        _labelPass.numberOfLines = 0;
        _labelPass.lineBreakMode = NSLineBreakByCharWrapping;
        _labelPass.textColor = BYColorAlphaMake(0, 0, 0, 0.4);
        _labelPass.font = [UIFont systemFontOfSize:13];
    }
    return _labelPass;
}

- (UITextField *)textName {
    if (_textName == nil) {
        _textName = [[UITextField alloc] init];
        _textName.clearsOnBeginEditing = YES;
        _textName.keyboardType = UIKeyboardTypePhonePad;
        _textName.font = [UIFont systemFontOfSize:13];
        //        _textName.textColor = [UIColor whiteColor];
    }
    return _textName;
}

- (UITextField *)textPass {
    if (_textPass == nil) {
        _textPass = [[UITextField alloc] init];
        _textPass.clearsOnBeginEditing = YES;
        _textPass.keyboardType = UIKeyboardTypeNumberPad;
        _textPass.secureTextEntry = YES;
    }
    return _textPass;
}

- (UIButton *)buttonCheckcode {
    if (_buttonCheckcode == nil) {
        _buttonCheckcode = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCheckcode setBackgroundColor:BYColor];
        //        [_buttonCheckcode setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        //        [_buttonCheckcode setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateSelected];
        [_buttonCheckcode addTarget:self action:@selector(didClickCheckcode:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonCheckcode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_buttonCheckcode setFont:[UIFont systemFontOfSize:12]];
        _buttonCheckcode.selected = NO;
    }
    return _buttonCheckcode;
}

- (WebImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[WebImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon_name_pass"];
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)buttonNextStep {
    if (_buttonNextStep == nil) {
        _buttonNextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNextStep setBackgroundImage:[UIImage imageNamed:@"icon_login_nomal"] forState:UIControlStateNormal];
        [_buttonNextStep addTarget:self action:@selector(didClickNext) forControlEvents:UIControlEventTouchUpInside];
        [_buttonNextStep setTitle:@"登陆" forState:UIControlStateNormal];
        _buttonNextStep.selected = NO;
    }
    return _buttonNextStep;
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
    caculateTime = 60;

}

- (void)initUI {
    
    self.imageView.frame = CGRectMake(10, 80, SCREENWIDTH - 20, 86);
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    self.labelName.frame = CGRectMake(10, 10, 70, 20);
    self.labelName.text = @"用户名：";
    [self.imageView addSubview:self.labelName];
    
    self.textName.frame = CGRectMake(self.labelName.ctRight + 10, 10, SCREENWIDTH - 110, 25);
    self.textName.placeholder = @"手机号码";
    [self.imageView addSubview:self.textName];
    
    self.labelPass.frame = CGRectMake(10, 55, 70, 20);
    self.labelPass.text = @"验证码：";
    [self.imageView addSubview:self.labelPass];
    
    self.textPass.frame = CGRectMake(self.labelPass.ctRight + 10, 55, SCREENWIDTH - 110, 25);
    [self.imageView addSubview:self.textPass];
    
    self.buttonCheckcode.frame = CGRectMake(self.imageView.viewWidth - 80, 55, 70, 25);
    [self.imageView addSubview:self.buttonCheckcode];
    
    self.buttonNextStep.frame = CGRectMake(10, self.imageView.ctBottom + 20, SCREENWIDTH - 20, 44);
    [self.view addSubview:self.buttonNextStep];

}

- (void)goBackView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)timeClock {
    NSString *titleCode = @"";
    if (caculateTime > 0) {
        titleCode = [NSString stringWithFormat:@"%ldS", (long)caculateTime];
        self.buttonCheckcode.enabled = NO;
        [self.buttonCheckcode setTitle:titleCode forState:UIControlStateDisabled];
    } else {
        titleCode = @"获取验证码";
        self.buttonCheckcode.enabled = YES;
        [self.buttonCheckcode setTitle:titleCode forState:UIControlStateNormal];
    }
    caculateTime --;
}

- (void)didClickCheckcode:(id) sender {
    if (self.textName.text.length != 11) {
        [self showInfo:@"电话号码格式不对"];
        return;
    }
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(timeClock) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    caculateTime = 60;
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.textName.text
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

- (void)didClickNext {
    [self.view endEditing:YES];
    if (self.textPass.text.length != 4){
        [self showInfo:@"验证码格式不正确"];
        return;
    }
    [self showLoadingActivity:YES];
    [SMS_SDK commitVerifyCode:self.textPass.text result:^(enum SMS_ResponseState state) {
        if (state == SMS_ResponseStateSuccess) {
            NSString *phoneNo = self.textName.text;
            NSString *userName = [NSString stringWithFormat:@"%@*****%@", [phoneNo substringWithRange:NSMakeRange(0, 3)], [phoneNo substringWithRange:NSMakeRange(phoneNo.length - 3, 3)]];
            NSDictionary *dic = @{@"usid":phoneNo,@"token":phoneNo,@"username":userName,@"icon":phoneNo};
            [self requestThirdPartLoginWith:dic];
        } else {
            [self hideLoadWithAnimated:YES];
            [self showInfo:@"验证码错误！"];
            
            //失败
        }
    }];
    
//    SettingPasswordViewController *controller = [[SettingPasswordViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)requestThirdPartLoginWith:(NSDictionary *) dicParam {
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *username = [dicParam objectForKey:@"username"];
    username = [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sign = [NSString stringWithFormat:@"%@%@", currentTime, [dicParam objectForKey:@"usid"]];
    sign = [[Utils MD5:sign] uppercaseString];
    NSString *url = [NSString stringWithFormat:@"%@touristregister/registerUserWithThirdPart",HOST];
    NSDictionary *dic = @{@"usid":[dicParam objectForKey:@"usid"] ,@"token":[dicParam objectForKey:@"token"],@"username":username, @"date":currentTime,@"icon":[dicParam objectForKey:@"icon"], @"sign":sign};

    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSDictionary *userDic = [dic objectForKey:@"tourist"];
            NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                      NSUserDomainMask, YES) objectAtIndex:0];
            NSString *plistPath = [rootPath stringByAppendingPathComponent:@"user.plist"];
            [userDic writeToFile:plistPath atomically:YES];
            
            TouristObject *tourist = [[TouristObject alloc] init];
            [tourist configTouristWithDic:userDic];
            [UserCachBean share].touristInfo = tourist;
            if (self.loginBlock != nil) {
                self.loginBlock([UserCachBean share], LOGINSTATUSSUCCESS);
            }
        }
        [self hideLoadWithAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showInfo:@"登陆失败"];
        [self hideLoadWithAnimated:YES];
    }];
    
}

@end
