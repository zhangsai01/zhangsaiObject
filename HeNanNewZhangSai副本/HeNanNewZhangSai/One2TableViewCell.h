//
//  One2TableViewCell.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface One2TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *uiimage;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

//更新显示
-(void)updataCellWithModel:(id)model;
@end
