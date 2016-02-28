//
//  ApplysViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "ApplysViewController.h"

@interface ApplysViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    NSString *_str;
    UIWebView *_webview;
}
@end

@implementation ApplysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _webview = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_webview];
    //指定加载的连接
    NSURL *url =[NSURL URLWithString:_str];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    //网页加载对应的request
    [_webview loadRequest:request];
    //调整适应比例
    _webview.scalesPageToFit = YES;
    _webview.delegate = self;
 
    _webview.scrollView.bounces = NO;
    [self creatLabel];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
   
    [_webview stringByEvaluatingJavaScriptFromString: @"document.getElementsByClassName('app-open')[0].style.display = 'NONE'"];
    
    [_webview stringByEvaluatingJavaScriptFromString: @"document.getElementsByClassName(' app-close')[0].style.display = 'NONE'"];
    
    [_webview stringByEvaluatingJavaScriptFromString: @"document.getElementsByClassName(' app-close')[0].style.display = 'NONE'"];
    
  
}

#pragma maek -webView代理
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *urlstr =request.URL.description;
//    if (urlstr isEqualToString:@""]) {
//        return NO;
//    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithWeb:(NSString *)str{
    if (self = [super init]) {
        _str =[NSString stringWithString:str];
       
    }
    return self;
}


-(void)creatLabel{
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 60)];
    label.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:label];
}



@end
