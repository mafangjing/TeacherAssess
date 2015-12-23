//
//  HunTuViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "HunTuViewController.h"
#import "HunTuCollectionViewCell.h"
#import "HunTuNetWork.h"

@interface HunTuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;


@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * TuPianDataArray;
@property(nonatomic,copy)NSString * lastid;
@property(nonatomic,assign)int pageflag;

@end

@implementation HunTuViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HunTuDataReturn:) name:@"HunTuDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)HunTuDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);
    NSArray * array = dic[@"data"];

    if (self.pageflag == 0) {
        
        [self.TuPianDataArray setArray:array];
        
        [self.collectionView reloadData];

        //收起下拉视图
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
        [MBProgressHUD showSuccess:@"加载成功" toView:self.view];

        
    }else{
    
        for (NSDictionary * dict in array) {
            
            [self.TuPianDataArray addObject:dict];
            
        }
        
        [self.collectionView reloadData];
        //收起上拉视图
        [self.collectionView footerEndRefreshing];
    
    
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.lastid = @"0";
    self.pageflag = 0;
    
    self.TuPianDataArray = [NSMutableArray array];
    
    
    [self getData];
    
    //添加头部导航栏
    [self headView];

    [self setMyConllectionView];


}


-(void)getData{

    [HunTuNetWork GetHunTuDataWithUrl:HunTuDataUrl lastid:self.lastid resolution:@"640_420" pageflag:[NSString stringWithFormat:@"%d",self.pageflag] ctypeid:@"0" itypeid:@"0" goodsid:@"0"];


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
    titleLable.text = @"婚⭐️图";
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
    flow.minimumInteritemSpacing = 5;
    //行宽设置
    flow.minimumLineSpacing = 5;
    //Cell的大小设置
    flow.itemSize = CGSizeMake(300, 250);
    
    //section中的内嵌套位置设置
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //设置滚动方法
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    /*
     UICollectionViewScrollDirectionVertical,纵向滚动
     UICollectionViewScrollDirectionHorizontal  横向滚动
     
     */
    
    [self.view addSubview:self.collectionView];
    
    //注册一个collectionViewCell队列
    //参数1：类型
    //参数2：队列名
    //注册一个collectionViewCell队列
    [self.collectionView registerNib:[UINib nibWithNibName:@"HunTuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HunTuCell"];
    
    
    //添加下拉刷新列表
    __weak HunTuViewController * sself = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        sself.pageflag = 0;
        
        sself.lastid = @"0";
        //刷新数据
        [sself getData];
    }];
    
    //添加上拉获取更多
        [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
    
            sself.pageflag = 1;
            sself.lastid = sself.TuPianDataArray[arc4random()%sself.TuPianDataArray.count][@"iid"];
            
          [sself getData];
        }];
}

#pragma mark ---  collectionViewDelatate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"self.TuPianDataArray.count = %ld",self.TuPianDataArray.count);
    return self.TuPianDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据队列名称和队列Cell所在位置，取出相应的Cell
    HunTuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HunTuCell" forIndexPath:indexPath];
    
    cell.MainImageView.userInteractionEnabled = YES;
    [cell.MainImageView setImageWithURL:[NSURL URLWithString:self.TuPianDataArray[indexPath.row][@"pic"]] placeholderImage:nil];
    
    
    return cell;
    
}
//设置组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexpath.section = %ld\nindecPath.row = %ld 被选中",indexPath.section,indexPath.row);
    
    
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
