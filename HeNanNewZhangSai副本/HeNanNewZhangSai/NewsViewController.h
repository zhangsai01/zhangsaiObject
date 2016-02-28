//
//  NewsViewController.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "One2TableViewCell.h"

#import "UIScrollView+MJRefresh.h"

#import "MyGetDataFunc.h"



@interface NewsViewController : UIViewController
{
    //数据源
    NSMutableArray *_dataArray;
    //记录页数
    NSInteger _currentPageNum;
    //正在加载的状态
    BOOL _IS_LOADING;
    
    NSInteger _selectedIndex;
}

@end
