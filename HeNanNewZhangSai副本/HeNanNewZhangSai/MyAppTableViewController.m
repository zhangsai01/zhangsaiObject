//
//  MyAppTableViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "MyAppTableViewController.h"

#import "ApplysViewController.h"

#import "ProposeViewController.h"
@interface MyAppTableViewController ()
{
    NSMutableArray *_dataSource;
    UIView *_view;
}
@end

@implementation MyAppTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   //创建数据源
    [self createDataSource];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    [self creatView];
}

-(void)creatView{
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height/3)];
  
    
    self.tableView.tableHeaderView = _view;
    
//创建背景图
    UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height-20)];
    image.image =[UIImage imageNamed:@"back4.jpg"];
    
      [_view addSubview:image];
    
}

-(void)setRefresh{
    
}



-(void)createDataSource{
    _dataSource =[[NSMutableArray alloc]initWithObjects:@"快递查询",@"清除缓存",@"意见反馈", nil];

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

    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0==indexPath.row){
        ApplysViewController *app = [[ApplysViewController alloc]initWithWeb:@"http://m.kuaidi100.com/index_all.html"];
        
        [self.navigationController pushViewController:app animated:YES];

    }
    else if (1==indexPath.row){
        
        UIActivityIndicatorView *avi =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        avi.transform = CGAffineTransformMakeScale(1.5, 1.5);
        avi.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        avi.color = [UIColor blackColor];
        [avi startAnimating];
        [self.view addSubview:avi];
    
    [self performSelector:@selector(outHeder:) withObject:avi afterDelay:1];
        
    }else if (2==indexPath.row){
        
        ProposeViewController *propose =[[ProposeViewController alloc]init];
        [self.navigationController pushViewController:propose animated:NO];
    }
}

//清除时调用的方法  3==indexPath.row
-(void)outHeder:(UIActivityIndicatorView *)avi{
    
    [avi stopAnimating];
    
    
    NSFileManager *fikemanage = [[NSFileManager alloc]init];
    
    NSString *str =[NSString stringWithFormat:@"%@/Library/Caches/default/com.hackemist.SDWebImageCache.default",NSHomeDirectory()];
    
    NSLog(@"keke%@",NSHomeDirectory());
    
    float size = 0;
    NSArray *array = [fikemanage contentsOfDirectoryAtPath:str error:nil];
    for (int i=0; i<array.count; i++) {
        NSString *fullpath =[str stringByAppendingString:[array objectAtIndex:i]];
        
        BOOL isdic;
        
        if (!([fikemanage fileExistsAtPath:fullpath isDirectory:&isdic] && isdic)) {
            
            NSDictionary *fileAttributeDic = [fikemanage attributesOfItemAtPath:fullpath error:nil];
            
            size +=fileAttributeDic.fileSize/1024.0/1024.0;
        }
    }
    
    NSString *string =[NSString stringWithFormat:@"清除成功"];
    UIAlertController *ac =[UIAlertController alertControllerWithTitle:@"⚠️" message:string preferredStyle:UIAlertControllerStyleAlert];
    
     [self presentViewController:ac animated:YES completion:nil];
    
    if ([fikemanage fileExistsAtPath:str]) {
        NSArray *childerfiles =[fikemanage subpathsAtPath:str];
        for (NSString *filename in childerfiles) {
            NSString *absolutepath =[str stringByAppendingPathComponent:filename];
            [fikemanage removeItemAtPath:absolutepath error:nil];
        }
    }
    
    
    [self performSelector:@selector(outHederTwo:) withObject:ac afterDelay:1];
}

-(void)outHederTwo:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
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
