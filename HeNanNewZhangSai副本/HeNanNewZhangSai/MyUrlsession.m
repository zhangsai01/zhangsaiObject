//
//  MyUrlsession.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyUrlsession.h"

@implementation MyUrlsession
{
    //用来访问网络
    NSURLSession *_session;
}
-(instancetype)init{
    if (self =[super init]) {
        //实例化_session
        NSURLSessionConfiguration *configuration =[NSURLSessionConfiguration defaultSessionConfiguration];
        //session对象
        _session =[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    }
    return self;
}

//单例
+(MyUrlsession *)defaultSession{
    static MyUrlsession *session = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        session =[[MyUrlsession alloc]init];
    });
    return session;
}

#pragma maek -接口方法-
//访问服务器
-(void)accessServerWithUrlStr:(NSString *)urlStr andHandler:(NetHandler)handler{
    
    //url字符串utf8类型
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //创建request
    NSURL *url =[NSURL URLWithString:urlStr];
    NSURLRequest *quest =[NSURLRequest requestWithURL:url];
    //访问服务器
    NSURLSessionDataTask *dataTask =[_session dataTaskWithRequest:quest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //这里拿到服务器返回的结果，在这里返回。
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //这里是主线程
            if (handler) {
                handler(data,error);
            }
        });
    }];
    [dataTask resume];
}
@end
