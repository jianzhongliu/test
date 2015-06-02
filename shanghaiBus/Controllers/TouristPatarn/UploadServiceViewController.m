//
//  UploadServiceViewController.m
//  shanghaiBus
//
//  Created by liujianzhong on 15/4/20.
//  Copyright (c) 2015年 liujianzhong. All rights reserved.
//

#import "UploadServiceViewController.h"
#import "UploadInfoCommonInputView.h"
#import "TouristInputInfoViewController.h"
#import "BK_ELCImagePickerController.h"
#import "BK_ELCAlbumPickerController.h"
#import "ImageScrollView.h"
#import "FilePathManager.h"

@interface UploadServiceViewController () <UITableViewDataSource, UITableViewDelegate, TouristInputInfoViewControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ELCImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableList;

@property (nonatomic, strong) ImageScrollView *imageList;
@property (nonatomic, strong) NSMutableArray *arrayImage;
@property (nonatomic, strong) NSString *imageUrlString;//所有url用|分割开

@property (nonatomic, strong) UploadInfoCommonInputView *viewTitle;//标题
@property (nonatomic, strong) UploadInfoCommonInputView *viewPrice;//价格
@property (nonatomic, strong) UploadInfoCommonInputView *viewArea;//服务区域
@property (nonatomic, strong) UploadInfoCommonInputView *viewLanguage;//服务语言
@property (nonatomic, strong) UploadInfoCommonInputView *viewPriceDetail;//价格详情
@property (nonatomic, strong) UploadInfoCommonInputView *viewPreBook;//预订须知
@property (nonatomic, strong) UploadInfoCommonInputView *viewService;//服务描述

@end

@implementation UploadServiceViewController

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
    [self initUI];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(didDismissMyInfo)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(didSaveInfo)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self setTitle:@"发布服务信息"];

}

- (void)initData {
    self.service = [[ServiceObject alloc] init];
    self.arrayImage = [NSMutableArray array];
}

