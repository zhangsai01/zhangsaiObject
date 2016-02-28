//
//  One2TableViewCell.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "One2TableViewCell.h"

#import "NewModels.h"

#import "UIScrollView+MJRefresh.h"

#import "UIImageView+WebCache.h"

@implementation One2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updataCellWithModel:(id)model{
    NewModels *onemodel = model;
    
    [self.uiimage sd_setImageWithURL:[NSURL URLWithString:onemodel.item_small_pic]placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
    self.label2.text = onemodel.post_title;
    self.label3.text = onemodel.post_content;
}
@end
