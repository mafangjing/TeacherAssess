//
//  FouthDetialViewController.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//

#import "FouthDetialViewController.h"
#import "OTCover.h"
#import "TQRichTextView.h"
#import "FouthNetWork.h"
#import "FouthDetilaTableViewCell.h"
#import "LianXiTableViewCell.h"
#import "JuTiXiangQingViewController.h"


@interface FouthDetialViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)UITableView *myTableview;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)OTCover * OTCoverTableView;
@property(nonatomic,strong)TQRichTextView * DetilaLable;
@property(nonatomic,strong)NSDictionary * Datadict;
@property(nonatomic,strong)NSMutableArray * CanPindataArray;

@property(nonatomic,strong)UIWebView * JianjieWebView;

@property(nonatomic,strong)NSMutableArray * LianXiArr;
//****************************
@property(nonatomic,strong)UIView * headerView;
@property(nonatomic,strong)UIImageView * mainimageView;
@property(nonatomic,strong)UILabel * titlelable;
@property(nonatomic,strong)UIImageView * levelImage;

@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton * button2;
@property(nonatomic,strong)UIButton * button3;


//****************************
@property(nonatomic,assign)NSInteger buttonIndex;

@property(nonatomic,assign)NSInteger AlertIndex;
@end

@implementation FouthDetialViewController


//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CanPinDataReturn:) name:@"CanPinDataReturn" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FouthDetilaDataReturn:) name:@"FouthDetilaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark ---- 通知返回数据
-(void)FouthDetilaDataReturn:(NSNotification *)noti{
    self.Datadict = noti.object;
//    NSLog(@"%@",self.Datadict);
   
    [MBProgressHUD hideHUDForView:self.view];

    //tableView刷新数据
    [self.OTCoverTableView.tableView reloadData];
    
    NSArray * headPhotoArray = self.Datadict[@"img"];
    NSString * photostring = headPhotoArray[0][@"img"];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photostring]];
    [self.OTCoverTableView setHeaderImage:[UIImage imageWithData:data]];
    
    [MBProgressHUD showSuccess:@"加载成功" toView:self.view];

    
    [self getCanPinData];
    
}

-(void)CanPinDataReturn:(NSNotification *)noti{

    NSDictionary * dict = noti.object;
    [self.CanPindataArray setArray:dict[@"product"]];
    

}
//****************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.Datadict = [NSDictionary dictionary];
    self.CanPindataArray = [NSMutableArray array];
    self.LianXiArr = [NSMutableArray array];
    self.buttonIndex = 100;
    NSLog(@"%@",self.bean.name);
    
    
    [self getData];
    
    
    //添加头部导航栏
    [self headView];
    [self setmyTableView];
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];

    
}


#pragma mark ==== 获取数据
-(void)getData{
    [FouthNetWork getFouthDetilaDataWithUrl:@"http://lscy4.caeac.com.cn/api/partner.php" appkey:@"752" idi:self.bean.id1];
}


-(void)getCanPinData{

    [FouthNetWork getCanPinDataWithUrl:CanPinDataUrl appkey:@"752" pid:self.Datadict[@"id"] page:@"0"];

}

/*********************************************/
#pragma mark ==== 设置头部导航栏
-(void)headView{
    
    self.navBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.navBarImageView.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.navBarImageView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.navBarImageView];
    
    self.leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 20, 30)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.leftButton];
    
    //收藏店铺button
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.navBarImageView.frame.size.width - 50, self.leftButton.frame.origin.y + 5 , 40, 20)];
    [self.rightButton setTitle:@"收藏" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(RightButtonClick)  forControlEvents:UIControlEventTouchUpInside];
    [self.navBarImageView addSubview:self.rightButton];
    
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.navBarImageView addSubview:lineImageView];
    
    
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.center = CGPointMake(self.view.frame.size.width / 2, 40);
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.text = @"详 情";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
    
    
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)RightButtonClick{
    NSLog(@"收藏店铺,写到数据库");
    
    
    
    
    

}


