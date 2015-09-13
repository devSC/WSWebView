//
//  WSWebView.h
//  TestWKWebView
//
//  Created by YSC on 15/8/18.
//  Copyright (c) 2015年 WowSai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol WSWebViewDelegate;


#define kWSSystemOSVersionIsAboveIos8 [UIDevice currentDevice].systemVersion.floatValue > 8.0

@interface WSWebView : UIView

@property (nonatomic, readonly, strong) UIWebView *webView;

@property (nonatomic, readonly, strong) WKWebView *wkWebView;

@property (nonatomic) BOOL showIndicator; //Default is yes

@property (nonatomic) BOOL indicatorHidesWhenStopped; //Default is yes.

@property (nonatomic, weak) id<WSWebViewDelegate> delegate;

- (void)ws_loadRequest: (NSURLRequest *)request;

///WebView can go back
- (BOOL)canGoBack;

//Go back
- (void)goBack;
- (void)goForward;


@end

@protocol WSWebViewDelegate <NSObject>

@optional
- (void)wswebView: (WSWebView *)webView didStartLoadWithUrl: (NSURL *)url;

- (void)wswebView: (WSWebView *)webView didFinisheLoadWithUrl: (NSURL *)url;

- (void)wswebView: (WSWebView *)webView didFailLoadWithError: (NSError *)error;

//- (void)wswebView: (WSWebView *)webView shouldStartLoadWithUrl: (NSURLRequest *)request navigationType: (UIWebViewNavigationType)type;
- (void)wswebView: (WSWebView *)webView shouldStartLoadWithRequest: (NSURLRequest *)request;
@end