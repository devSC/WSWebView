//
//  ViewController.m
//  WSWebView-Demo
//
//  Created by YSC on 15/8/18.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "ViewController.h"
#import "WSWebView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jd.com/"]];
    //    [webView loadRequest:request];
    
    WSWebView *webView = [[WSWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    [webView ws_loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
