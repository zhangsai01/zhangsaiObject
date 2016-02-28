//
//  newsView.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsView : UIViewController

@property (nonatomic,copy)NSString *str;

-(id)initWithWeb:(NSString *)Web;
@end
