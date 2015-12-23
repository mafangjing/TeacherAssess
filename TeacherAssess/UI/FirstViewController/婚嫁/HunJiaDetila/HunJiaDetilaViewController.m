//
//  HunJiaDetilaViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunJiaDetilaViewController.h"
#import "TQRichTextView.h"
#import "FirstNetWork.h"

@interface HunJiaDetilaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * myTableview;
@property(nonatomic,strong)NSMutableDictionary * Datadic;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)TQRichTextView * CellXianShiView;

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

//*********************
@property(nonatomic,strong)UIView * headerView;
@property(nonatomic,strong)UILabel * titleLable;
@property(nonatomic,strong)UILabel * DateLable;

//*********************

@end

@implementation HunJiaDetilaViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(firsthunJiaDetilaDataReturn:) name:@"firsthunJiaDetilaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)firsthunJiaDetilaDataReturn:(NSNotification *)noti{
    self.Datadic = noti.object;
    NSLog(@"%@",self.Datadic);
    [self.myTableview reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Datadic = [NSMutableDictionary dictionary];
    
    [self getData];

    //添加头部导航栏
    [self headView];
    [self setTableView];
 


}

-(void)getData{

    [FirstNetWork getHunJiaDetilaDatawithurl:HunJiaDetilaUrl appkey:@"752" idi:self.lastDic[@"id"]];



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
    titleLable.text = @"详 情";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/

-(void)setTableView{
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    self.headImageView.image = [UIImage imageNamed:@"discoverz@2x.png"];
    [self.headImageView setImageWithURL:[NSURL URLWithString:self.lastDic[@"photo"]] placeholderImage:nil];
    
    self.myTableview.tableHeaderView = self.headImageView;
    
    
}

#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * idetify = @"hunjiaCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
    }
    /**************************************/

    NSString * oldString = self.Datadic[@"content"];
    NSString *newString0 =  [oldString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
     NSString *newString1 =  [newString0 stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    
    
    /**************************************/
    self.CellXianShiView = [[TQRichTextView alloc]initWithFrame:CGRectMake(5, 0, cell.frame.size.width - 10, 200)];
    self.CellXianShiView.backgroundColor = [UIColor whiteColor];
    self.CellXianShiView.font = [UIFont systemFontOfSize:16];
    self.CellXianShiView.text = newString1;
    CGRect r = self.CellXianShiView.frame;
    r.size.height = self.CellXianShiView.drawheigth;
    self.CellXianShiView.frame = r;
    [cell addSubview:self.CellXianShiView];
    /**************************************/

       return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.CellXianShiView.drawheigth;

}
//**********************************************

#pragma mark ===  返回一个组头的view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    //***************
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.headImageView.frame.size.width - (10 + 10), 20)];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.text = self.lastDic[@"name"];
    self.titleLable.font = [UIFont systemFontOfSize:16];
    [self.headerView addSubview:self.titleLable];
    //***************
    
    self.DateLable = [[UILabel alloc]init];
    self.DateLable.center = CGPointMake(self.headerView.frame.size.width/2, self.headerView.frame.size.height/2 + 15);
    self.DateLable.bounds = CGRectMake(0, 0, 150, 15);
    self.DateLable.textAlignment = NSTextAlignmentCenter;
    self.DateLable.text = self.lastDic[@"time"];
    self.DateLable.font = [UIFont systemFontOfSize:16];
    self.DateLable.textColor = [UIColor lightGrayColor];
    [self.headerView addSubview:self.DateLable];
    //*****************
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.headerView.frame.size.height - 1, self.headerView.frame.size.width - 15 - 15, 1)];
    imageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    [self.headerView addSubview:imageView];
    
    
    return self.headerView;
    
}

#pragma mark === 设置组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
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
