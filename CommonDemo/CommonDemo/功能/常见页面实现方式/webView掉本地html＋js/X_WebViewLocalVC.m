//
//  X_WebViewLocalVC.m
//  CommonDemo
//
//  Created by xiongjw on 14-7-8.
//  Copyright (c) 2014年 xiongjw. All rights reserved.
//

#import "X_WebViewLocalVC.h"

#import "Tools.h"
#import "Constans.h"

@interface X_WebViewLocalVC ()

@end

@implementation X_WebViewLocalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadInitVariable {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"掉本地js和css实现html5";
    self.view.backgroundColor = CYBackgroundColor;
    
    self.navigationItem.leftBarButtonItem = [Tools getNavBarItem:self type:1 clickAction:@selector(backAction)];
    
    //UIWebView *webView = (UIWebView *)[self.view viewWithTag:11];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(ScreenFrame), CGRectGetHeight(ScreenFrame) - 64)];
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"detail" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView loadHTMLString:htmlString baseURL:baseURL];
    
    [self.view addSubview:webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadInitVariable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
