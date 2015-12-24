//
//  SecondDetilaViewController.m
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondDetilaViewController.h"
#import "SecondNetWork.h"
#import "SecondShangPingXiangQingViewController.h"


@interface SecondDetilaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * ListDataArray;

@property(nonatomic,strong)UICollectionViewFlowLayout * flow;

@end

@implementation SecondDetilaViewController


//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SecondListDataReturn:) name:@"SecondListDataReturn" object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)SecondListDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);
    
//  /  self.ListDataArray = dic[@"products"];
    
    [self.ListDataArray setArray:[SecondListModel setBeanWithArray:dic[@"products"]]];
    
    
    [self.collectView reloadData];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"secMo = %@",self.secMo.id1);
    
    self.ListDataArray = [NSMutableArray array];
    
    [self getData];
    
    //添加头部导航栏
    [self headView];

    [self setMyConllectionView];


}

-(void)getData{

    [SecondNetWork getSecondListDatawithUrl:SecondListDataUrl category:@"category" page:@"1" sort:@"sort" subject:self.secMo.id1];
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

-(void)setMyConllectionView{
    //创建一个CollectionView的属性设置处理器
    _flow = [[UICollectionViewFlowLayout alloc]init];
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:_flow];
    self.collectView.backgroundColor = [UIColor whiteColor];
    //flow属性设置
    //列宽设置
    _flow.minimumInteritemSpacing = 5;
    //行宽设置
    _flow.minimumLineSpacing = 5;
    //Cell的大小设置
    _flow.itemSize = CGSizeMake(100, 130);
    
    //section中的内嵌套位置设置
    _flow.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    //设置滚动方法
    _flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    /*
     UICollectionViewScrollDirectionVertical,纵向滚动
     UICollectionViewScrollDirectionHorizontal  横向滚动
     
     */
    
    [self.view addSubview:self.collectView];
    
    //注册一个collectionViewCell队列
    //参数1：类型
    //参数2：队列名
    //注册一个collectionViewCell队列
//    [self.collectView registerNib:[UINib nibWithNibName:@"HunTuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HunTuCell"];
    
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
}

#pragma mark ---  collectionViewDelatate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.ListDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondListModel * mo = self.ListDataArray[indexPath.row];
    
    //根据队列名称和队列Cell所在位置，取出相应的Cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [image setImageWithURL:[NSURL URLWithString:mo.photo_path] placeholderImage:nil];
    [cell addSubview:image];
    
    
    return cell;
    
}
//设置组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexpath.section = %ld\nindecPath.row = %ld 被选中",indexPath.section,indexPath.row);
  
    SecondShangPingXiangQingViewController * ShangPingXiangQingVc = [[SecondShangPingXiangQingViewController alloc]init];
    
    ShangPingXiangQingVc.SecondListMo = self.ListDataArray[indexPath.row];
    
    [self.navigationController pushViewController:ShangPingXiangQingVc animated:YES];
    
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
