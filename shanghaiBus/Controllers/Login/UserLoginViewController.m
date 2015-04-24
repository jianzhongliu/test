//
//  UserLoginViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/3/28.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UserLoginViewController.h"
#import "PhoneLoginViewController.h"
#import "RegisterViewController.h"

@interface UserLoginViewController ()<UMSocialUIDelegate>

@property (nonatomic, strong) UIButton *buttonWX;
@property (nonatomic, strong) UIButton *buttonQQ;
@property (nonatomic, strong) UIButton *buttonSina;

@property (nonatomic, strong) UIButton *buttonMore;
@property (nonatomic, strong) UIButton *buttonPhone;

@end

@implementation UserLoginViewController

- (UIButton *)buttonWX {
    if (_buttonWX == nil) {
        _buttonWX = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonWX setBackgroundImage:[UIImage imageNamed:@"icon_login"] forState:UIControlStateNormal];
        [_buttonWX setTitle:@"微信登录" forState:UIControlStateNormal];
        [_buttonWX addTarget:self action:@selector(loginWX) forControlEvents:UIControlEventTouchUpInside];
        _buttonWX.selected = NO;
    }
    return _buttonWX;
}

- (UIButton *)buttonQQ {
    if (_buttonQQ == nil) {
        _buttonQQ = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonQQ setBackgroundImage:[UIImage imageNamed:@"icon_login_nomal"] forState:UIControlStateNormal];
        [_buttonQQ setTitle:@"QQ登录" forState:UIControlStateNormal];
        [_buttonQQ addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
        _buttonQQ.selected = NO;
        _buttonQQ.hidden = YES;
    }
    return _buttonQQ;
}

- (UIButton *)buttonSina {
    if (_buttonSina == nil) {
        _buttonSina = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSina setBackgroundImage:[UIImage imageNamed:@"icon_sina_login"] forState:UIControlStateNormal];
        [_buttonSina setTitle:@"新浪微博" forState:UIControlStateNormal];
        [_buttonSina addTarget:self action:@selector(loginSina) forControlEvents:UIControlEventTouchUpInside];
        _buttonSina.selected = NO;
//        _buttonSina.alpha = 0;
    }
    return _buttonSina;
}

- (UIButton *)buttonMore {
    if (_buttonMore == nil) {
        _buttonMore = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonMore addTarget:self action:@selector(loginMore:) forControlEvents:UIControlEventTouchUpInside];
        _buttonMore.hidden = YES;
        [_buttonMore setTitle:@"更多选项..." forState:UIControlStateNormal];
        [_buttonMore setTitle:@"更少选项..." forState:UIControlStateSelected];
        _buttonMore.font = [UIFont systemFontOfSize:13];
        _buttonMore.selected = NO;
    }
    return _buttonMore;
}

- (UIButton *)buttonPhone {
    if (_buttonPhone == nil) {
        _buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonPhone setBackgroundImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
        [_buttonPhone setBackgroundImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateHighlighted];
        [_buttonPhone setTitle:@"手机号码" forState:UIControlStateNormal];
        [_buttonPhone setTitleColor:BYColorAlphaMake(0, 0, 0, 0.6) forState:UIControlStateNormal];
        [_buttonPhone setTitleEdgeInsets:UIEdgeInsetsMake(0, -SCREENWIDTH / 2, 0, 0)];
        [_buttonPhone addTarget:self action:@selector(loginPhone) forControlEvents:UIControlEventTouchDown];
        _buttonPhone.selected = NO;
    }
    return _buttonPhone;
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
    UMSocialSnsPlatform *snsPlatform = nil;
    snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];//获取授权之后获取的用户数据
    
    //     这里判断是否授权
    if ([UMSocialAccountManager isOauthAndTokenNotExpired:snsPlatform.platformName]) {
        //     这里获取到每个授权账户的昵称
    }
}

- (void)initData {
    
}

- (void)initUI {
    self.buttonBack.hidden = YES;

    [self resetFrame];
    
    [self.view addSubview:self.buttonWX];
    [self.view addSubview:self.buttonQQ];
    [self.view addSubview:self.buttonSina];
    [self.view addSubview:self.buttonMore];
    [self.view addSubview:self.buttonPhone];
    
}

- (void)resetFrame {
    self.buttonWX.frame = CGRectMake(10, 60, SCREENWIDTH - 20, 44);
    
    
    self.buttonSina.frame = CGRectMake(10, self.buttonWX.ctBottom + 10, SCREENWIDTH - 20, 44);
    
    self.buttonMore.frame = CGRectMake((SCREENWIDTH - 80) /2, self.buttonSina.ctBottom + 10, 80, 20);
    
    self.buttonQQ.frame = CGRectMake(10, self.buttonSina.ctBottom + 10, SCREENWIDTH - 20, 44);
    
    self.buttonPhone.frame = CGRectMake(10, self.buttonMore.ctBottom + 20, SCREENWIDTH - 20, 44);
}

#pragma mark - private Methods
- (void)loginWX {
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:15];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSDictionary *dicresult = [response.data objectForKey:@"wxsession"];
        if (dicresult && dicresult.count > 0) {
            NSDictionary *dic = @{@"usid":[dicresult objectForKey:@"usid"],@"token":[dicresult objectForKey:@"accessToken"],@"username":[dicresult objectForKey:@"username"],@"icon":@"www.weichat.com"};
            [self requestThirdPartLoginWith:dic];
        }
    });
}

- (void)loginQQ {
    NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeMobileQQ];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        
    });
}

- (void)loginSina {
    /**
     UMSocialSnsPlatform *snsPlatform = nil;
     snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
     NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];//获取授权之后获取的用户数据
     
     //这里判断是否授权
     if ([UMSocialAccountManager isOauthAndTokenNotExpired:snsPlatform.platformName]) {
     //这里获取到每个授权账户的昵称
     }
     */
    NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeSina];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSDictionary *dicresult = [response.data objectForKey:@"sina"];
        if (dicresult && dicresult.count > 0) {
            NSDictionary *dic = @{@"usid":[dicresult objectForKey:@"usid"],@"token":[dicresult objectForKey:@"gender"],@"username":[dicresult objectForKey:@"username"],@"icon":[dicresult objectForKey:@"icon"]};
            [self requestThirdPartLoginWith:dic];
        }
        
    });
    
}

- (void)loginMore:(UIButton *)sender {
    if (sender.isSelected == YES) {
        sender.selected = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.buttonSina.alpha = 0;
            self.buttonMore.viewY = self.buttonQQ.ctBottom + 10;
            self.buttonPhone.viewY = self.buttonSina.ctBottom + 30;
        } completion:^(BOOL finished) {
            
        }];

    } else {
        sender.selected = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.buttonSina.alpha = 1;
            self.buttonMore.viewY = self.buttonSina.ctBottom + 10;
            self.buttonPhone.viewY = self.buttonSina.ctBottom + 74;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)loginPhone {
    RegisterViewController *controller = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
//pushs
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    
}

- (void)requestThirdPartLoginWith:(NSDictionary *) dicParam {
    [self showLoadingActivity:YES];
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
          self.loginBlock([UserCachBean share], LOGINSTATUSSUCCESS);
        }
       
        [self hideLoadWithAnimated:YES];
         [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showInfo:@"登陆失败"];
        [self hideLoadWithAnimated:YES];
    }];
}


@end
