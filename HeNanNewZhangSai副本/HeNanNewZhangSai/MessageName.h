//
//  MessageName.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"

@protocol MessageName <NSObject>



@end
@interface MessageName : JSONModel
@property (retain,nonatomic) NSNumber *ID;
@property (retain,nonatomic) NSString *post_link;
@property (retain,nonatomic) NSString *post_content;
@end
