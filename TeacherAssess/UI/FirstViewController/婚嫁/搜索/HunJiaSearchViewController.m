//
//  HunJiaSearchViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunJiaSearchViewController.h"
#import "HunJiaTableViewCell.h"
#import "HunJiaDetilaViewController.h"
#import "FirstNetWork.h"


@interface HunJiaSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)UITableView * myTableview;
@property(nonatomic,strong)NSMutableArray * DataArray;
@property(nonatomic,strong)UISearchBar * searchbar;


@end

@implementation HunJiaSearchViewController



//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HunJiaSearchDataReturn:) name:@"HunJiaSearchDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark ---- 通知返回数据
-(void)HunJiaSearchDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    [self.DataArray setArray:dic[@"array"]];
    
    [self.myTableview reloadData];
}
//***************************************//



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //添加头部导航栏
    [self headView];
    [self setSearchBar];

    
    [self setTableView];

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
    
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.navBarImageView addSubview:lineImageView];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.text = @"搜 索";
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/*********************************************/

#pragma mark --- 搜索栏
-(void)setSearchBar{
    
    self.searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    self.searchbar.placeholder = @"在这里输入搜索内容！";
    self.searchbar.showsCancelButton = YES;
    self.searchbar.delegate = self;
    [self.view addSubview:self.searchbar];
    
    
}

#pragma mark ---- searchBardelegate
//点击取消按钮时返回的回调
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    //收回searchBar栏目的激活状态
    [searchBar resignFirstResponder];
    
}
//点击搜索按钮时返回的回调
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"%@",searchBar.text);
    
    //收回searchBar栏目的激活状态
    [searchBar resignFirstResponder];
    
    //点击搜索按钮时发网络请求
    [self getdata];
}

-(void)getdata{
    
    [FirstNetWork GetHUnJiaSearchDataWithUrl:@"http://lscy4.caeac.com.cn/api/news.php" appkey:@"752" keyword:[self.searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
}
//**********************************

-(void)setTableView{
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 50, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    //    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"HunJiaTableViewCell" bundle:nil] forCellReuseIdentifier:@"hunjiaCell"];
    
}

//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.DataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * idetify = @"hunjiaCell";
    HunJiaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        cell = [[HunJiaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setcellwithDic:self.DataArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HunJiaDetilaViewController * HunjiadetilaVc = [[HunJiaDetilaViewController alloc]init];
    HunjiadetilaVc.lastDic = self.DataArray[indexPath.row];
    [self.navigationController pushViewController:HunjiadetilaVc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
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
