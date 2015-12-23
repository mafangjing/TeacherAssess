//
//  HunJiaViewController.m
//  Wedding
//
//  Created by hjh on 15-10-8.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunJiaViewController.h"
#import "HunJiaTableViewCell.h"
#import "FirstNetWork.h"
#import "HunJiaDetilaViewController.h"
#import "HunJiaSearchViewController.h"


@interface HunJiaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UITableView * myTableview;
@property(nonatomic,strong)NSMutableArray * DataArray;
@property(nonatomic,assign)int page;
@end

@implementation HunJiaViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(firsthunJiaDataReturn:) name:@"firsthunJiaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)firsthunJiaDataReturn:(NSNotification *)noti{

    [MBProgressHUD hideHUDForView:self.view];

    NSDictionary * dic = noti.object;
    [self.DataArray setArray:dic[@"array"]];

//    NSLog(@"%@",self.DataArray);
    
    [self.myTableview reloadData];
    
    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    /***************************************/
    self.DataArray = [NSMutableArray array];
    self.page = 0;
    /***************************************/

    [self getData];
    
    //添加头部导航栏
    [self headView];
    [self setTableView];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];

}

-(void)getData{
    
    NSArray * idArr = @[@"25",@"27",@"41"];
    
    [FirstNetWork getHunJiaDataWithUrl:GenDuodetilaUrl appkey:@"752" pid:idArr[self.index] page:[NSString stringWithFormat:@"%d",self.page]];

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
    
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, 25, 25, 25)];
    [self.rightButton setImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.navBarImageView addSubview:self.rightButton];

    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.navBarImageView addSubview:lineImageView];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    if (self.index == 0) {
        titleLable.text = @"婚嫁动态";
    }else if (self.index == 1){
    
        titleLable.text = @"婚嫁手册";
    }else{
    
        titleLable.text = @"婚嫁文化";
    }
    
    
    
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)RightButtonClick{
    NSLog(@"搜索");
    
    HunJiaSearchViewController * HunjiaSearchVc = [[HunJiaSearchViewController alloc]init];
    
    [self presentViewController:HunjiaSearchVc animated:YES completion:nil];


}


/*********************************************/

-(void)setTableView{
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
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
