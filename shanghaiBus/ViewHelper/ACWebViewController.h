//
//  WebViewController.h
//  WebView
//
//  Created by Ajay Chainani on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ACWebViewController : BaseViewController <UIWebViewDelegate, UIActionSheetDelegate> {

	UIWebView	*theWebView;
    UIActivityIndicatorView  *whirl;

}

-(void) updateToolbar;

@property (nonatomic, retain) NSURL *initialURL;
@property (nonatomic, assign) BOOL showWebViewAfterFirstLoadComplete;
@property (nonatomic, assign) BOOL showCancelButton;
@property (nonatomic, assign) BOOL showOpenButton;
@property (nonatomic, assign) BOOL showRefreshButton;
@property (nonatomic, assign) BOOL hideToolbar;
@property (nonatomic, assign) BOOL hideNavbar;
@property (nonatomic, assign) BOOL hideTitle;

@end
