//
//  TeleviseTableViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "TeleviseTableViewController.h"

#import "TwoTableViewCell.h"

#import "MyGetDataFunc.h"

#import "UIImageView+WebCache.h"

#import "MyTeleVTableViewController.h"

@interface TeleviseTableViewController ()

@end

@implementation TeleviseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
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
    [MyGetData getNewsAppsWithper:20 page:needLoadpage categoty:1800 handler:^(NSArray *array, NSError *error,NSInteger number) {
   
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    TeleviseModel *model =_dataArray[indexPath.row];
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
    cell.titleLab.text = model.post_title;
    cell.txtLab.text = model.post_content;

    return cell;
}

//推出下一个视图控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeleviseModel *model =_dataArray[indexPath.row];
    
    MyTeleVTableViewController *viewcontroller =[[MyTeleVTableViewController alloc]initWithpage:_currentPageNum Nsstring:model.post_excerpt];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
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