- (void)initUI {
    self.tableList.frame = self.view.bounds;
    [self.view addSubview:self.tableList];
    
    self.imageList.frame = CGRectMake(0, 0, SCREENWIDTH, 80);
    self.tableList.tableHeaderView = self.imageList;
    [self.imageList configViewWithData:nil clickBlock:^(NSInteger index) {
        [self takePictureOrLibrary];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - action && private Methods
- (void)didDismissMyInfo {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSaveInfo {
    if (self.arrayImage.count > 0) {
        [self uploadImage];
    } else{
        [self requestData];
    }
}

- (void)takePictureOrLibrary {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [action showInView:self.view];
}

#pragma mark - reqeust
- (void)requestData {
    [self showLoadingActivity:YES];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSString *currentTime = [Utils getCurrentTime];
    NSString *title = [self.viewTitle.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *price = [self.viewPrice.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *area = [self.viewArea.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *language = [self.viewLanguage.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *priceDetail = [self.viewPriceDetail.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *preBook = [self.viewPreBook.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *service = [self.viewService.textInput.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *imageurl = @"http://www.baidu.com";
    if (self.imageUrlString.length > 0) {
        imageurl = self.imageUrlString;
    }
    NSString *url = [NSString stringWithFormat:@"%@service/insertServiceObject",HOST];
    if (self.service.identify.length > 0) {
        //需要更新数据，而不是添加服务
        url = [NSString stringWithFormat:@"%@service/updateServiceWithObject",HOST];
        currentTime = self.service.identify;
    }
    
    NSDictionary *dic = @{@"identify":currentTime,@"touristid":[[[UserCachBean share] touristInfo] identify], @"otherinfoid":title, @"price":price, @"servicearea":area, @"language":language, @"pricedetail":priceDetail, @"prebook":preBook, @"servicedetail":service, @"images":imageurl, @"adddate":currentTime};
    
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hideLoadWithAnimated:YES];
        [self performSelector:@selector(didDismissMyInfo) withObject:nil afterDelay:2];        
        
        [self showInfo:@"提交成功!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadWithAnimated:YES];
        [self showInfo:@"提交失败，请重试!"];
    }];

}

- (void)uploadImage {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:API_PhotoUpload parameters:@{@"file":@""} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i<self.arrayImage.count; i++) {
            UIImage *uploadImage = self.arrayImage[i];
            [formData appendPartWithFileData:UIImagePNGRepresentation(uploadImage) name:@"file" fileName:[NSString stringWithFormat:@"%d_image",i] mimeType:@"image/jpg"];
        }
    } error:nil];
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    opration.responseSerializer = [AFJSONResponseSerializer serializer];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        if ([[result objectForKey:@"status"] isEqualToString:@"ok"]) {
            NSDictionary *image = result[@"image"];
            NSString *imageUrl_ = [NSString stringWithFormat:@"http://pic%@.ajkimg.com/m/%@/%@x%@.jpg",image[@"host"],image[@"id"],image[@"width"],image[@"height"]];
            NSLog(@"%@",imageUrl_);
            if (self.imageUrlString.length > 0) {
                self.imageUrlString = imageUrl_;
            } else {
                self.imageUrlString = [NSString stringWithFormat:@"%@|%@", self.imageUrlString, imageUrl_];
            }
            [self requestData];
        } else {
            [self requestData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showInfo:@"图片上传失败"];
        [self hideLoadWithAnimated:YES];
    }];
    [opration start];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    switch (section) {
        case 0:
        {
            number = 2;
        }
            break;
        case 2:
        {
            number = 2;
        }
            break;
        case 4:
        {
            number = 3;
        }
            break;
        default:
            break;
    }
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    NSArray *subview = [cell subviews];
    for (UIView *view in subview) {
        if ([view isKindOfClass:[UploadInfoCommonInputView class]]) {
            [view removeFromSuperview];
        }
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.viewTitle configViewWithTitle:@"标    题"];
                    self.viewTitle.textInput.text = self.service.otherinfoid;
                    [cell addSubview:self.viewTitle];
                }
                    break;
                case 1:
                {
                    [self.viewPrice configViewWithTitle:@"价     格"];
                    self.viewPrice.textInput.text = self.service.price;
                    [cell addSubview:self.viewPrice];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.viewArea configViewWithTitle:@"导游区域"];
                    self.viewArea.textInput.text = self.service.servicearea;
                    [cell addSubview:self.viewArea];
                }
                    break;
                case 1:
                {
                    [self.viewLanguage configViewWithTitle:@"擅长语言"];
                    self.viewLanguage.textInput.text = self.service.language;
                    [cell addSubview:self.viewLanguage];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.viewPriceDetail configViewWithTitle:@"价格说明"];
                    self.viewPriceDetail.textInput.text = self.service.pricedetail;
                    [cell addSubview:self.viewPriceDetail];
                }
                    break;
                case 1:
                {
                    [self.viewPreBook configViewWithTitle:@"预订须知"];
                    self.viewPreBook.textInput.text = self.service.preBook;
                    [cell addSubview:self.viewPreBook];
                }
                    break;
                case 2:
                {
                    [self.viewService configViewWithTitle:@"服务描述"];
                    self.viewService.textInput.text = self.service.servicedetail;
                    [cell addSubview:self.viewService];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"标题"];
                    controller.textContent.text = self.viewTitle.textInput.text;
                    controller.delegate = self;
                    controller.tag = 1;
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewTitle configViewWithTitle:@"标    题"];
//                    [cell addSubview:self.viewTitle];
                }
                    break;
                case 1:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    [controller setTitle:@"价格"];
                    controller.textContent.text = self.viewPrice.textInput.text;
                    controller.delegate = self;
                    controller.tag = 7;
                    [self.navigationController pushViewController:controller animated:YES];
                    
//                    [self.viewPrice.textInput becomeFirstResponder];

                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    controller.textContent.text = self.viewArea.textInput.text;
                    [controller setTitle:@"导游区域"];
                    controller.delegate = self;
                    controller.tag = 2;
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewArea configViewWithTitle:@"导游区域"];
//                    [cell addSubview:self.viewArea];
                }
                    break;
                case 1:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    controller.textContent.text = self.viewLanguage.textInput.text;
                    [controller setTitle:@"擅长语言"];
                    controller.delegate = self;
                    controller.tag = 3;
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewLanguage configViewWithTitle:@"擅长语言"];
//                    [cell addSubview:self.viewLanguage];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    controller.textContent.text = self.viewPriceDetail.textInput.text;
                    [controller setTitle:@"价格说明"];
                    controller.delegate = self;
                    controller.tag = 4;
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewPriceDetail configViewWithTitle:@"价格说明"];
//                    [cell addSubview:self.viewPriceDetail];
                }
                    break;
                case 1:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    controller.textContent.text = self.viewPreBook.textInput.text;
                    [controller setTitle:@"预订须知"];
                    controller.delegate = self;
                    controller.tag = 5;
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewPreBook configViewWithTitle:@"预订须知"];
//                    [cell addSubview:self.viewPreBook];
                }
                    break;
                case 2:
                {
                    TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
                    controller.textContent.text = self.viewService.textInput.text;
                    [controller setTitle:@"服务描述"];
                    controller.delegate = self;
                    controller.tag = 6;
                    [self.navigationController pushViewController:controller animated:YES];
//                    [self.viewService configViewWithTitle:@"服务描述"];
//                    [cell addSubview:self.viewService];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - TouristInputViewControllerDelegate
- (void)didUploadInfoWith:(NSString *)content tag:(NSInteger)tag {
    switch (tag) {
        case 1:
        {
            self.viewTitle.textInput.text = content;
        }
            break;
        case 2:
        {
            self.viewArea.textInput.text = content;
        }
            break;
        case 3:
        {
            self.viewLanguage.textInput.text = content;
        }
            break;
        case 4:
        {
            self.viewPriceDetail.textInput.text = content;
        }
            break;
        case 5:
        {
            self.viewPreBook.textInput.text = content;
        }
            break;
        case 6:
        {
            self.viewService.textInput.text = content;
        }
            break;
        case 7:
        {
            self.viewPrice.textInput.text = content;
        }
            break;
        default:
            break;
    }

}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera; //拍照
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            break;
        case 1:
        {
            BK_ELCAlbumPickerController *albumPicker = [[BK_ELCAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
            BK_ELCImagePickerController *elcPicker = [[BK_ELCImagePickerController alloc] initWithRootViewController:albumPicker];
            elcPicker.maximumImagesCount = 5 - self.arrayImage.count ; //(maxCount - self.roomImageArray.count);
            elcPicker.imagePickerDelegate = self;
            [self presentViewController:elcPicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
- (void)elcImagePickerController:(BK_ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    if ([info count] == 0) {
        return;
    }
    int tempNum = 1;
    for (NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [self.arrayImage addObject:image];
    }
    [self.imageList configViewWithData:self.arrayImage clickBlock:^(NSInteger index) {
        [self takePictureOrLibrary];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(BK_ELCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSMutableArray *arrayImage = [NSMutableArray array];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [arrayImage addObject:image];
    [self.imageList configViewWithData:arrayImage clickBlock:^(NSInteger index) {
        [self takePictureOrLibrary];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter && setter

- (UITableView *)tableList {
    if (_tableList == nil) {
        _tableList = [[UITableView alloc] init];
        _tableList.delegate = self;
        _tableList.dataSource = self;
        _tableList.separatorColor = [UIColor clearColor];
        _tableList.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableList;
}

- (ImageScrollView *)imageList {
    if (_imageList == nil) {
        _imageList = [[ImageScrollView alloc] init];
    }
    return _imageList;
}

- (UploadInfoCommonInputView *)viewTitle {
    if (_viewTitle == nil) {
        _viewTitle = [[UploadInfoCommonInputView alloc] init];
        _viewTitle.viewType = VIEWTYPENAME;
    }
    return _viewTitle;
}

- (UploadInfoCommonInputView *)viewPrice {
    if (_viewPrice == nil) {
        _viewPrice = [[UploadInfoCommonInputView alloc] init];
        _viewPrice.viewType = VIEWTYPENAME;
    }
    return _viewPrice;
}

- (UploadInfoCommonInputView *)viewArea {
    if (_viewArea == nil) {
        _viewArea = [[UploadInfoCommonInputView alloc] init];
        _viewArea.viewType = VIEWTYPENAME;
    }
    return _viewArea;
}

- (UploadInfoCommonInputView *)viewLanguage {
    if (_viewLanguage == nil) {
        _viewLanguage = [[UploadInfoCommonInputView alloc] init];
        _viewLanguage.viewType = VIEWTYPENAME;
    }
    return _viewLanguage;
}

- (UploadInfoCommonInputView *)viewPriceDetail {
    if (_viewPriceDetail == nil) {
        _viewPriceDetail = [[UploadInfoCommonInputView alloc] init];
        _viewPriceDetail.viewType = VIEWTYPENAME;
    }
    return _viewPriceDetail;
}

- (UploadInfoCommonInputView *)viewPreBook {
    if (_viewPreBook == nil) {
        _viewPreBook = [[UploadInfoCommonInputView alloc] init];
        _viewPreBook.viewType = VIEWTYPENAME;
    }
    return _viewPreBook;
}

- (UploadInfoCommonInputView *)viewService {
    if (_viewService == nil) {
        _viewService = [[UploadInfoCommonInputView alloc] init];
        _viewService.viewType = VIEWTYPENAME;
    }
    return _viewService;
}

@end