/*********************************************/
//***************************************************//
#pragma mark ====== UI设计
-(void)setmyTableView{
    
    self.OTCoverTableView = [[OTCover alloc]initWithTableViewWithHeaderImage:[UIImage imageNamed:@"productz.png"] withOTCoverHeight:150];
    
    self.OTCoverTableView.tableView.delegate = self;
    self.OTCoverTableView.tableView.dataSource = self;
    
    if (self.buttonIndex == 100) {
        self.OTCoverTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    
    [self.view addSubview:self.OTCoverTableView];
    
    //注册一个cell
    [self.OTCoverTableView.tableView registerNib:[UINib nibWithNibName:@"FouthDetilaTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellidetify"];
    
    [self.OTCoverTableView.tableView registerNib:[UINib nibWithNibName:@"LianXiTableViewCell" bundle:nil] forCellReuseIdentifier:@"lianxiCellIdetify"];
    
    
}
//***************************************************//
#pragma mark ---- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.buttonIndex == 100) {
        return 1;
    }else if(self.buttonIndex == 101) {
    
        return self.CanPindataArray.count;
    }else{
        
    return 6;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * rightphotoArr = @[@"more_feedback_icon.png",@"shop_name_icon.png",@"shop_call_icon.png",@"shop_phone_icon.png",@"shop_web_icon.png",@"shop_address_icon.png"];
    
    
    if (self.buttonIndex == 100) {
    
        static NSString * idetify = @"cells";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idetify];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
        }
        cell.tag = 1;
        
        self.JianjieWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height - 64 - 150 - 100)];
        
        [self.JianjieWebView loadHTMLString:self.Datadict[@"concent"] baseURL:nil];
        
        [cell addSubview:self.JianjieWebView];
  
        return cell;
        
    }else if (self.buttonIndex == 101){
               
               UITableViewCell * ce = (UITableViewCell *)[self.OTCoverTableView.tableView viewWithTag:1];
               [ce removeFromSuperview];
        
    static NSString * indextify = @"cellidetify";
    FouthDetilaTableViewCell * CanPinCell = [tableView dequeueReusableCellWithIdentifier:indextify];
               if (CanPinCell == nil) {
                   
                   CanPinCell = [[FouthDetilaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indextify];
                   
               }
               [CanPinCell setCellWithDic:self.CanPindataArray[indexPath.row]];
               return CanPinCell;
    }else{
    
        UITableViewCell * ce = (UITableViewCell *)[self.OTCoverTableView.tableView viewWithTag:1];
        [ce removeFromSuperview];
        
        
        static NSString * indextify = @"lianxiCellIdetify";
        LianXiTableViewCell * LianXiCell = [tableView dequeueReusableCellWithIdentifier:indextify];
        if (LianXiCell == nil) {
            
            LianXiCell = [[LianXiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indextify];
            
        }
        if (indexPath.row == 0) {
            [LianXiCell setLianXiCellWithstring:self.Datadict[@"name"] photostring:rightphotoArr[indexPath.row]];
        }else if (indexPath.row == 1){
        
        [LianXiCell setLianXiCellWithstring:self.Datadict[@"uname"] photostring:rightphotoArr[indexPath.row]];
        
        }else if (indexPath.row == 2){
            
            [LianXiCell setLianXiCellWithstring:self.Datadict[@"tel"] photostring:rightphotoArr[indexPath.row]];
        }else if (indexPath.row == 3){
            
            [LianXiCell setLianXiCellWithstring:self.Datadict[@"utel"] photostring:rightphotoArr[indexPath.row]];
            
        }else if (indexPath.row == 4){
            
            [LianXiCell setLianXiCellWithstring:self.Datadict[@"net"] photostring:rightphotoArr[indexPath.row]];
            
        }else if (indexPath.row == 5){
            
            [LianXiCell setLianXiCellWithstring:self.Datadict[@"address"] photostring:rightphotoArr[indexPath.row]];
            
        }
        
        LianXiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return LianXiCell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.buttonIndex == 100) {
        
        return self.view.frame.size.height - 64 - 150 - 100;
        
    }else if(self.buttonIndex == 101){
    
    return 80;
        
    }else{
    
        return 44;
    
    }
}


#pragma mark ===  返回一个组头的view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    //***************
    
    self.mainimageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 65, 65)];
    [self.mainimageView setImageWithURL:[NSURL URLWithString:self.bean.logo] placeholderImage:nil];
    
    [self.headerView addSubview:self.mainimageView];
    //***************
    self.titlelable = [[UILabel alloc]initWithFrame:CGRectMake(self.mainimageView.frame.origin.x + self.mainimageView.frame.size.width + 10, 10, self.view.frame.size.width - self.mainimageView.frame.size.width - (5 + 10 + 10), 25)];
    self.titlelable.font = [UIFont systemFontOfSize:16];
    self.titlelable.text = self.bean.name;
    [self.headerView addSubview:self.titlelable];
    //***************

    self.levelImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.titlelable.frame.origin.x, self.titlelable.frame.origin.y + self.titlelable.frame.size.height + 10,100 , 15)];
    self.levelImage.layer.cornerRadius = 8.0;
    self.levelImage.clipsToBounds = YES;
    if ([self.bean.level isEqualToString:@"20"]) {
        self.levelImage.image = [UIImage imageNamed:@"level_diamond.png"];
    }
    if ([self.bean.level isEqualToString:@"21"]) {
        self.levelImage.image = [UIImage imageNamed:@"level_platinum.png"];
    }
    if ([self.bean.level isEqualToString:@"22"]) {
        self.levelImage.image = [UIImage imageNamed:@"leve_gold.png"];
    }

    [self.headerView addSubview:self.levelImage];
    
    //***************

    NSArray * buttonnameArray = @[@"简介",@"产品",@"联系"];
    
    for (int i =0; i < 3; i ++) {
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(i * (self.headerView.frame.size.width/3),75, self.view.frame.size.width/3, 20)];
        self.button.tag = 100 + i;
        [self.button addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.button setTitle:buttonnameArray[i] forState:UIControlStateNormal];
        if (i == 0) {
            self.button1 = self.button;
        }
        if (i == 1) {
            self.button2 = self.button;
        }
        if (i == 2) {
            self.button3 = self.button;
        }
        [self.headerView addSubview:self.button];
    }
    
    //***************

    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height - 2, self.headerView.frame.size.width, 2)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.headerView addSubview:lineImageView];
    
    return self.headerView;
    
}

