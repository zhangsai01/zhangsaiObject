//
//  Temodels.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/19.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "JSONModel.h"

@protocol  Temodels <NSObject>

@end
@interface Temodels : JSONModel

@property (retain,nonatomic) NSString *Raudio;
@property (retain,nonatomic) NSString *Rvideo;
@property (retain,nonatomic) NSString *Createtime;
@property (retain,nonatomic) NSString *Rcont;
@property (retain,nonatomic) NSString *Rurl;
@property (retain,nonatomic) NSNumber *Hint;
@property (retain,nonatomic) NSString *UserName;
@property (retain,nonatomic) NSString *Himgurl;
@property (retain,nonatomic) NSNumber *ID;
@property (retain,nonatomic) NSNumber *Rhostid;

@end
