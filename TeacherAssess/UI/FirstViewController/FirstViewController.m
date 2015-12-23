//
//  FirstViewController.m
//  Wedding
//
//  Created by hjh on 15-12-21.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "FirstViewController.h"
#import "ScrollViewDemo.h"
#import "FirstNetWork.h"
#import "HunJiaViewController.h"
#import "HunLiMusicViewController.h"
#import "HunTuViewController.h"

#import "HLSPTableViewCell.h"
#import "JingXuanHunLiTableViewCell.h"

#import "ShipinViewController.h"
#import "JXHunLiViewController.h"

#import "HunLiLingGanViewController.h"

#import "GengDuoJingXuanHunLiViewController.h"
#import "GengDuoShiPingViewController.h"

#import "FirstViewLocalData.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;

@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * AdDataArray;
@property(nonatomic,strong)NSArray * GengDuoArray;

@property(nonatomic,strong)UIScrollView * scrollViw;

@property(nonatomic)NSArray * jxhlArray;
@property(nonatomic)NSArray * jxtpArray;
@property(nonatomic)NSArray * jxspArray;
@property(nonatomic)NSArray * hlztArray;

@end

@implementation FirstViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FirstJingXuanDataReturn:) name:@"FirstJingXuanDataReturn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(firstADvertisementDataReturn:) name:@"firstADvertisementDataReturn" object:nil];
    
    //设置导航栏
    [self headView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)firstADvertisementDataReturn:(NSNotification *)noti{
    
    [MBProgressHUD hideHUDForView:self.view];
    
    NSDictionary * dic = noti.object;
    self.AdDataArray = [NSMutableArray array];
    self.AdDataArray = dic[@"Adbanners"];
    
    [self settableViewHeaderScrollView];
    
    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];
    
}


-(void)FirstJingXuanDataReturn:(NSNotification *)noti{
    
    NSDictionary * dic = noti.object;
    self.jxhlArray = dic[@"jxhl"];
    self.jxtpArray = dic[@"jxtp"];
    self.jxspArray = dic[@"jxsp"];
    self.hlztArray = dic[@"hlzt"];
    //    NSLog(@"%@",self.jxspArray);
    
    [self.myTableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    
    
    self.jxhlArray = [NSArray array];
    self.jxtpArray = [NSArray array];
    self.jxspArray = [NSArray array];
    self.hlztArray = [NSArray array];
    
    
    [self getAdData];
    
    [self setMyTableView];
    
}

#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.tabBarController.navigationItem.title = @"精选";
}

-(void)getAdData{
    
    [FirstNetWork getFirstAdDataWithUrl:AdURl];
    
    [FirstNetWork GetFirstJingXuanDataWithUrl:FirstJingXuanUrl];
    
}


-(void)settableViewHeaderScrollView{
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    headerImageView.userInteractionEnabled = YES;
    
    //    headerImageView.backgroundColor = [UIColor colorWithRed:250/256.0 green:238/256.0 blue:225/256.0 alpha:1];
    
    ScrollViewDemo *svc = [[ScrollViewDemo alloc]init];
    
    //        NSArray *photoArray = @[@"Welcome_3.0_1.jpg",@"Welcome_3.0_2.jpg",@"Welcome_3.0_3.jpg",@"Welcome_3.0_4.jpg",@"Welcome_3.0_5.jpg"];
    
    NSMutableArray *photoArray = [NSMutableArray array];
    
    for (NSDictionary * dict in self.AdDataArray) {
        [photoArray addObject:dict[@"AdUrl"]];
    }
    
    NSLog(@"%@",photoArray);
    
    //设置是否是用网络图片
    svc.isNotLocalImage = YES;
    
    //必须设置的图片数组
    svc.photoArray = photoArray;
    
    svc.pageControlHeight = 20;
    
    //必须写在view.frame设置之前
    svc.scrollViewFrame = CGRectMake(0, 0, headerImageView.frame.size.width, 150);
    
    svc.view.frame = CGRectMake(0, 0, headerImageView.frame.size.width, headerImageView.frame.size.height);
    
    [headerImageView addSubview:svc.view];
    
    [self addChildViewController:svc];
    
    self.myTableview.tableHeaderView = headerImageView;
    
}



//***************************************************//
#pragma mark ====== UI设计
-(void)setMyTableView{
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"HLSPTableViewCell" bundle:nil] forCellReuseIdentifier:@"hlspcell"];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"JingXuanHunLiTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXHLcell"];
}



