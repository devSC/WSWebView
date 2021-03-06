//
//  WSWebView.m
//  TestWKWebView
//
//  Created by YSC on 15/8/18.
//  Copyright (c) 2015年 WowSai. All rights reserved.
//

#import "WSWebView.h"
#import <WebKit/WKUserScript.h>

@interface WSWebView ()<UIWebViewDelegate, WKNavigationDelegate>
{
    
}
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;
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
        [self configureWebView];
        
    }
    return self;
}


- (void)awakeFromNib
{
    [self configureWebView];
    //    NSLog(@"%s %@",__func__, NSStringFromCGRect(self.bounds));
}

- (void)layoutSubviews
{
    if (kWSSystemOSVersionIsAboveIos8) {
        [self.wkWebView setFrame:self.bounds];
    }else {
        [self.webView setFrame:self.bounds];
    }
    [self.indicator setCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)];
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
    
    if ([_delegate respondsToSelector:@selector(wswebView:shouldStartLoadWithRequest:)]) {
        [_delegate wswebView:self shouldStartLoadWithRequest:navigationAction.request];
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
    //    NSLog(@"%s", __func__);
    [self.indicator startAnimating];
    if ([_delegate respondsToSelector:@selector(wswebView:didStartLoadWithUrl:)]) {
        [_delegate wswebView:self didStartLoadWithUrl:webView.URL];
    }
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
    //    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    //    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    //    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id str, NSError *error) {
    //
    //    }];
    //    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:^(id str, NSError *error) {
    
    //    }];
    
    NSLog(@"%s", __func__);
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //    NSLog(@"%s", __func__);
    [self.indicator stopAnimating];
    if ([_delegate respondsToSelector:@selector(wswebView:didFinisheLoadWithUrl:)]) {
        [_delegate wswebView:self didFinisheLoadWithUrl:webView.URL];
    }
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    //    NSLog(@"%s", __func__);
    [self.indicator stopAnimating];
    if ([_delegate respondsToSelector:@selector(wswebView:didFailLoadWithError:)]) {
        [_delegate wswebView:self didFailLoadWithError:error];
    }
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



#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
    if ([_delegate respondsToSelector:@selector(wswebView:didStartLoadWithUrl:)]) {
        [_delegate wswebView:self didStartLoadWithUrl:webView.request.URL];
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([_delegate respondsToSelector:@selector(wswebView:shouldStartLoadWithRequest:)]) {
        [_delegate wswebView:self shouldStartLoadWithRequest:request];
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicator stopAnimating];
    if ([_delegate respondsToSelector:@selector(wswebView:didFinisheLoadWithUrl:)]) {
        [_delegate wswebView:self didFinisheLoadWithUrl:webView.request.URL];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([_delegate respondsToSelector:@selector(wswebView:didFailLoadWithError:)]) {
        [_delegate wswebView:self didFailLoadWithError:error];
    }
    [self.indicator stopAnimating];
}


- (void)configureWebView
{
    if (kWSSystemOSVersionIsAboveIos8) {
        [self addSubview:self.wkWebView];
    } else {
        [self addSubview:self.webView];
    }
    
    [self addSubview:self.indicator];
    
    self.indicatorHidesWhenStopped = YES;
    self.showIndicator = YES;
}


- (void)setShowIndicator:(BOOL)showIndicator
{
    self.indicator.hidden = !showIndicator;
}

- (void)setIndicatorHidesWhenStopped:(BOOL)indicatorHidesWhenStopped
{
    self.indicator.hidesWhenStopped = indicatorHidesWhenStopped;
}


#pragma mark - Privite method
- (void)ws_loadRequest:(NSURLRequest *)request
{
    if (kWSSystemOSVersionIsAboveIos8) {
        [self.wkWebView loadRequest:request];
    } else {
        [self.webView loadRequest:request];
        [self.webView request];
    }
}

- (BOOL)canGoBack
{
    if (kWSSystemOSVersionIsAboveIos8) {
        return [self.wkWebView canGoBack];
    } else {
        return [self.webView canGoBack];
    }
}
- (void)goBack
{
    if (kWSSystemOSVersionIsAboveIos8) {
        [self.wkWebView goBack];
    } else {
        [self.webView goBack];
    }
}

- (void)goForward
{
    if (kWSSystemOSVersionIsAboveIos8) {
        [self.wkWebView goForward];
    } else {
        [self.webView goForward];
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
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        //        [userContentController addUserScript:[[WKUserScript alloc] initWithSource:@"document.documentElement.style.webkitTouchCallout='none';" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES]];
        //         [userContentController addUserScript:[[WKUserScript alloc] initWithSource:@"document.documentElement.style.webkitUserSelect='none';" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES]];
        //        [userContentController removeAllUserScripts];
        configuration.userContentController = userContentController;
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.navigationDelegate = self;
        _wkWebView.backgroundColor = [UIColor grayColor];
    }
    return _wkWebView;
}


- (UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.hidesWhenStopped = YES;
    }
    return _indicator;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
