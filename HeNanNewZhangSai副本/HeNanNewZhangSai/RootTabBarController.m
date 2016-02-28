//
//  RootTabBarController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/18.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseTableViewController.h"
#import "NewsViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController
-(instancetype)init{
    if (self =[super init]) {
        [self creatViewControllers];
    }
    return self;
}

-(void)creatViewControllers{
    
    NSArray *title = @[@"新闻",@"直播",@"快讯",@"我的"];
    NSArray *nameArray = @[@"News",@"TeleviseTable",@"Mymessage",@"MyAppTable"];
    NSArray *imagearray =@[@"home",@"zhibo",@"fenlei",@"heart"];
    NSMutableArray *cunstrollers =[NSMutableArray array];
    
    for (NSInteger i=0; i<title.count; i++) {
        
        if (i==0) {
            NewsViewController *bvc =[[NewsViewController alloc]init];
            bvc.navigationItem.title = title[i];
            
            NSString *imageName =[NSString stringWithFormat:@"iconfont-%@1",imagearray[i]];
            UIImage *image =[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            //选中时的图片
            NSString *selectedimageName =[NSString stringWithFormat:@"iconfont-%@2",imagearray[i]];
            UIImage *selectedImage =[[UIImage imageNamed:selectedimageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            UITabBarItem *item =[[UITabBarItem alloc]initWithTitle:title[i] image:image selectedImage:selectedImage];
            
            bvc.tabBarItem = item;
            UINavigationController *nc =[[UINavigationController alloc]initWithRootViewController:bvc];
            [cunstrollers addObject:nc];
            
        }else {
            
        NSString *name = [NSString stringWithFormat:@"%@ViewController",nameArray[i]];
        Class cls = NSClassFromString(name);
        
        BaseTableViewController *bvc =[[cls alloc]init];
        
//创建item。。正常的图片
        bvc.navigationItem.title = title[i];
        NSString *imageName =[NSString stringWithFormat:@"iconfont-%@1",imagearray[i]];
        UIImage *image =[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //选中时的图片
        NSString *selectedimageName =[NSString stringWithFormat:@"iconfont-%@2",imagearray[i]];
        UIImage *selectedImage =[[UIImage imageNamed:selectedimageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item =[[UITabBarItem alloc]initWithTitle:title[i] image:image selectedImage:selectedImage];
        
        bvc.tabBarItem = item;
        UINavigationController *nc =[[UINavigationController alloc]initWithRootViewController:bvc];
        [cunstrollers addObject:nc];
        }
  
   //统一设置颜色
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    
    //设置所管理的视图控制器
    self.viewControllers = cunstrollers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
