//
//  ViewController.m
//  WSWebView-Demo
//
//  Created by YSC on 15/8/18.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "ViewController.h"
#import "WSWebView.h"

@interface ViewController ()<WSWebViewDelegate>

@property (weak, nonatomic) IBOutlet WSWebView *web;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jd.com/"]];
    //    [webView loadRequest:request];
    
    WSWebView *webView = [[WSWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [self.web ws_loadRequest:request];
    [webView ws_loadRequest:request];
    
}

- (void)wswebView:(WSWebView *)webView didFinisheLoadWithUrl:(NSURL *)url
{
    if (kWSSystemOSVersionIsAboveIos8) {
        [webView.wkWebView evaluateJavaScript:@"document.title" completionHandler:^(id string, NSError *error) {
            self.navigationItem.title = string;
        }];

        [webView.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id str, NSError *error) {
            
        }];
        [webView.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    } else {
        self.navigationItem.title = [webView.webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
        //禁用页面长按弹出actionSheet
        [webView.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
        //控制用户是否可以选择页面元素内容
        [webView.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
