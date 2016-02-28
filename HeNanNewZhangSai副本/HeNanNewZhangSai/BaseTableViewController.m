//
//  BaseTableViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化数据源
    _dataArray =[[NSMutableArray alloc]init];
    //设置初始值
    _currentPageNum = 0;
    //初始值
    _IS_LOADING = NO;
    //初始值
    _getDataType = myGetDAtaTypeNomal;
    //加载数据
    [self.tableView headerBeginRefreshing];
    [self getdata];
    //设置刷新
    [self setRefresh];
    
    //注册cell
    
}

-(void)getdata{
    
}
#pragma make _下拉刷新，上拉加载
-(void)setRefresh{
    //添加下拉刷新事件
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    self.tableView.headerPullToRefreshText = @"继续下拉，进行刷新";
    self.tableView.headerRefreshingText = @"正在刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新完成";
    //添加上拉加载数据
    [self.tableView addFooterWithTarget:self action:@selector(FooterRefresh)];
    self.tableView.footerPullToRefreshText = @"继续上拉，进行刷新";
    self.tableView.footerRefreshingText = @"正在刷新";
    self.tableView.footerReleaseToRefreshText = @"松开刷新完成";
    
}


-(void)headerRefresh{
    _getDataType = myGetDAtaTypeHeaderRefresh;
    
    [self getdata];
}

-(void)FooterRefresh{
    _getDataType = myGetDAtaTypeFooterRefresh;
    [self getdata];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
