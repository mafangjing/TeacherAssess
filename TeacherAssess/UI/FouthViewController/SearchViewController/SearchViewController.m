//
//  SearchViewController.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "SearchViewController.h"
#import "FouthNetWork.h"
#import "FouthVcModel.h"
#import "SearchTableViewCell.h"
#import "FouthDetialViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton * rightButton;


@property(nonatomic,strong)UISearchBar * searchbar;
@property(nonatomic,strong)UITableView * myTableView;
@property(nonatomic,strong)NSMutableArray * DataArray;
@property(nonatomic,strong)NSDictionary * dic;
@property(nonatomic,assign)int page;

@end

@implementation SearchViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchDataReturn:) name:@"SearchDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark ---- 通知返回数据
-(void)SearchDataReturn:(NSNotification *)noti{
    self.dic = noti.object;
    NSLog(@"%@",self.dic);
//    self.DataArray = self.dic[@"partner"];
    [self.DataArray setArray:[FouthVcModel setBeanWithArray:self.dic[@"partner"]]];
    [self.myTableView reloadData];
}
//***************************************//


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.DataArray = [NSMutableArray array];
    
    //添加头部导航栏
    [self headView];
    [self setSearchBar];
    
    [self setTableView];
    

}

-(void)getdata{

    [FouthNetWork getSearchDataWithUrl:SearchUrl appkey:@"752" keyword:[self.searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

}

/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 30)];
    [self.leftButton setImage:[UIImage imageNamed:@"jumpmenuback.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = @"搜 索";
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
    
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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




#pragma mark ---- TableView
-(void)setTableView{
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 50, self.view.frame.size.width, self.view.frame.size.height - (64 + 50))];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchCell"];
    
}

#pragma mark --- tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%ld",(unsigned long)self.DataArray.count);
    return self.DataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idetify = @"searchCell";
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        
        
        cell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    [cell setCellWithBean:self.DataArray[indexPath.row]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FouthDetialViewController * FouthdetilaVC = [[FouthDetialViewController alloc]init];
    FouthdetilaVC.bean = self.DataArray[indexPath.row];
    [self.navigationController pushViewController:FouthdetilaVC animated:YES];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
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
