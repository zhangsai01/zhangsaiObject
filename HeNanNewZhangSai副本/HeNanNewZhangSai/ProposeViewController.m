//
//  ProposeViewController.m
//  HeNanNewZhangSai
//
//  Created by qianfeng001 on 16/1/22.
//  Copyright © 2016年 ZhangSai. All rights reserved.
//

#import "ProposeViewController.h"

@interface ProposeViewController ()
{
//    UITextField *_tf;
    UITextView *_tfTwo;
}
@end

@implementation ProposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
self.navigationItem.title = @"意见反馈";
//    
//    _tf =[[UITextField alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 20)];
//    
//    _tf.borderStyle = UITextBorderStyleRoundedRect;
//    _tf.placeholder = @"请输入手机号";
//    _tf.font = [UIFont systemFontOfSize:12];
//    _tf.clearButtonMode = UITextFieldViewModeAlways;
//    
    _tfTwo = [[UITextView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 100)];
    _tfTwo.font = [UIFont systemFontOfSize:14];
    _tfTwo.text = @"请输入内容";
    
    _tfTwo.layer.borderWidth = 1;
    _tfTwo.layer.cornerRadius = 10;
    _tfTwo.alpha = 0.5;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.frame =CGRectMake(self.view.frame.size.width/2-50, 220, 100, 50);
    [button addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    
    

//    [self.view addSubview:_tf];
    [self.view addSubview:_tfTwo];
    [self.view addSubview:button];
}
-(void)Click{
    
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$" options:NSRegularExpressionCaseInsensitive error:nil];
//    
//     NSTextCheckingResult *result = [regex firstMatchInString:_tf.text options:0 range:NSMakeRange(0, [_tf.text length])];
//    
//    if (!result) {
//        UIAlertController *ac =[UIAlertController alertControllerWithTitle:nil message:@"手机号有误" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:ac animated:YES completion:nil];
//        
//        [self performSelector:@selector(outHederTwo:) withObject:ac afterDelay:1];
//    }else{
        if (_tfTwo.text.length<6) {
            UIAlertController *ac =[UIAlertController alertControllerWithTitle:nil message:@"内容过短" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:ac animated:YES completion:nil];
            
            [self performSelector:@selector(outHederTwo:) withObject:ac afterDelay:1];
        }else{
 
    UIAlertController *ac =[UIAlertController alertControllerWithTitle:nil message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:ac animated:YES completion:nil];
            _tfTwo.text = @"请输入内容";
//            _tf.text = nil;

    [self performSelector:@selector(outHederTwo:) withObject:ac afterDelay:1];
    }

}

-(void)outHederTwo:(UIAlertController *)alert{
    
    [alert dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
