//
//  MymessageViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MymessageViewController.h"

#import "MyGetDataFunc.h"

#import "UIImageView+WebCache.h"

#import "messaViewController.h"

#import "MessageName.h"
@interface MymessageViewController ()

@end

@implementation MymessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"我的消息";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make -加载数据
-(void)getdata{
    
    if (_IS_LOADING) {
        return;
    }
    _IS_LOADING = YES;
    
    //获取第一页数据
    NSInteger needLoadpage;
    
    needLoadpage = _currentPageNum+1;
    if (_getDataType==myGetDAtaTypeHeaderRefresh) {
        needLoadpage=1;
    }
    __weak typeof (self) WeakSelf = self;
    //block回调
    [MyGetData getmessgetNewsAppsWithper:20 page:needLoadpage categoty:28 handler:^(NSArray * array, NSError *error,NSInteger number) {
        
        //设置加载状态
        _IS_LOADING = NO;
        //结束刷新状态视图
        //如果是上拉加载更多，应该结束上拉加载的界面
        if (_getDataType==myGetDAtaTypeFooterRefresh) {
            [self.tableView footerEndRefreshing];
        }
        //如果是下拉刷新，应该结束下拉刷新界面
        else if (_getDataType==myGetDAtaTypeHeaderRefresh){
            [self.tableView headerEndRefreshing];
        }
        //处理数据
        if (!error) {
            if (_getDataType==myGetDAtaTypeHeaderRefresh) {
                [_dataArray removeAllObjects];
            }
            //追加数据
            [_dataArray addObjectsFromArray:array];
            //计数器加一
            _currentPageNum = needLoadpage;
            //刷新界面
            [WeakSelf.tableView reloadData];
        }else{
            NSLog(@"error:%@",error);
        }
        //恢复初始状态
        _getDataType = myGetDAtaTypeNomal;
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    MessageName *model =_dataArray[indexPath.row];
    cell.textLabel.text = model.post_content;
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

//推出下一个视图控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageName *model =_dataArray[indexPath.row];
    
    messaViewController *viewcontroller =[[messaViewController alloc]initWithWeb:model.post_link];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

@end
