//
//  MyGetData+News.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyGetData.h"

@interface MyGetData (News)
+(void)getNewsAppsWithper:(NSInteger)per page:(NSInteger)pageNum categoty:(NSInteger)categoty handler:(GetDataHandler)handle;
@end
