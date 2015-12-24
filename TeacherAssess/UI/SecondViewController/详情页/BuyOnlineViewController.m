//
//  BuyOnlineViewController.m
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "BuyOnlineViewController.h"

@interface BuyOnlineViewController ()<UIWebViewDelegate>


@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)UIWebView * WebView;


@end

@implementation BuyOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.lastDic);
    
    //添加头部导航栏
    [self headView];

    [self createWebView];

}

/*********************************************/
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 25)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = @"欢 迎 您";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*********************************************/

-(void)createWebView{

    self.WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    self.WebView.delegate = self;
    
    [self.view addSubview:self.WebView];

    
    NSURLRequest * requestUrl = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.lastDic[@"buy_url"]]];
    
    [self.WebView loadRequest:requestUrl];


}
//***************************************
#pragma mark - webViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败调用的方法");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完成");
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"网页开始加载");
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