#pragma mark === 设置组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(void)buttonsClick:(UIButton *)button{

    [self.OTCoverTableView removeFromSuperview];
    self.OTCoverTableView = nil;
    
    if (button.tag == 100) {
        NSLog(@"tag = 100");
        self.buttonIndex = button.tag;
        [self setmyTableView];
//*****************************
        self.button1.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
        [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.button2.backgroundColor = [UIColor whiteColor];
        [self.button2 setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
        
        self.button1.backgroundColor = [UIColor whiteColor];
        [self.button1 setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
//*****************************
     
        
        
    }else if (button.tag == 101){
        NSLog(@"tag = 101");
        self.buttonIndex = button.tag;
        [self setmyTableView];

        //*****************************
        self.button2.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.button1.backgroundColor = [UIColor whiteColor];
        [self.button1 setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
        
        self.button1.backgroundColor = [UIColor whiteColor];
        [self.button1 setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
        //*****************************
        
    
    }else{
        NSLog(@"tag = 102");
        self.buttonIndex = button.tag;
        [self setmyTableView];
        
        //*****************************
        self.button3.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
        [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.button2.backgroundColor = [UIColor whiteColor];
        [self.button2 setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
        
        self.button1.backgroundColor = [UIColor whiteColor];
        [self.button1 setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
        //*****************************
        
    
    }
    
    if (self.Datadict != nil) {
        
        NSArray * headPhotoArray = self.Datadict[@"img"];
        NSString * photostring = headPhotoArray[0][@"img"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photostring]];
        [self.OTCoverTableView setHeaderImage:[UIImage imageWithData:data]];
        
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.buttonIndex == 101) {
        NSLog(@"hehe");
        
        JuTiXiangQingViewController * JutiVc = [[JuTiXiangQingViewController alloc]init];
        
        JutiVc.lastdic = self.CanPindataArray[indexPath.row];
        
        [self.navigationController pushViewController:JutiVc animated:YES];
        
    }else if (self.buttonIndex == 102){
    
        if (indexPath.row == 2) {
            UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:self.Datadict[@"tel"] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
            self.AlertIndex = 1;
            [alerView show];
        }
        if (indexPath.row == 3) {
            UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:self.Datadict[@"utel"] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
            self.AlertIndex = 2;

            [alerView show];
        }

    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (self.AlertIndex == 1) {
    
        if (buttonIndex == 1) {
        
            NSLog(@"呼叫%@",self.Datadict[@"tel"]);
            
            UIWebView *callWebView = [[UIWebView alloc] init];
            NSURL * telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.Datadict[@"tel"]]];
            [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
            
            [self.view addSubview:callWebView];
 
            
        }
        
    }else{
        NSString * utel = self.Datadict[@"utel"];
        NSLog(@"%@",utel);
        if (buttonIndex == 1) {
         
            
            if ([utel isEqualToString:@""]) {
                
                
                UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"号码为空，无法呼叫" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];                
                [alerView show];
                
                
            }else{
            
            
            NSLog(@"呼叫%@",self.Datadict[@"utel"]);
            
            UIWebView *callWebView = [[UIWebView alloc] init];
            NSURL * telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.Datadict[@"utel"]]];
            [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
            
            [self.view addSubview:callWebView];
  
            }
        }
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
