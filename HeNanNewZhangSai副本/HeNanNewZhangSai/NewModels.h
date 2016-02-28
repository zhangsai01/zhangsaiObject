//
//  NewModels.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"

@protocol  NewModels<NSObject>

@end
@interface NewModels : JSONModel
@property (copy,nonatomic) NSString *post_hd;
@property (copy,nonatomic) NSString *post_link;
@property (copy,nonatomic) NSString *post_date;
@property (copy,nonatomic) NSString *post_title;
@property (copy,nonatomic) NSString *post_cart;
@property (copy,nonatomic) NSString *item_small_pic;
@property (copy,nonatomic) NSString *post_excerpt;
@property (copy,nonatomic) NSNumber *ID;
@property (copy,nonatomic) NSString *post_content;
@property (nonatomic,copy)NSString *pics;
@end
