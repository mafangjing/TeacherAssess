//
//  SecondViewController.m
//  Wedding
//
//  Created by hjh on 15-10-2.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondMainTableViewCell.h"
#import "SecondNetWork.h"
#import "SecondVcModel.h"
#import "SecondDetilaViewController.h"
#import "SecondLocalData.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

{

    NSDictionary * _dic;
    
}


@property(nonatomic,strong)UIImageView *navBarImageView;

@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,assign)int page;


@end

@implementation SecondViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SecondDataReturn:) name:@"SecondDataReturn" object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)SecondDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
//    NSLog(@"%@",dic);
    
    if (self.page == 1) {
        //关闭活动指示器
        [MBProgressHUD hideHUDForView:self.view];

        
        [self.dataArray setArray:[SecondVcModel setBeanWithArray:dic[@"subjects"]]];
        
//        NSLog(@"%@",self.dataArray);
        
        [self.myTableview reloadData];
        
        //收起下拉刷新视图
        [self.myTableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        //活动指示器
        [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
        
        
        //**************写入数据库做缓存 *************
        NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
        [mdic setObject:dic[@"subjects"] forKey:@"list"];
        
        [SecondLocalData setLocalDataWithDic:mdic];
        
        
        
        
    }else{
    
        NSArray * arr = [SecondVcModel setBeanWithArray:dic[@"subjects"]];
        
        for (SecondVcModel * mo in arr) {
            
            [self.dataArray addObject:mo];
        }
        
        [self.myTableview reloadData];
        //收起上拉加载视图
        [self.myTableview footerEndRefreshing];
        
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    
    self.page = 1;
    
    
    [self getData];
    
    //添加头部导航栏
    [self headView];
    
    [self setMyTableView];
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];

}

-(void)getData{
    
    
    NSArray * LocalDataAray = [SecondLocalData GetLocalDataArray];
    
    [self.dataArray setArray:[SecondVcModel setBeanWithArray:LocalDataAray]];
    

    [SecondNetWork getSecondDataWithUrl:@"http://www.hunliji.com/subjects.json" withPage:[NSString stringWithFormat:@"%d",self.page]];
    
//    void(^block)(NSDictionary *) = ^(NSDictionary * dict){
//    
//        _dic = dict;
//    
//    };
//    
//    [SecondNetWork getSecondDataWithUrl:@"http://www.hunliji.com/subjects.json" withPage:@"1" WithBlock:block];
//   
//    NSLog(@"_dic = %@",_dic);

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
    titleLable.text = @"发 现";
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
    
    
}
/*********************************************/
#pragma mark ====== UI设计
-(void)setMyTableView{
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"SecondMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"Secondcell"];
    
    
    //添加下拉刷新列表
    __weak SecondViewController * sself = self;
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
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * ce = (UITableViewCell *)[self.myTableview viewWithTag:10];
    [ce removeFromSuperview];
    
    //*************************************************
    
        static NSString *firstCellindextify = @"Secondcell";
        
        SecondMainTableViewCell * Secondcell = [tableView dequeueReusableCellWithIdentifier:firstCellindextify];
        if (Secondcell == nil) {
            
            Secondcell = [[SecondMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellindextify];
            Secondcell.tag = 10;
    }
    
    Secondcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [Secondcell setCellWithBean:self.dataArray[indexPath.row]];
    
     return Secondcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondDetilaViewController * SecondDetilaVC = [[SecondDetilaViewController alloc]init];
    
    SecondDetilaVC.secMo = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:SecondDetilaVC animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190;
    
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
