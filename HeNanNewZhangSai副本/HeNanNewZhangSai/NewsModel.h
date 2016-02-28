//
//  NewsModel.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"
#import "NewModels.h"
@interface NewsModel : JSONModel
@property(nonatomic,strong)NSArray<NewModels,Optional>*data;

@end
