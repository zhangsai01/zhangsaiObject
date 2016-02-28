//
//  MyGetData+HeadNews.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyGetData.h"

@interface MyGetData (HeadNews)
+(void)getHeadNewsAppsWithper:(NSInteger)per page:(NSInteger)pageNum categoty:(NSInteger)categoty handler:(GetDataHandler)handle;
@end
