//
//  MyTeleVTableViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/21.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyTeleVTableViewController.h"
#import "MyUrlsession.h"

#import "TeViewModel.h"

#import "Two2TableViewCell.h"

#import "Two3TableViewCell.h"

#import "UIScrollView+MJRefresh.h"

#import "UIImageView+WebCache.h"

@interface MyTeleVTableViewController ()
{
    NSString *_str;
    NSInteger _page;
    NSMutableArray *_arrayData;
}
@end

@implementation MyTeleVTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayData =[[NSMutableArray alloc]init];
   
    [self getdate];
    
   [self.tableView registerNib:[UINib nibWithNibName:@"Two2TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Two3TableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    
}
-(id)initWithpage:(NSInteger)page Nsstring:(NSString *)str{
    if (self = [super init]) {
        _str = str;
        _page = page;
    }
    return self;
}

-(void)getdate{
    NSString *DataStr = [NSString stringWithFormat:@"http://khd.shangbw.com/api/zhibo/reply.ashx?action=list&per=20&page=%ld&category=%ld",_page,[_str integerValue]];
        NSLog(@"%@",DataStr);
    
    [[MyUrlsession defaultSession]accessServerWithUrlStr:DataStr andHandler:^(NSData *data, NSError *error) {
        if (!error) {
            TeViewModel *models =[[TeViewModel alloc]initWithData:data error:&error];
            if (!error) {
                [_arrayData addObjectsFromArray:models.data];
            }
        }
        [self.tableView reloadData];
        
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Temodels *model = _arrayData[indexPath.row];
    
    CGRect rect=[model.Rcont boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width-50, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
    
    if ([model.Rurl isEqualToString:@""]) {
        return rect.size.height+35;
    }
    
    return rect.size.height+(self.tableView.frame.size.width-120)*3/5+60;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _arrayData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[[UITableViewCell alloc]init];
   
    Temodels *model = _arrayData[indexPath.row];
    if ([model.Rurl isEqualToString:@""]) {
        Two3TableViewCell *cellId =[tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
        cellId.nameLab.text = model.UserName;
        cellId.timeLab.text = model.Createtime;
        cellId.txtlab.text = model.Rcont;
        
        cellId.selectionStyle = UITableViewCellSelectionStyleNone;
        return cellId;
    }else{
         Two2TableViewCell *cellid = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
        cellid.NameLab.text = model.UserName;
        cellid.timeLab.text = model.Createtime;
        cellid.txtLab.text = model.Rcont;
        [cellid.PicLab sd_setImageWithURL:[NSURL URLWithString:model.Rurl] placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
        
        cellid.selectionStyle = UITableViewCellSelectionStyleNone;
        return cellid;
    }
    
    
    
    return cell;
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
