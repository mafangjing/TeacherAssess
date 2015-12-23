//
//  HunLiMusicViewController.m
//  Wedding
//
//  Created by hjh on 15-10-9.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunLiMusicViewController.h"
#import "HunJiaMusicCollectionViewCell.h"
#import "FirstNetWork.h"
#import "MusicViewController.h"

@interface HunLiMusicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;



@end

@implementation HunLiMusicViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MusicDataReturn:) name:@"MusicDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)MusicDataReturn:(NSNotification *)noti{


    NSDictionary * dict = [noti object];
    [self.dataArray setArray:dict[@"data"]];
    [self.collectionView reloadData];
    
    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];

}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
/**********************************************/
    self.dataArray = [NSMutableArray array];

    
/**********************************************/

    
    [self getData];
    
    //添加头部导航栏
    [self headView];

    [self setConllectionView];
    


}

-(void)getData{

    [FirstNetWork getMusicDataWithUrl:musicListUrl];

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
    titleLable.text = @"婚礼音乐";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/

#pragma mark ---ConllectionView
-(void)setConllectionView{
    
    
    //创建一个collectionView的属性设置处理器
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //flow属性设置
    //行宽设置
    flow.minimumLineSpacing = 0;
    //列宽设置
    flow.minimumInteritemSpacing = 0;
    //每个cell的大小
    flow.itemSize = CGSizeMake((self.view.frame.size.width - 20)/2, 165);
    //section中的内嵌位置设置
    flow.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    //滚动方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView
    //layout:传入flow处理器
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flow];
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HunJiaMusicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"musicCell"];
    
}

#pragma mark - collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据队列名称和队列cell所在位置，取出相对应的cell
    HunJiaMusicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"musicCell" forIndexPath:indexPath];
    
    [cell setCellWithDic:self.dataArray[indexPath.row]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath.row = %ld,indexPath.section = %ld 被选中",(long)indexPath.row,(long)indexPath.section);
    
    MusicViewController * mucicVc = [[MusicViewController alloc]init];
    
    mucicVc.lastdic = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:mucicVc animated:YES];
    
    
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
