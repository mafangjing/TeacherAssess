//
//  GengDuoShiPingViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "GengDuoShiPingViewController.h"
#import "HLSPTableViewCell.h"
#import "ShipinViewController.h"
#import "FirstNetWork.h"

@interface GengDuoShiPingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)NSMutableArray * DataArray;
@property(nonatomic,strong)UITableView *myTableview;

@property(nonatomic,assign)int page;

@end

@implementation GengDuoShiPingViewController


//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GengDuoShiPingDataReturn:) name:@"GengDuoShiPingDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)GengDuoShiPingDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSArray * arr = dic[@"list"];
    if (self.page == 1) {
        
        [self.DataArray setArray:arr];
        
        [self.myTableview reloadData];
        //收起下拉视图
        [self.myTableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }else{
    
        for (NSDictionary * dict in arr) {
            
            [self.DataArray addObject:dict];
            
        }
    
        [self.myTableview reloadData];
        //收起上拉视图
        [self.myTableview footerEndRefreshing];
    
    }
}
//***************************************************


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.DataArray = [NSMutableArray array];
    [self getData];
    //添加头部导航栏
    [self headView];
    [self setMyTableView];

}

-(void)getData{

    [FirstNetWork getGengDuoShiPingDataWithUrl:GengDuoShiPingUrl act:@"hxjxlist" type:@"jxsp" mver:@"3" page:[NSString stringWithFormat:@"%d",self.page] pageper:@"10"];

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
    titleLable.text = @"精选视屏";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//***************************************************//
#pragma mark ====== UI设计
-(void)setMyTableView{
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"HLSPTableViewCell" bundle:nil] forCellReuseIdentifier:@"gdhlspcell"];
    
    
    //添加下拉刷新列表
    __weak GengDuoShiPingViewController * sself = self;
    [self.myTableview addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        sself.page = 1;
        //刷新数据
        [sself getData];
    }];
    
    //添加上拉获取更多
        [self.myTableview addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
    
            sself.page ++;
            [sself getData];
        }];

    
}

//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count = %ld",self.DataArray.count);
    return self.DataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * idetify = @"gdhlspcell";
    HLSPTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        cell = [[HLSPTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    
    //***************************************
    cell.mainImageView.layer.cornerRadius = 10.0;
    cell.mainImageView.clipsToBounds = YES;
    
    cell.imageView1.layer.cornerRadius = 5.0;
    cell.imageView1.clipsToBounds = YES;
    
    cell.imageView2.layer.cornerRadius = 5.0;
    cell.imageView2.clipsToBounds = YES;
    
    cell.imageView3.layer.cornerRadius = 5.0;
    cell.imageView3.clipsToBounds = YES;
    //***************************************
    
    
    [cell setCellWithDic:self.DataArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShipinViewController * shiPingVc = [[ShipinViewController alloc]init];
    
    shiPingVc.hxjx = self.DataArray[indexPath.row][@"hxjx_id"];
    [self.navigationController pushViewController:shiPingVc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
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
