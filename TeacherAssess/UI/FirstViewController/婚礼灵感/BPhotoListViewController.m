//
//  BPhotoListViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "BPhotoListViewController.h"
#import "PhotoListCollectionViewCell.h"
#import "HunliLingGanNetwork.h"
#import "BigPhotopViewController.h"

@interface BPhotoListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * PhotolistArray;

@property(nonatomic,assign)int page;


@end

@implementation BPhotoListViewController


//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HunliLingGanPhotoListDataReturn:) name:@"HunliLingGanPhotoListDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)HunliLingGanPhotoListDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);
    self.PhotolistArray = dic[@"list"];
    NSLog(@"%ld",self.PhotolistArray.count);
    NSLog(@"%@",self.PhotolistArray);
    [self.collectionView reloadData];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.lastDict);
    
    self.PhotolistArray = [NSMutableArray array];
    self.page = 1;
    
    
    [self getData];
    
    
    //添加头部导航栏
    [self headView];
    [self setMyConllectionView];

}


-(void)getData{

    [HunliLingGanNetwork GetHunliLingGanPhotoListDataWithUrl:HUnliLingGanPhotoListUrl act:@"lgsclist" cate:self.lastDict[@"cate"]  page:[NSString stringWithFormat:@"%d",self.page] pageper:@"32" color:self.lastDict[@"color"] mver:@"3"];


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
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = self.lastDict[@"color_name"];
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
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flow];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //flow属性设置
    //列宽设置
    flow.minimumInteritemSpacing = 0;
    //行宽设置
    flow.minimumLineSpacing = 0;
    //Cell的大小设置
    flow.itemSize = CGSizeMake(160, 160);
    
    //section中的内嵌套位置设置
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //设置滚动方法
     flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    /*
     UICollectionViewScrollDirectionVertical,纵向滚动
     UICollectionViewScrollDirectionHorizontal  横向滚动
     
     */
    
    [self.view addSubview:self.collectionView];
    
    //注册一个collectionViewCell队列
    //参数1：类型
    //参数2：队列名
    //注册一个collectionViewCell队列
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"listCell"];
    
}

#pragma mark ---  collectionViewDelatate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.PhotolistArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据队列名称和队列Cell所在位置，取出相应的Cell
    PhotoListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    
    [cell setPhotoListCellWithDic:self.PhotolistArray[indexPath.row]];
    
    return cell;
    
}
//设置组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexpath.section = %ld\nindecPath.row = %ld 被选中",indexPath.section,indexPath.row);
    
    BigPhotopViewController * BigPhotoVc = [[BigPhotopViewController alloc]init];
    
    BigPhotoVc.currentPhotoPage = [NSString stringWithFormat:@"%ld",indexPath.row];
    BigPhotoVc.photosArray = self.PhotolistArray;
    
    [self.navigationController pushViewController:BigPhotoVc animated:YES];
    
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
