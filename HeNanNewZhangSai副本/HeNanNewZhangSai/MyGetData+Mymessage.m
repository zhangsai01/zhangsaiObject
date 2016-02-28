//
//  MyGetData+Mymessage.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyGetData+Mymessage.h"

#import "message.h"
@implementation MyGetData (Mymessage)
+(void)getmessgetNewsAppsWithper:(NSInteger)per page:(NSInteger)pageNum categoty:(NSInteger)categoty handler:(GetDataHandler)handle{
    //拼接Url
    NSMutableString *URLStr =[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@",MY_NAME];
    [URLStr appendFormat:@"&per=%ld&page=%ld&aid=%ld",per,pageNum,categoty];
    //打印下url
    NSLog(@"我的消息：%@",URLStr);
    
    [[MyUrlsession defaultSession]accessServerWithUrlStr:URLStr andHandler:^(NSData *data, NSError *error) {
        
        if (!error) {
            //这样直接解析，面临风险。有可能服务器做出了响应，但是服务器并没有返回想要的结果，比如参数传递错误。所以一般情况下，服务器应该返回处理的状态值。状态正确才解析。
            //解析数据到model中。
            message *newmodel =[[message alloc]initWithData:data error:&error];
            if (!error) {
                NSLog(@"解析成功");
            }else{
                NSLog(@"解析失败");
            }
            handle(newmodel.data,nil,categoty);
        }else{
            NSLog(@"error%@",error);
            handle(nil,error,0);
        }
    }];

}
@end
