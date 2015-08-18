//
//  ViewController.m
//  TestWKWebView
//
//  Created by YSC on 15/8/18.
//  Copyright (c) 2015年 WowSai. All rights reserved.
//

#import "ViewController.h"
#import "WSWebView.h"

@import WebKit;

@interface ViewController ()<WKScriptMessageHandler>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    configuration.userContentController = [[WKUserContentController alloc] init];
//    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
//    
//    [self.view addSubview:webView];
//    webView.allowsBackForwardNavigationGestures = YES;
//    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.shougongke.com/index.php?m=HandClass&a=class_special&spec_id=1"]];
//    [webView loadRequest:request];
    
    WSWebView *webView = [[WSWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    [webView ws_loadRequest:request];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@  \nmessage:%@", userContentController, message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
