//
//  MusicViewController.m
//  Wedding
//
//  Created by hjh on 15-10-9.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayerViewController.h"
#import "FirstNetWork.h"


#import "bofangViewController.h"



@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)AVAudioPlayer * play;

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UITableView * myTableview;
@property(nonatomic,strong)NSMutableArray * DataArray;

@property(nonatomic,strong)UIImageView * imageView;
//********************************************//
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UIView * headerView1;

@property(nonatomic,strong)UILabel * titleHearderLable;
@property(nonatomic,strong)UILabel * kugouLable;
@property(nonatomic,strong)UILabel * StartTimeLable;
@property(nonatomic,strong)UILabel * AllTimeLable;
@property(nonatomic,strong)UISlider * slid;
@property(nonatomic,strong)UIButton * playButton;
@property(nonatomic,strong)UILabel * countLable;
//********************************************//

@property(nonatomic,assign)int index;


@end

@implementation MusicViewController


//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(musicDetilaDataReturn:) name:@"musicDetilaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)musicDetilaDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);
    

    [self.DataArray setArray:dic[@"data"]];
    
    self.countLable.text = [NSString stringWithFormat:@"共%ld首歌",self.DataArray.count];
    
    [self.myTableview reloadData];
    
    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.DataArray = [NSMutableArray array];
    self.index = 0;
    
    
    [self getMusicData];
    
    //添加头部导航栏
    [self headView];
    [self setTableView];

}


-(void)getMusicData{

    [FirstNetWork getDetilaMusicDataWith:musicDetilaListUrl mtid:self.lastdic[@"tid"] pageflag:@"0" lastid:@"0"];

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
    titleLable.text = self.lastdic[@"name"];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/

-(void)setTableView{
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    //    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.myTableview];
    
//    [self.myTableview registerNib:[UINib nibWithNibName:@"HunJiaTableViewCell" bundle:nil] forCellReuseIdentifier:@"hunjiaCell"];
    
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.headImageView.image = [UIImage imageNamed:@"discoverz@2x.png"];
    [self.headImageView setImageWithURL:[NSURL URLWithString:self.lastdic[@"pic"]] placeholderImage:nil];
    
    self.countLable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.headImageView.frame.size.height - 30 , 60, 15)];
    self.countLable.font = [UIFont systemFontOfSize:12];
    self.countLable.text = @"共0首歌";
    self.countLable.textColor = [UIColor whiteColor];
    self.countLable.backgroundColor = [UIColor clearColor];
    [self.headImageView addSubview:self.countLable];
    
    self.myTableview.tableHeaderView = self.headImageView;
    
    
}

//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"self.DataArray.count = %ld",self.DataArray.count);
    return self.DataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * idetify = @"hunjiaCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetify];
    }
    cell.tag = 10 + indexPath.row;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width - 2, 0, 2,70)];
    self.imageView.tag = 100 + indexPath.row;
    self.imageView.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 0) {
        self.imageView.backgroundColor = [UIColor redColor];
    }
    [cell addSubview:self.imageView];
    cell.textLabel.text = self.DataArray[indexPath.row][@"name"];
    cell.detailTextLabel.text = self.DataArray[indexPath.row][@"from"];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i < self.DataArray.count; i ++) {
        UITableViewCell * cell = (UITableViewCell *)[self.myTableview viewWithTag:10 + i];
        UIImageView * imageView = (UIImageView *)[cell viewWithTag:100 + i];
        imageView.backgroundColor = [UIColor whiteColor];
    }
    
    UITableViewCell * cell = (UITableViewCell *)[self.myTableview viewWithTag:10 + indexPath.row];
    self.imageView = (UIImageView *)[cell viewWithTag:100 + indexPath.row];
    self.imageView.backgroundColor = [UIColor redColor];
    
    
    //**********************
    self.titleHearderLable.text = self.DataArray[indexPath.row][@"name"];
    self.kugouLable.text = self.DataArray[indexPath.row][@"from"];
    self.slid.value = 00.00;
    //**********************

    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

