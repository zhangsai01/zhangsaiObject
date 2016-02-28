//
//  messaViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "messaViewController.h"

@interface messaViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
{
    NSString *_str;
    UIWebView *_webview;
}
@end

@implementation messaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
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
    _webview.scrollView.delegate = self;
    _webview.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)initWithWeb:(NSString *)str{
    if (self = [super init]) {
        _str =[NSString stringWithString:str];
        NSLog(@"%@",_str);
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_str isEqualToString: @"http://khd.shangbw.com/m/zhibo.aspx?category=25"]) {
        
        _webview.frame = CGRectMake(0, -110, self.view.frame.size.width,self.view.frame.size.height);
        
        NSLog(@"%f",_webview.scrollView.contentOffset.y);
        
        if (_webview.scrollView.contentOffset.y>=19250.000000) {
            _webview.scrollView.contentOffset =CGPointMake(0, 19250.000000) ;
        }
    }
}

@end
