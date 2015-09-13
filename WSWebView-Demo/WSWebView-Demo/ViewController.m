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
@property (weak, nonatomic) IBOutlet WSWebView *web;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jd.com/"]];
    //    [webView loadRequest:request];
    
    WSWebView *webView = [[WSWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    
    [self.view addSubview:webView];
    
    [self.web ws_loadRequest:request];
    [webView ws_loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
