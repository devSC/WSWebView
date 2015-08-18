//
//  WSWebView.m
//  TestWKWebView
//
//  Created by YSC on 15/8/18.
//  Copyright (c) 2015年 WowSai. All rights reserved.
//

#import "WSWebView.h"
#import <WebKit/WebKit.h>

#define kWSIsAboveIos8 [UIDevice currentDevice].systemVersion.floatValue > 8.0

@interface WSWebView ()<UIWebViewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WKWebView *wkWebView;

@end



@implementation WSWebView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (kWSIsAboveIos8) {
            [self addSubview:self.wkWebView];
            [self.wkWebView setFrame:frame];
        } else {
            [self addSubview:self.webView];
            [self.wkWebView setFrame:self.bounds];
        }
        
    }
    return self;
}


#pragma mark - WKNavigationDelegate Method

/*! @abstract Decides whether to allow or cancel a navigation.
@param webView The web view invoking the delegate method.
@param navigationAction Descriptive information about the action
triggering the navigation request.
@param decisionHandler The decision handler to call to allow or cancel the
navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
@discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%s, url: %@", __func__ , url);
    if ([url hasPrefix:@"app://"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
//
///*! @abstract Decides whether to allow or cancel a navigation after its
// response is known.
// @param webView The web view invoking the delegate method.
// @param navigationResponse Descriptive information about the navigation
// response.
// @param decisionHandler The decision handler to call to allow or cancel the
// navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
// @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
// */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//    NSLog(@"%s", __func__);
//}

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    NSLog(@"%s", __func__);
}

//- (void)updateConstraints
//{
//    [super updateConstraints];
//    
//    if (kWSIsAboveIos8) {
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_wkWebView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_wkWebView)]];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_wkWebView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_wkWebView)]];
//    } else {
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_webView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_webView)]];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_webView)]];
//    }
//    
//}
- (void)configureWebView
{
    
}


#pragma mark - Privite method
- (void)ws_loadRequest:(NSURLRequest *)request
{
    if (kWSIsAboveIos8) {
        [self.wkWebView loadRequest:request];
    } else {
        [self.webView loadRequest:request];
        [self.webView request];
    }
}


- (BOOL)isAboveIOS8 //> ios8.0
{
    return [UIDevice currentDevice].systemVersion.floatValue > 8.0;
}


#pragma mark - Getter & Setter

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.delegate = self;
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        //禁用页面长按弹出actionSheet
        [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
        //控制用户是否可以选择页面元素内容
        [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];

    }
    
    return _webView;
};


- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [[WKUserContentController alloc] init];
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.navigationDelegate = self;
        _wkWebView.backgroundColor = [UIColor grayColor];
        [_wkWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id success, NSError *error) {
            
        }];
        
        [_wkWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:^(id success, NSError *error) {
            
        }];
    }
    return _wkWebView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
