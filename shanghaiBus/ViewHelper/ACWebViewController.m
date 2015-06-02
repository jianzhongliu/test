    //
//  WebViewController.m
//  WebView
//
//  Created by Ajay Chainani on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ACWebViewController.h"

@implementation ACWebViewController

@synthesize initialURL = _initialURL;
@synthesize showCancelButton;
@synthesize showOpenButton;
@synthesize showRefreshButton;
@synthesize hideToolbar;
@synthesize hideNavbar;
@synthesize showWebViewAfterFirstLoadComplete;
@synthesize hideTitle;

#pragma mark -
#pragma mark Application Lifecycle

- (void)loadView
{	
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];	
	contentView.autoresizesSubviews = YES;
	self.view = contentView;	
	
    //set the web frame size
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
    webFrame.origin.y = 0;
	
    //add the web view
	theWebView = [[UIWebView alloc] initWithFrame:webFrame];
	theWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	theWebView.scalesPageToFit = YES;
	theWebView.delegate = self;
	
	NSURLRequest *req = [NSURLRequest requestWithURL:_initialURL];
	[theWebView loadRequest:req];
	
    if (!showWebViewAfterFirstLoadComplete) {
        [self.view addSubview: theWebView];
    }
}

- (void)dismiss:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    whirl = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	whirl.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    whirl.center = self.view.center;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: whirl];
    
    if (showCancelButton) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss:)];
    }
    
	[self.navigationController setToolbarHidden:hideToolbar animated:YES];
	[self.navigationController setNavigationBarHidden:hideNavbar animated:YES];
	
    [self updateToolbar];

}

-(void)updateToolbar {
    
	UIBarButtonItem *backButton =	[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon.png"] style:UIBarButtonItemStylePlain target:theWebView action:@selector(goBack)];
	UIBarButtonItem *forwardButton =	[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forwardIcon.png"] style:UIBarButtonItemStylePlain target:theWebView action:@selector(goForward)];
    
    [backButton setEnabled:theWebView.canGoBack];
    [forwardButton setEnabled:theWebView.canGoForward];
    
    UIBarButtonItem *refreshButton = nil;
    if (theWebView.loading) {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:theWebView action:@selector(stopLoading)];
    } else {
        refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:theWebView action:@selector(reload)];
    }
    
	UIBarButtonItem *openButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction)];
    UIBarButtonItem *spacing       = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSMutableArray *contents = [[NSMutableArray alloc] initWithObjects:backButton, spacing, forwardButton, nil];

    if (showRefreshButton) {
        [contents addObject:spacing];
        [contents addObject:refreshButton];
    }
    
    if (showOpenButton) {
        [contents addObject:spacing];
        [contents addObject:openButton];
    }

    
    [self setToolbarItems:contents animated:NO];
        
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
    [self.navigationController setToolbarHidden:YES animated:YES];
	
}

#pragma mark UIWebView delegate methods

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	return YES;
}

- (void) webViewDidStartLoad: (UIWebView * ) webView {    
    [whirl startAnimating]; 
    [self updateToolbar];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@",webView.request.URL.absoluteString);
    
    if (showWebViewAfterFirstLoadComplete) {
        [self.view addSubview: theWebView];
        showWebViewAfterFirstLoadComplete = NO;
    }
    
    [self updateToolbar];
    if (!self.hideTitle) {
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    [whirl stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateToolbar];
    [whirl stopAnimating];
    
    //handle error
}

#pragma mark -
#pragma mark ActionSheet methods

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0 && theWebView.request.URL != nil) {
		[[UIApplication sharedApplication] openURL:theWebView.request.URL];
	}
}

- (void)shareAction {

	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
										cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
										otherButtonTitles:@"Open in Safari", nil];
	
	[actionSheet showInView: self.view];
	
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    //deallocate web view
    if (theWebView.loading)
        [theWebView stopLoading];
    
    theWebView.delegate = nil;
    theWebView = nil;
}

- (void)dealloc
{
    //make sure that it has stopped loading before deallocating
    if (theWebView.loading)
        [theWebView stopLoading];
    
    //deallocate web view
	theWebView.delegate = nil;
	theWebView = nil;
    
}

@end
