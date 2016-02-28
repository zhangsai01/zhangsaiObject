//
//  message.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"
#import "MessageName.h"
@interface message : JSONModel
@property (nonatomic,strong)NSArray<MessageName,Optional>*data;
@end
