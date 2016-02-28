//
//  BaseTableViewController.h
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+MJRefresh.h"

#import "MyGetDataFunc.h"

typedef NS_ENUM(NSInteger,myGetDAtaType){
    //正常请求数据
    myGetDAtaTypeNomal = 0,
    //下拉刷新请求数据
    myGetDAtaTypeHeaderRefresh,
    //上拉加载更多请求数据
    myGetDAtaTypeFooterRefresh
};

@interface BaseTableViewController : UITableViewController<UISearchBarDelegate>
{
    //数据源
    NSMutableArray *_dataArray;
    //记录页数
    NSInteger _currentPageNum;
    //正在加载的状态
    BOOL _IS_LOADING;
    //加载数据的类型
    myGetDAtaType _getDataType;
    
}




@end
