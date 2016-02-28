//
//  MyUrlsession.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  访问网络的block
 *
 *  @param id      拿到的网络数据
 *  @param NSError 错误标记
 */
typedef void (^NetHandler)(id,NSError *);

/**
 *  网络数据加载的类，这个类，只负责网络数据的加载。它，是一个单例
 */
@interface MyUrlsession : NSObject


/**
 *  单利接口
 *
 *  @return 单利对象
 */
+(MyUrlsession *)defaultSession;



/**
 * 通过url字符串访问服务器，获取结果
 *
 *  @param urlStr url字符串
 *  @param handler 结果回调
 */
-(void)accessServerWithUrlStr:(NSString *)urlStr andHandler:(NetHandler)handler;
@end
