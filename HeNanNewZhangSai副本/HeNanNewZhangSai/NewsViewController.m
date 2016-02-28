//
//  NewsViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/20.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "NewsViewController.h"

#import "NewModels.h"

#import "newsView.h"

#import "UIImageView+WebCache.h"

#import "TableViewCellOne.h"

typedef NS_ENUM(NSInteger,myGetDAtaType){
    //正常请求数据
    myGetDAtaTypeNomal = 0,
    //下拉刷新请求数据
    myGetDAtaTypeHeaderRefresh,
    //上拉加载更多请求数据
    myGetDAtaTypeFooterRefresh
};

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *_ScrollView;
    UITableView *_TableView;
    //加载数据的类型
    myGetDAtaType _getDataType;
    //参数
    NSInteger _category;
  
    UIScrollView *_ScrollViewBig;
    
    NSMutableArray *_heandarray;
    
    
//用于存储头部滚动视图网址，实现点击跳转
    NSMutableArray *_HandName;
    
    NSInteger _number;
    
//    UIPageControl *_pageControl;
    
//    UIView *_uiview;
    
    
    UIActivityIndicatorView *_avi;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _heandarray =[[NSMutableArray alloc]init];
    //实例化数据源
    _dataArray =[[NSMutableArray alloc]init];
    //设置初始值
    _currentPageNum = 0;
    //初始值
    _IS_LOADING = NO;
    //初始值
    _getDataType = myGetDAtaTypeNomal;
    //加载数据
     _selectedIndex=0;
    //设置刷新

  
    _HandName =[[NSMutableArray alloc]init];
    
    
    
    [self creatTableView];
      [self setRefresh];
    [_TableView headerBeginRefreshing];
    [self getdatacategory:674];
    
    [self creatIndicatorView];
    
}

-(void)creatIndicatorView{
    _avi =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    _avi.color =[UIColor whiteColor];
    
    _avi.frame = CGRectMake(self.view.frame.size.width-50,10, 20, 20);
    
    [self.navigationController.navigationBar addSubview:_avi];
}


//刷新，请求数据
-(void)getdatacategory:(NSInteger)category{
    _category = category;
    if (_IS_LOADING) {
        return;
    }
    _IS_LOADING = YES;
    
    NSInteger needLoadpage;
    needLoadpage = _currentPageNum+1;
    if (_getDataType==myGetDAtaTypeHeaderRefresh) {
        needLoadpage = 1;
    }
    
    //block回调
    [MyGetData getHeadNewsAppsWithper:20 page:needLoadpage categoty:category handler:^(NSArray *array, NSError *error,NSInteger number) {
        
        _IS_LOADING = NO;
        if (_getDataType==myGetDAtaTypeFooterRefresh) {
            [_TableView footerEndRefreshing];
        }else if (_getDataType==myGetDAtaTypeHeaderRefresh){
            [_TableView headerEndRefreshing];
        }
        
        if (!error) {
            if (_getDataType==myGetDAtaTypeHeaderRefresh) {
                [_dataArray removeAllObjects];
            }
            
//创建保存数据的数组
            NSMutableArray *heandarray =[[NSMutableArray alloc]init];
            
//提取出需要的数据
            for (NewModels *model in array) {
                
                if ([model.post_hd isEqualToString:@""]) {
                    [_dataArray addObject:model];
                }else if ([model.post_hd isEqualToString:@"1"]){
                    [heandarray addObject:model];
                }
            }
//如果有数据，不添加，不调用，目的是，避免下拉刷新，上拉加载的重复，调用
            if (_heandarray.count<1) {
                [_heandarray addObjectsFromArray:heandarray];
                [self creatHeadScrollView];
            }
            
//删除用于转换数组中的内容
            [heandarray removeAllObjects];
            
            _currentPageNum=needLoadpage;
            
            [_TableView reloadData];
        }else{
            NSLog(@"error:%@",error);
        }
        _getDataType =myGetDAtaTypeNomal;
    }];
}

//创建button
-(void)viewDidAppear:(BOOL)animated{
    if (!_ScrollView) {
        [self creatScorView];
        
        [self creatScrollViewButton];

    }else{
        return;
    }

}

-(void)creatScorView{
    _ScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];

    [self.view addSubview:_ScrollView];
}

