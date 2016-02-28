//
//  MyGetData.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyNetHeader.h"

#import "MyUrlsession.h"


/**
 *  获取数据的block
 *
 *  @param id      拿到的数据
 *  @param NSError 错误标记
 */
typedef  void (^GetDataHandler)(id,NSError *,NSInteger);

@interface MyGetData : NSObject

@end
