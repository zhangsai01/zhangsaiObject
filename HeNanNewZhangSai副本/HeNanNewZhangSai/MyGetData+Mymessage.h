//
//  MyGetData+Mymessage.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyGetData.h"

@interface MyGetData (Mymessage)
+(void)getmessgetNewsAppsWithper:(NSInteger)per page:(NSInteger)pageNum categoty:(NSInteger)categoty handler:(GetDataHandler)handle;
@end
