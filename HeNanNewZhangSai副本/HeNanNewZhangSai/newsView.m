//
//  newsView.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "newsView.h"

@interface newsView ()<UIWebViewDelegate>
{
    NSString *_str;
    UIWebView *_webview;
}
@end

@implementation newsView

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
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)initWithWeb:(NSString *)Web{
    if (self = [super init]) {
        _str = [NSString stringWithString:Web];
    }
    return self;
}





@end
