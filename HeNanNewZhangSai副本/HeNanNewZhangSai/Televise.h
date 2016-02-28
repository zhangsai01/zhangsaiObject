//
//  Televise.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/19.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"

#import "TeleviseModel.h"
@interface Televise : JSONModel

@property(nonatomic,strong)NSArray <TeleviseModel,Optional>*data;
@property (nonatomic,copy)NSString *error;
@end
