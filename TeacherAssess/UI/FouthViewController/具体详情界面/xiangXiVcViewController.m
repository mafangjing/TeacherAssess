//
//  xiangXiVcViewController.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "xiangXiVcViewController.h"
#import "TQRichTextView.h"

@interface xiangXiVcViewController ()


@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)TQRichTextView * TQLable;

@property(nonatomic,strong)UIWebView * webview;

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@end

@implementation xiangXiVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加头部导航栏
    [self headView];
    
    [self setMyWebView];

}

/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 30)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
    
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.navBarImageView addSubview:lineImageView];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = @"详 细";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/

-(void)setMyWebView{

    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height - 64)];
    
    [self.webview loadHTMLString:self.concentString baseURL:nil];
    
    [self.view addSubview:self.webview];
    
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