//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        return 1;
    }else{
        
        
        return 3;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * cell1PhotoArray = @[@"usr_article.png",@"Use_shouce_photo.jpg",@"usr_photo.png",@"usr_product.png",@"Use_photo_music.png"];
    
    //*************************************************
    if (indexPath.section == 0) {
        
        NSArray * arr = @[@"婚嫁动态",@"婚嫁手册",@"婚⭐️图",@"婚礼文化",@"婚嫁音乐"];
        
        static NSString *firstCellindextify = @"firstCell";
        
        UITableViewCell * firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellindextify];
        if (firstCell == nil) {
            
            firstCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellindextify];
        }
        
        UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 120)];
        imageView1.image = [UIImage imageNamed:@"topbg.png"];
        imageView1.userInteractionEnabled = YES;
        for (int i = 0; i < 5; i ++) {
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10 + i % 5 * ((firstCell.frame.size.width - 30)/5 + 5), 20, 50, 50)];
            button.tag = 1000 + i;
            
            [button setBackgroundImage:[UIImage imageNamed:cell1PhotoArray[i]] forState:UIControlStateNormal];
            
            button.layer.cornerRadius = 25.0;
            button.clipsToBounds = YES;
            
            
            
            [button addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView1 addSubview:button];
            
            UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10 + i % 5 * ((firstCell.frame.size.width - 30)/5 + 5), button.frame.origin.y + button.frame.size.height + 5, button.frame.size.width, 20)];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.text = arr[i];
            lable.font = [UIFont systemFontOfSize:12];
            lable.textColor = [UIColor whiteColor];
            
            [imageView1 addSubview:lable];
        }
        
        [firstCell addSubview:imageView1];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return firstCell;
        //*************************************************
        
    }else if (indexPath.section == 1){
        
        static NSString *SecondCellindextify = @"SecondCell";
        
        UITableViewCell * SecondCell = [tableView dequeueReusableCellWithIdentifier:SecondCellindextify];
        if (SecondCell == nil) {
            
            SecondCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecondCellindextify];
        }
        
        self.scrollViw = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 80)];
        
        [SecondCell addSubview:self.scrollViw];
        
        for (int i = 0; i < HunliLingGanCountArray.count; i ++) {
            
            UIButton * TuPianButton = [[UIButton alloc]initWithFrame:CGRectMake(i % HunliLingGanCountArray.count * (80 + 5), 0, 80, 80)];
            TuPianButton.tag = 1000 + i;
            [TuPianButton setBackgroundImage:[UIImage imageNamed:HunliLingGanTuArray[i]] forState:UIControlStateNormal];
            [TuPianButton addTarget:self action:@selector(CellTuPianButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            TuPianButton.layer.cornerRadius = 8.0;
            TuPianButton.clipsToBounds = YES;
            [self.scrollViw addSubview:TuPianButton];
            
            UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 15)];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.backgroundColor = [UIColor clearColor];
            lable1.text = HunliLingGanNameArray[i];
            lable1.textColor = [UIColor whiteColor];
            [TuPianButton addSubview:lable1];
            
            UILabel * lable2 = [[UILabel alloc]init];
            lable2.center = CGPointMake(TuPianButton.frame.size.width/2, TuPianButton.frame.size.height - 10);
            lable2.bounds = CGRectMake(0, 0, 30, 10);
            lable2.layer.cornerRadius = 5.0;
            lable2.text = [NSString stringWithFormat:@"%@图",HunliLingGanCountArray[i]];
            lable2.textAlignment = NSTextAlignmentCenter;
            lable2.font = [UIFont systemFontOfSize:7];
            lable2.clipsToBounds = YES;
            lable2.backgroundColor = [UIColor lightGrayColor];
            
            [TuPianButton addSubview:lable2];
            
        }
        
        self.scrollViw.contentSize = CGSizeMake((80 + 5) * HunliLingGanCountArray.count,80);
        
        SecondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return SecondCell;
        
    }else if(indexPath.section == 2){
        
        static NSString *firstCellindextify = @"JXHLcell";
        
        JingXuanHunLiTableViewCell * ThirdCell = [tableView dequeueReusableCellWithIdentifier:firstCellindextify];
        if (ThirdCell == nil) {
            
            ThirdCell = [[JingXuanHunLiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellindextify];
        }
        
        //***************************************
        ThirdCell.MainImageView.layer.cornerRadius = 10.0;
        ThirdCell.MainImageView.clipsToBounds = YES;
        
        ThirdCell.imageView1.layer.cornerRadius = 5.0;
        ThirdCell.imageView1.clipsToBounds = YES;
        
        ThirdCell.imageView2.layer.cornerRadius = 5.0;
        ThirdCell.imageView2.clipsToBounds = YES;
        
        ThirdCell.imageView3.layer.cornerRadius = 5.0;
        ThirdCell.imageView3.clipsToBounds = YES;
        //***************************************
        
        if (self.jxhlArray.count > 0) {
            [ThirdCell setJXHLCellWithDic:self.jxhlArray[indexPath.row]];
        }
        
        
        ThirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return ThirdCell;
        
        
        
    }else{
        
        
        static NSString * idetify = @"hlspcell";
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
        
        if (self.jxspArray.count > 0) {
            
            [cell setCellWithDic:self.jxspArray[indexPath.row]];
        }
        
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section = %ld,row = %ld",indexPath.section,indexPath.row);
    
    if (indexPath.section == 2) {
        
        JXHunLiViewController * JXHunLiVc = [[JXHunLiViewController alloc]init];
        
        JXHunLiVc.hxjx = self.jxhlArray[indexPath.row][@"hxjx_id"];
        
        [self.navigationController pushViewController:JXHunLiVc animated:YES];
    }
    
    if (indexPath.section == 3) {
        
        ShipinViewController * ShiPinVc = [[ShipinViewController alloc]init];
        
        ShiPinVc.hxjx = self.jxspArray[indexPath.row][@"hxjx_id"];
        
        [self.navigationController pushViewController:ShiPinVc animated:YES];
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 120;
        
    }else if (indexPath.section == 1){
        
        return 80;
        
    }else{
        
        return 120;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    View.backgroundColor = [UIColor whiteColor];
    
    UIImageView * ShuXianimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 5, 15)];
    ShuXianimage.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    ShuXianimage.layer.cornerRadius = 3.0;
    [View addSubview:ShuXianimage];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(ShuXianimage.frame.origin.x + ShuXianimage.frame.size.width + 5, ShuXianimage.frame.origin.y, 100, 15)];
    lable.font = [UIFont systemFontOfSize:13];
    [View addSubview:lable];
    
    //***********************************************
    UIButton * GengDuoButton = [[UIButton alloc]initWithFrame:CGRectMake(View.frame.size.width - 60, 7, 40, 13)];
    
    GengDuoButton.tag = 10 + section;
    [GengDuoButton addTarget:self action:@selector(GengDuoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [GengDuoButton setTitle:@"更多" forState:UIControlStateNormal];
    GengDuoButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [GengDuoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal
     ];
    
    [GengDuoButton setImage:[UIImage imageNamed:@"btn_dis_nextlinght.png"] forState:UIControlStateNormal];
    [GengDuoButton setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
    [GengDuoButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    
    //***********************************************
    
    if (section == 0) {
        
        lable.text = @"婚嫁文化";
        
    }else if (section == 1){
        
        lable.text = @"婚礼灵感";
        
    }else if (section == 2){
        
        lable.text = @"精选婚礼";
        
        [View addSubview:GengDuoButton];
        
    }else{
        
        lable.text = @"精选视频";
        [View addSubview:GengDuoButton];
        
    }
    
    return View;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
    
}


//***************************************************//
#pragma mark == Cell1的button点击事件
-(void)buttonsClick:(UIButton *)button{
    NSLog(@"%ld",button.tag);
    
    switch (button.tag%1000) {
        case 0:
        {
            HunJiaViewController * hunjiaVc = [[HunJiaViewController alloc]init];
            hunjiaVc.index = button.tag%1000;
            [self.navigationController pushViewController:hunjiaVc animated:YES];
            
            
        }
            break;
        case 1:
        {
            
            HunJiaViewController * hunjiaVc = [[HunJiaViewController alloc]init];
            hunjiaVc.index = button.tag%1000;
            [self.navigationController pushViewController:hunjiaVc animated:YES];
            
            
        }
            break;
        case 2:
        {
            
            
            HunTuViewController * huntuVc = [[HunTuViewController alloc]init];
            [self.navigationController pushViewController:huntuVc animated:YES];
            
        }
            break;
        case 3:
        {
            
            HunJiaViewController * hunjiaVc = [[HunJiaViewController alloc]init];
            hunjiaVc.index = button.tag%1000 - 1;
            [self.navigationController pushViewController:hunjiaVc animated:YES];
            
            
        }
            break;
        case 4:
        {
            
            HunLiMusicViewController * musicVc =[[HunLiMusicViewController alloc]init];
            [self.navigationController pushViewController:musicVc animated:YES];
            
        }
            break;
            
            
        default:
            break;
    }
    
}

//***************************************************//
#pragma mark == Cell2的图片button点击事件

-(void)CellTuPianButtonClick:(UIButton *)button{
    
    
    HunLiLingGanViewController * HunliLingGanVc = [[HunLiLingGanViewController alloc]init];
    
    HunliLingGanVc.HeadLableString = HunliLingGanNameArray[button.tag % 1000];
    HunliLingGanVc.buttonindex = button.tag % 1000 + 1;
    
    [self.navigationController pushViewController:HunliLingGanVc animated:YES];
}

#pragma mark == Cell3和cell4 “更多” button点击事件
-(void)GengDuoButtonClick:(UIButton *)button{
    NSLog(@"%ld",button.tag);
    
    if (button.tag == 12) {
        
        GengDuoJingXuanHunLiViewController * GDJingXuanHunLiVc = [[GengDuoJingXuanHunLiViewController alloc]init];
        
        [self.navigationController pushViewController:GDJingXuanHunLiVc animated:YES];
        
    }else{
        
        GengDuoShiPingViewController * GDShiPingVc = [[GengDuoShiPingViewController alloc]init];
        [self.navigationController pushViewController:GDShiPingVc animated:YES];
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
