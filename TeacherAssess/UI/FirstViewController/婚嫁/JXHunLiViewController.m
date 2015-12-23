//
//  JXHunLiViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "JXHunLiViewController.h"
#import "JxHunLiFirstTableViewCell.h"
#import "FirstNetWork.h"

@interface JXHunLiViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;


@property(nonatomic,strong)UITableView * myTableview;
@property(nonatomic,strong)NSArray * DataArray;
@property(nonatomic,strong)NSDictionary * FirstCelldic;

@end

@implementation JXHunLiViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(JXHunLiDetilaDataReturn:) name:@"JXHunLiDetilaDatasReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)JXHunLiDetilaDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
//    NSLog(@"%@",dic);
    self.FirstCelldic = dic[@"hxjx"];
    self.DataArray = dic[@"hxjx"][@"_images"];
    NSLog(@"%@",self.FirstCelldic);
    NSLog(@"%@",self.DataArray);
    
    [self.myTableview reloadData];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.hxjx);
    self.DataArray = [NSArray array];
    self.FirstCelldic = [NSDictionary dictionary];
    
    [self getData];
    
    //添加头部导航栏
    [self headView];
    
    [self setTableView];

}

-(void)getData{

    [FirstNetWork GetJXHunLiDetilaDataWithUrl:@"http://data.halobear.cn/mapi/index.php" act:@"hxjxinfo" hxjx:self.hxjx mver:@"3" page:@"1" pageper:@"10"];

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
    titleLable.text = @"精选婚礼";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//***************************************************//
-(void)setTableView{
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
    [self.myTableview registerNib:[UINib nibWithNibName:@"JxHunLiFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXhunjiaCell"];
    
}

//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.DataArray.count > 0) {
        return self.DataArray.count + 1;
    }else{
    
        return 0;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        static NSString * idetify = @"JXhunjiaCell";
        JxHunLiFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
        if (cell == nil) {
            cell = [[JxHunLiFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            [cell setcellwithDic:self.FirstCelldic];
        
        return cell;
        
    }else{
        
    static  NSString * index = @"cells1";
           UITableViewCell * cells1 = [tableView dequeueReusableCellWithIdentifier:index];
           if (cells1 == nil) {
               
               cells1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
           }
           
           UIImageView * imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, cells1.frame.size.width - 20,180)];
        [imageview1 setImageWithURL:[NSURL URLWithString:self.DataArray[indexPath.row - 1][@"image_url"]] placeholderImage:nil];
        [cells1 addSubview:imageview1];
        
        return cells1;
  }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 220;
    }else{
    
        return 200;
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