-(void)creatTableView{
    _TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置数据源代理
    _TableView.dataSource = self;
    //设置代理
    _TableView.delegate = self;
    
//注册
    [_TableView  registerNib:[UINib nibWithNibName:@"One2TableViewCell" bundle:nil] forCellReuseIdentifier:@"one2CellId"];
    
    [_TableView  registerNib:[UINib nibWithNibName:@"TableViewCellOne" bundle:nil] forCellReuseIdentifier:@"one1CellId"];
    
    [self.view addSubview:_TableView];
    
    
//    _uiview = [[UIView alloc]initWithFrame:CGRectMake(10,0, self.view.frame.size.width-20, 150)];
 
    _ScrollViewBig = [[UIScrollView alloc]initWithFrame:CGRectMake(10,0, self.view.frame.size.width-20, 150)];
    
    _ScrollViewBig.autoresizesSubviews = YES;
    
    _TableView.tableHeaderView = _ScrollViewBig;
//    [_uiview addSubview:_ScrollViewBig];
    
}

//创建头条滚动视图
-(void)creatHeadScrollView{
    while (1) {
        UIImageView *view =[_ScrollView viewWithTag:1000];
        if (view) {
            [view removeFromSuperview];
        }else{
            break;
        }
        
    }
    
    
    
      [_HandName removeAllObjects];
    CGSize size = _ScrollViewBig.frame.size;
    
    
    
    
    
    for (int i=0; i<_heandarray.count; i++) {
        NewModels *model =_heandarray[i];
        
        UIImageView *iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(i*size.width, 0, size.width, size.height)];
        
        //下载图片
        [iamgeview sd_setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
        
           [_HandName addObject:model.post_link];
//在图片上添加手势，实现点击跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
        iamgeview.tag = i+1;
        [iamgeview addGestureRecognizer:tap];
        iamgeview.userInteractionEnabled = YES;
        iamgeview.tag = 1000;
        
        [_ScrollViewBig addSubview:iamgeview];
        
        //创建label
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10,_ScrollViewBig.frame.size.height-20, 200, 20)];
        label.text = model.post_title;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        [iamgeview addSubview:label];
        
}
    _ScrollViewBig.contentSize = CGSizeMake(_heandarray.count*size.width, size.height);
   _ScrollViewBig.pagingEnabled = YES;
    _ScrollViewBig.delegate = self;
    
//创建page
    
//    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(_uiview.frame.size.width-100, _uiview.frame.size.height-50, 100, 50)];
//    _pageControl.numberOfPages = _heandarray.count;
//    _pageControl.currentPageIndicatorTintColor =[UIColor greenColor];
//    _pageControl.pageIndicatorTintColor =[UIColor blueColor];
    
//    [_uiview addSubview:_pageControl];
}

//Scroller的代理方法
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    _pageControl.currentPage = _ScrollViewBig.contentOffset.x/_ScrollViewBig.frame.size.width;
//}



-(void)tapHandle:(UITapGestureRecognizer *)tap{
    NSString *str = [[NSString alloc]init];

    
    if (tap.view.tag==1) {
        str =_HandName[0];
    }else if (tap.view.tag==2){
        str=_HandName[1];
    }else if (tap.view.tag==3){
        str=_HandName[2];
    }
    newsView *view =[[newsView alloc]initWithWeb:str];
    
    [self.navigationController pushViewController:view animated:YES];
}

