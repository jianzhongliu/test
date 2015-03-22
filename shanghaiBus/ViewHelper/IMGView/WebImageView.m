//
//  WebImageView.m
//  UIComponent
//
//  Created by yan zheng on 12-11-26.
//  Copyright (c) 2012年 anjuke. All rights reserved.
//

#import "WebImageView.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface WebImageView ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation WebImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)dealloc {
//    [super dealloc];
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [imageUrl copy];
    if (_imageUrl)
    {
        NSURL *url = [NSURL URLWithString:_imageUrl];
        [self setImageWithURL:url];
//        self.image l
        
    }
}

//- (void)onImageFetched:(RTNetworkResponse *)response {
//    // network error
//    if ([response status] != RTNetworkResponseStatusSuccess)
//        return;
//    
//    // cache image's local path
//    id status = [[response content] objectForKey:@"status"];
//    if (status && [[(NSString *)status uppercaseString] isEqualToString:@"OK"]) {
//        NSString *imagePath = [[response content] objectForKey:@"imagePath"];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
//            self.image = [UIImage imageWithContentsOfFile:imagePath];
//        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:self];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
