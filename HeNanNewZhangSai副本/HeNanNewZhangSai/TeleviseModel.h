//
//  TeleviseModel.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/19.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"

@protocol  TeleviseModel<NSObject>



@end
@interface TeleviseModel : JSONModel

@property (retain,nonatomic) NSString *post_hd;
@property (retain,nonatomic) NSString *post_link;
@property (retain,nonatomic) NSString *post_date;
@property (retain,nonatomic) NSString *post_title;
@property (retain,nonatomic) NSString *post_cart;
@property (retain,nonatomic) NSString *item_small_pic;
@property (retain,nonatomic) NSString *post_zhibo;
@property (retain,nonatomic) NSString *post_excerpt;
@property (retain,nonatomic) NSNumber *ID;
@property (retain,nonatomic) NSString *post_content;

@end