-(void)creatScrollViewButton{
    NSArray *array =@[@"头条",@"豫言",@"政情",@"女人",@"民情",@"幽默",@"美文",@"美图"];
    CGSize Size = _ScrollView.frame.size;
    for (NSInteger i=0; i<array.count; i++) {
        
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*Size.width/5, 0, Size.width/5, Size.height);
        [button setTitle:array[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        
        button.tag = i+100;
        if (i==0) {
            button.selected = YES;
          
            _selectedIndex = button.tag;
        }
        [button addTarget:self action:@selector(buttonHandle:) forControlEvents:UIControlEventTouchUpInside];
        
        [_ScrollView addSubview:button];
        _ScrollView.contentSize = CGSizeMake(array.count*Size.width/5, 0);
    }
}

-(void)buttonHandle:(UIButton *)button{
    if (_selectedIndex==button.tag) {
        return;
    }
    UIButton *selectedButton =(UIButton *)[self.view viewWithTag:_selectedIndex];
    selectedButton.selected = NO;
    
    button.selected = YES;
    
    [_avi startAnimating];

    //重新启用数据
    if (button.tag==100) {
        _selectedIndex = button.tag;
        _number = 674;
        [self getdata:674];
        
    }else if (button.tag==101){
        _selectedIndex = button.tag;
        _number = 675;

        [self getdata:675];
        
    }else if (button.tag==102){
        _selectedIndex = button.tag;
        _number = 1973;

        [self getdata:1973];
        
    }else if (button.tag==103){
        
        if (_selectedIndex<button.tag) {
            [_ScrollView setContentOffset:CGPointMake(self.view.frame.size.width/5*3, 0) animated:YES];
        }else if (_selectedIndex>button.tag) {
            [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
             _selectedIndex = button.tag;
        _number = 2037;

        [self getdata:2037];

    }else if (button.tag==104){
        
        if (_selectedIndex>button.tag) {
            [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (_selectedIndex<button.tag) {
            [_ScrollView setContentOffset:CGPointMake(self.view.frame.size.width/5*3, 0) animated:YES];
        }
        _number = 2038;

         [self getdata:2038];
        
          _selectedIndex = button.tag;
        
    }else if (button.tag==105){
        _selectedIndex = button.tag;

        _number = 2039;

        [self getdata:2039];
        
    }else if (button.tag==106){
        _selectedIndex = button.tag;

        _number = 2040;

        [self getdata:2040];
        
    }else if (button.tag==107){
        _selectedIndex = button.tag;
        
        _number = 677;
        [self getdata:677];
    }
}

//刷新，请求数据
-(void)getdata:(NSInteger)category{
    
    _category = category;
    
    
       //block回调
    [MyGetData getHeadNewsAppsWithper:20 page:1 categoty:category handler:^(NSArray *array, NSError *error,NSInteger number) {
        
        if (!error) {
            if (_number!=number){
                return ;
            }
           //清空原数组数据
            [_heandarray removeAllObjects];
            
            [_dataArray removeAllObjects];
            [_TableView headerBeginRefreshing];

            
//提取出需要的数据
            for (NewModels *model in array) {
                
                if ([model.post_hd isEqualToString:@""]) {
                    [_dataArray addObject:model];
                }else if ([model.post_hd isEqualToString:@"1"]){
                    [_heandarray addObject:model];
                    
                }
            }
            
            [_TableView reloadData];
            
            [self creatHeadScrollView];
            
            [_avi stopAnimating];
            
            [_TableView headerEndRefreshing];
            
        }else{
            NSLog(@"error:%@",error);
        }
    }];
    
}

#pragma make _下拉刷新，上拉加载
-(void)setRefresh{
    //添加下拉刷新事件
    [_TableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    _TableView.headerPullToRefreshText = @"继续下拉，进行刷新";
    _TableView.headerRefreshingText = @"正在刷新";
    _TableView.headerReleaseToRefreshText = @"松开刷新完成";
    //添加上拉加载数据
    [_TableView addFooterWithTarget:self action:@selector(FooterRefresh)];
    _TableView.footerPullToRefreshText = @"继续上拉，进行刷新";
    _TableView.footerRefreshingText = @"正在刷新";
    _TableView.footerReleaseToRefreshText = @"松开刷新完成";
    
}

-(void)headerRefresh{
    
    //做判断决定_category 的值
    _getDataType = myGetDAtaTypeHeaderRefresh;
    [self getdatacategory:_category];
}

-(void)FooterRefresh{
    
    _getDataType = myGetDAtaTypeFooterRefresh;
    [self getdatacategory:_category];
}



#pragma make-代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 70;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    
    NewModels *model =_dataArray[indexPath.row];
    
    if (model.pics.length>10) {
      
        TableViewCellOne *one1cell =[tableView dequeueReusableCellWithIdentifier:@"one1CellId" forIndexPath:indexPath];
        
        NSArray *array = [model.pics componentsSeparatedByString:@"|"];
     
        CGFloat wid = 10;
        CGFloat width =(one1cell.frame.size.width-(wid*array.count+1))/3;
        
        for (int i=0; i<array.count; i++) {
            
            UIImageView *view = [[UIImageView alloc]init];
            view.frame = CGRectMake(5+i*(width+wid), 5,width,one1cell.frame.size.height-5);
            [view sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]];
            view.userInteractionEnabled = YES;
            
            [one1cell addSubview:view];
            
        }
        return one1cell;
    }else {
        One2TableViewCell *onecell =[tableView dequeueReusableCellWithIdentifier:@"one2CellId" forIndexPath:indexPath];
        [onecell updataCellWithModel:model];
        
        return onecell;
    }
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NewModels *model =_dataArray[indexPath.row];
    newsView *view =[[newsView alloc]initWithWeb:model.post_link];
    
    [self.navigationController pushViewController:view animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