#pragma mark ===  返回一个组头的view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headerView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.headerView1.backgroundColor = [UIColor whiteColor];
//***************
    self.titleHearderLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, self.headImageView.frame.size.width - (20 + 20) - 40, 20)];
    [self.headerView1 addSubview:self.titleHearderLable];
//***************
    self.kugouLable = [[UILabel alloc]initWithFrame:CGRectMake(self.titleHearderLable.frame.origin.x, self.titleHearderLable.frame.origin.y + self.titleHearderLable.frame.size.height + 10, 50, 15)];
    self.kugouLable.font = [UIFont systemFontOfSize:12];
    self.kugouLable.textColor = [UIColor grayColor];
//    self.kugouLable.text = @"kugou";
    [self.headerView1 addSubview:self.kugouLable];
//***************
   
    self.StartTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(self.kugouLable.frame.origin.x, self.kugouLable.frame.origin.y + self.kugouLable.frame.size.height + 10, 40, 15)];
    self.StartTimeLable.textColor = [UIColor lightGrayColor];
    self.StartTimeLable.text = @"00.00";
    self.StartTimeLable.font = [UIFont systemFontOfSize:12];
    [self.headerView1 addSubview:self.StartTimeLable];
    
//***************

    self.slid = [[UISlider alloc]initWithFrame:CGRectMake(self.StartTimeLable.frame.origin.x + self.StartTimeLable.frame.size.width + 10, self.StartTimeLable.frame.origin.y, self.view.frame.size.width - 2 * (20 + self.StartTimeLable.frame.size.width + 5), 15)];
    
    [self.headerView1 addSubview:self.slid];
//***************
    
    self.AllTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(self.slid.frame.origin.x + self.slid.frame.size.width + 5, self.slid.frame.origin.y, self.StartTimeLable.frame.size.width, 15)];
    self.AllTimeLable.font = [UIFont systemFontOfSize:12];
    self.AllTimeLable.text = @"10.00";
    self.AllTimeLable.textColor = [UIColor lightGrayColor];
    [self.headerView1 addSubview:self.AllTimeLable];
//***************
    
    self.playButton = [[UIButton alloc]initWithFrame:CGRectMake(self.titleHearderLable.frame.origin.x + self.titleHearderLable.frame.size.width + 10, self.titleHearderLable.frame.origin.y + 10, 30, 30)];
    [self.playButton setImage:[UIImage imageNamed:@"playbtn@2x.png"] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.playButton.selected = NO;
    [self.headerView1 addSubview:self.playButton];
    
 //***************
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.headerView1.frame.size.height - 2, self.headerView1.frame.size.width, 2)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.headerView1 addSubview:imageView];
    
    if (self.DataArray.count > 0) {
        self.titleHearderLable.text = self.DataArray[self.index][@"name"];
        self.kugouLable.text = self.DataArray[self.index][@"from"];
    }
    return self.headerView1;
    
}

#pragma mark === 设置组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
//**********************
#pragma mark === 播放按钮点击事件
-(void)playButtonClick:(UIButton *)button{
    if (button.selected == NO) {
        NSLog(@"播放");
        [self.playButton setImage:[UIImage imageNamed:@"stopbtn@2x.png"] forState:UIControlStateNormal];
        
       
        bofangViewController * MusicPlayVc = [[bofangViewController alloc]init];

        MusicPlayVc.videoUrl = self.DataArray[self.index][@"playURL"];
        MusicPlayVc.Y = NO;
        
        [self.navigationController pushViewController:MusicPlayVc animated:YES];
        
        button.selected = YES;
    }else{
        NSLog(@"暂停");
        [self.playButton setImage:[UIImage imageNamed:@"playbtn@2x.png"] forState:UIControlStateNormal];
        button.selected = NO;
    
    }

}
//**********************************************

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
