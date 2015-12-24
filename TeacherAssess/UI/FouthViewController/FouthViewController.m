//
//  FouthViewController.m
//  Wedding
//
//  Created by ma on 15-12-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "FouthViewController.h"
#import "FouthTableViewCell.h"
#import "FouthNetWork.h"
#import "FouthVcModel.h"
#import "FouthDetialViewController.h"
#import "SearchViewController.h"
#import "FouthLocalData.h"

@interface FouthViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)UILabel * firstLable;
@property(nonatomic,strong)UILabel * secondLable;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,assign)int page;


@end

@implementation FouthViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(thirdADvertisementDataReturn:) name:@"ThirdADvertisementDataReturn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FouthDataReturn:) name:@"FouthDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark ---- 通知返回数据
-(void)FouthDataReturn:(NSNotification *)noti{
    
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);

    
    if (self.page == 0) {
       
        
        [self.dataArray setArray:[FouthVcModel setBeanWithArray:dic[@"partner"]]];
        NSLog(@"%@",self.dataArray);
        [self.myTableview reloadData];
        
        if (self.dataArray.count > 0) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
        }
        
        //收起下拉刷新视图
        [self.myTableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        //**************写入数据库做缓存 *************
        NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
        [mdic setObject:dic[@"partner"] forKey:@"list"];
        
        [FouthLocalData setLocalDataWithDic:mdic];

        
    }else{
    
        NSArray * arr = [FouthVcModel setBeanWithArray:dic[@"partner"]];
        
        for (FouthVcModel * mo in arr) {
            
            [self.dataArray addObject:mo];
        }
        
        [self.myTableview reloadData];
        //收起上拉加载视图
        [self.myTableview footerEndRefreshing];
        
    }

}
//***************************************//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //***************************************//
    self.dataArray = [NSMutableArray array];
    self.page = 0;
    
    //***************************************//

    [self getLocalData];
    [self getdata];
    
    
    //添加头部导航栏
    [self headView];
    
    [self setmyTableView];
   
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];

}

-(void)getLocalData{

    NSArray * LocalDataAray = [FouthLocalData GetLocalDataArray];
    [self.dataArray setArray:[FouthVcModel setBeanWithArray:LocalDataAray]];

}

-(void)getdata{
    
    [FouthNetWork getFouthdataWithUrl:@"http://lscy4.caeac.com.cn/api/partner.php" appkey:@"752" page:[NSString stringWithFormat:@"%d",self.page] pid:@"0"];


}

/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    //搜索button
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.navBarImageView.frame.size.width - 50,30 , 25, 25)];
    [self.rightButton setImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(RightButtonClick)  forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.rightButton];
    
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.navBarImageView addSubview:lineImageView];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = @"商 铺";
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
    
    
}

-(void)RightButtonClick{
    NSLog(@"搜索店铺");
    SearchViewController * searchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];
    
}

//***************************************************//
#pragma mark ====== UI设计
-(void)setmyTableView{

    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.frame.size.height - 64 - 49)];
    self.myTableview.delegate = self;
    
    self.myTableview.dataSource = self;
    
    [self.view addSubview:self.myTableview];
    
    //注册一个cell
    [self.myTableview registerNib:[UINib nibWithNibName:@"FouthTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];

    
    //添加下拉刷新列表
    __weak FouthViewController * sself = self;
    [self.myTableview addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        sself.page = 0;
        
        //刷新数据
        [sself getdata];
    }];
    
    
        //添加上拉获取更多
        [self.myTableview addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            
            sself.page = 1;
            
            [sself getdata];
        }];
    
}

//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count = %ld",self.dataArray.count);
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * idetify = @"cellID";
    FouthTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        cell = [[FouthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellWithBean:self.dataArray[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 90;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    FouthDetialViewController * FouthdetilaVC = [[FouthDetialViewController alloc]init];
    FouthdetilaVC.bean = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:FouthdetilaVC animated:YES];
    
    
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//}



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
