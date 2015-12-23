//
//  ThirdViewController.m
//  Wedding
//
//  Created by ma on 15-12-21.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdViewController.h"
//#import "MainNavigationViewController.h"
#import "ScrollViewDemo.h"
#import "ThirdNetWork.h"
#import "ThirdGeXiaoZuViewController.h"

#import "thirdLocalData.h"
#import "MBProgressHUD.h"

#define ThirdADUrl @"http://data.halobear.cn/mapi/index.php?act=banner&cate=1&adcode=(null)&mver=3"
#define TaoLunZuUrl @"http://circle.halobear.cn/api/mobile/index.php?module=forumnav&version=4&adcode=653000&mver=3"

@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;

@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * AdDataArray;
@property(nonatomic,strong)NSMutableArray * DataArray;



@end

@implementation ThirdViewController
//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(thirdADvertisementDataReturn:) name:@"ThirdADvertisementDataReturn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(thirdTaoLunZuDataReturn:) name:@"thirdTaoLunZuDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)thirdADvertisementDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    
    NSLog(@"%@",dic);
    self.AdDataArray = [NSMutableArray array];
    self.AdDataArray = dic[@"list"];
    [self settableViewHeaderScrollView];
}

-(void)thirdTaoLunZuDataReturn:(NSNotification *)noti{
    
//    [MBProgressHUD hideHUDForView:self.view];
    
    NSDictionary * dic0 = noti.object;
    NSDictionary * dic1 = dic0[@"Variables"];
    self.DataArray = dic1[@"forums"];
    //    NSLog(@"%@",self.DataArray);
    
    [self.myTableview reloadData];
    
//    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
    
    //***********************************
    NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
    [mdic setObject:self.DataArray forKey:@"list"];
    [thirdLocalData setLocalDataWithDic:mdic];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.DataArray = [NSMutableArray array];
    
    
    [self getLocalData];
    [self getData];
    
    //添加头部导航栏
    [self headView];
    
    [self setMyTableView];
    
//    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    
}

-(void)getLocalData{
    
    NSArray * localDataArray = [thirdLocalData GetLocalDataArray];
    [self.DataArray setArray:localDataArray];
    
}

-(void)getData{
    
    
    [ThirdNetWork getThirdAdDataWithUrl:ThirdADUrl];
    [ThirdNetWork getThirdFenZuDataWithUrl:TaoLunZuUrl];
    
}


/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = @"结 婚 圈";
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
    
    
}
/*********************************************/


#pragma mark ====== UI设计
-(void)setMyTableView{
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64)];
    //    self.myTableview.backgroundColor = [UIColor blueColor];
    self.myTableview.delegate = self;
    
    self.myTableview.dataSource = self;
    
    //    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    
    [self settableViewHeaderScrollView];
    
}

-(void)settableViewHeaderScrollView{
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    headerImageView.userInteractionEnabled = YES;
    
    ScrollViewDemo *svc = [[ScrollViewDemo alloc]init];
    
    //            NSArray *photoArray = @[@"Welcome_3.0_1.jpg",@"Welcome_3.0_2.jpg",@"Welcome_3.0_3.jpg",@"Welcome_3.0_4.jpg",@"Welcome_3.0_5.jpg"];
    
    NSMutableArray *photoArray = [NSMutableArray array];
    
    for (NSDictionary * dict in self.AdDataArray) {
        [photoArray addObject:dict[@"banner_logo"]];
    }
    
    //设置是否是用网络图片
    svc.isNotLocalImage = YES;
    
    //必须设置的图片数组
    svc.photoArray = photoArray;
    
    svc.pageControlHeight = 30;
    
    //必须写在view.frame设置之前
    svc.scrollViewFrame = CGRectMake(0, 0, headerImageView.frame.size.width, 150);
    
    svc.view.frame = CGRectMake(0, 0, headerImageView.frame.size.width, headerImageView.frame.size.height);
    
    [headerImageView addSubview:svc.view];
    
    [self addChildViewController:svc];
    
    self.myTableview.tableHeaderView = headerImageView;
    
}


//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count = %ld",self.DataArray.count);
    return self.DataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray * photoArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    static NSString * idetify = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:photoArray[indexPath.row]];
    cell.imageView.layer.cornerRadius = 25.0;
    cell.imageView.clipsToBounds = YES;
    cell.textLabel.text = self.DataArray[indexPath.row][@"name"];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.text = self.DataArray[indexPath.row][@"description"];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThirdGeXiaoZuViewController * thirdXZVc = [[ThirdGeXiaoZuViewController alloc]init];
    
    thirdXZVc.fid = self.DataArray[indexPath.row][@"fid"];
    thirdXZVc.index = indexPath.row + 1;
    [self.navigationController pushViewController:thirdXZVc animated:YES];
    
}

//***************************************************//



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
