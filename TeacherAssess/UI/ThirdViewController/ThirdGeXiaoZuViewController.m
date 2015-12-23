//
//  ThirdGeXiaoZuViewController.m
//  Wedding
//
//  Created by qianfeng on 15-12-22.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "ThirdGeXiaoZuViewController.h"
#import "JHRefresh.h"
#import "ThirdDetilaFirstCellTableViewCell.h"
#import "ThirdDetilaScondCellTableViewCell.h"
#import "ThirdNetWork.h"
#import "ThirdGeXiaoZuDetilaViewController.h"
#import "JHRefreshConfig.h"

@interface ThirdGeXiaoZuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSDictionary * dict;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,copy)NSString * top;



@end

@implementation ThirdGeXiaoZuViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(thirdADvertisementDataReturn:) name:@"ThirdADvertisementDataReturn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(thirdDetilaDataReturn:) name:@"thirdDetilaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)thirdDetilaDataReturn:(NSNotification *)noti{
    
    
    if (self.page == 1) {
       
        NSDictionary * dic = noti.object;
        self.dataArray = dic[@"Variables"][@"forum_threadlist"];
        self.dict = dic[@"Variables"][@"forum"];
        
        [self.myTableview reloadData];
        
        //收起下拉视图
        [self.myTableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }else{
    
        NSDictionary * dic = noti.object;
        NSDictionary * dic1 = dic[@"Variables"];
        NSArray * array = dic1[@"forum_threadlist"];
        
        for (NSDictionary * dicts in array) {
            
            [self.dataArray addObject:dicts];

        }
    
        [self.myTableview reloadData];
        //收起上拉视图
        [self.myTableview footerEndRefreshing];
    }
    NSLog(@"%@",self.dataArray);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //*******************************
    self.dataArray = [NSMutableArray array];
    self.dict = [NSDictionary dictionary];
    self.page = 1;
    self.top = @"1";
    
    
    //*******************************

    [self getdata];
    
    
    //添加头部导航栏
    [self headView];
    [self setmytableView];
    

}


-(void)getdata{

    [ThirdNetWork getThirdDetilaDataWithfid:self.fid top:self.top page:[NSString stringWithFormat:@"%ld",self.page] orderby:@"dateline" mver:@"3"];

}




/*********************************************/
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 30)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
    

}
-(void)leftbutClick{

    [self.navigationController popViewControllerAnimated:YES];

}
/*********************************************/

-(void)setmytableView{


    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.backgroundColor = [UIColor colorWithRed:241/256.0 green:241/256.0 blue:241/256.0 alpha:1];
    self.myTableview.delegate = self;
    
    self.myTableview.dataSource = self;
    
        self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    
    //注册一个cell
    [self.myTableview registerNib:[UINib nibWithNibName:@"ThirdDetilaFirstCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells1"];
    [self.myTableview registerNib:[UINib nibWithNibName:@"ThirdDetilaScondCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cells2"];
    
    
    //添加下拉刷新列表
    __weak ThirdGeXiaoZuViewController * sself = self;
    [self.myTableview addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        sself.page = 1;
        sself.top = @"1";
        //刷新数据
        [sself getdata];
    }];
    
    //添加上拉获取更多
//    [self.myTableview addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
//    
//        sself.page ++;
//        sself.top = @"0";
//        [sself getdata];
//    }];

}
//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count = %ld",self.dataArray.count);
    return self.dataArray.count + 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        static NSString * idetify = @"cells1";
        ThirdDetilaFirstCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
        if (cell == nil) {
            cell = [[ThirdDetilaFirstCellTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWithDic:self.dict index:self.index];
        
        return cell;
        
    }else{
    
        static NSString * idetify = @"cells2";
        ThirdDetilaScondCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
        if (cell == nil) {
            cell = [[ThirdDetilaScondCellTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell setCellWithDict:self.dataArray[indexPath.row - 1]];
        
        cell.backgroundColor = [UIColor colorWithRed:241/256.0 green:241/256.0 blue:241/256.0 alpha:1];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }else{
    
        return 100;
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ThirdGeXiaoZuDetilaViewController * thirddetilaVC = [[ThirdGeXiaoZuDetilaViewController alloc]init];

    if (indexPath.row != 0) {
        
        thirddetilaVC.lastDic = self.dataArray[indexPath.row- 1];
        
        [self.navigationController pushViewController:thirddetilaVC animated:YES];
        
    }
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
