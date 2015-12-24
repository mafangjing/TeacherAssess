//
//  JuTiXiangQingViewController.m
//  Wedding
//
//  Created by ma on 15-10-24.
//  Copyright (c) 2015年 ma. All rights reserved.
//


#import "JuTiXiangQingViewController.h"
#import "FouthNetWork.h"
#import "xiangXiVcViewController.h"
#import "UMSocial.h"


@interface JuTiXiangQingViewController ()<UIAlertViewDelegate>


@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)NSDictionary * dic;

@property (weak, nonatomic) IBOutlet UIStepper *StepperControl;
@property (weak, nonatomic) IBOutlet UITextField *TextFile;
@property (weak, nonatomic) IBOutlet UIButton *GouWucheButton;
@property (weak, nonatomic) IBOutlet UIButton *BuyButton;
@property (weak, nonatomic) IBOutlet UIButton *DaDianHuaButton;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
@property (weak, nonatomic) IBOutlet UIButton *CollectButton;
@property (weak, nonatomic) IBOutlet UIButton *DetileButton;
@property (weak, nonatomic) IBOutlet UIImageView *MainImageView;
@property (weak, nonatomic) IBOutlet UILabel *FirstLable;
@property (weak, nonatomic) IBOutlet UILabel *SecondLable;
@property (weak, nonatomic) IBOutlet UILabel *thirdLable;

@end

@implementation JuTiXiangQingViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CanPinDetilaDataReturn:) name:@"CanPinDetilaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark ---- 通知返回数据
-(void)CanPinDetilaDataReturn:(NSNotification *)noti{
    self.dic = noti.object;
    NSLog(@"%@",self.dic);
    [self.MainImageView setImageWithURL:[NSURL URLWithString:self.dic[@"photo_string"][0][@"img"]] placeholderImage:nil];
    self.FirstLable.text = self.dic[@"name"];
    self.SecondLable.text = [NSString stringWithFormat:@"¥%@",self.dic[@"price"]];
    self.thirdLable.text = [NSString stringWithFormat:@"¥%@",self.dic[@"price_yj"]];
    

}

//**************************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.lastdic);
    [self.MainImageView setImageWithURL:[NSURL URLWithString:self.lastdic[@"img"]] placeholderImage:nil];
    
    [self getData];
    
    
    //添加头部导航栏
    [self headView];


}

-(void)getData{

    [FouthNetWork getFouthCanPinDetilaDataWithUrl:CanPinDetilaDataUrl appkey:@"752" idi:self.lastdic[@"id"] token:@"fe00a1e16843e0bbd899f716d01892d4"];


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
    
    
    //*******************************
    
    self.BuyButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.GouWucheButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.DaDianHuaButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    
    //********************************
    
    
    
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/

- (IBAction)XiangXiButton:(UIButton *)sender {
    
    xiangXiVcViewController * xiangXiVc = [[xiangXiVcViewController alloc]init];
    xiangXiVc.concentString = self.dic[@"concent"];
    
    [self.navigationController pushViewController:xiangXiVc animated:YES];
    
    //***********************
    self.DetileButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    [self.DetileButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    
    self.ShareButton.backgroundColor = [UIColor whiteColor];
    [self.ShareButton setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1]forState:UIControlStateNormal];
    
    self.CollectButton.backgroundColor = [UIColor whiteColor];
    [self.CollectButton setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1]forState:UIControlStateNormal];
    
    //***********************
    
    
    
    
}

- (IBAction)ChouCangButton:(id)sender {
    NSLog(@"收藏");
    //***********************
    self.CollectButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    [self.CollectButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    
    self.ShareButton.backgroundColor = [UIColor whiteColor];
    [self.ShareButton setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1]forState:UIControlStateNormal];
    
    self.DetileButton.backgroundColor = [UIColor whiteColor];
    [self.DetileButton setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1]forState:UIControlStateNormal];
    
    //***********************
    
    
}

- (IBAction)ShareButton:(UIButton *)sender {
    NSLog(@"分享");
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c629a67e58e485d00514f"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:nil];
    
    //***********************
    self.ShareButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    [self.ShareButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    
    self.CollectButton.backgroundColor = [UIColor whiteColor];
    [self.CollectButton setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1]forState:UIControlStateNormal];
    
    self.DetileButton.backgroundColor = [UIColor whiteColor];
    [self.DetileButton setTitleColor:[UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1]forState:UIControlStateNormal];
    
    //***********************

    
    
    
}

- (IBAction)DaDianHuanButton:(UIButton *)sender {
    NSLog(@"打电话");
    
    UIAlertView * AlerView = [[UIAlertView alloc]initWithTitle:self.dic[@"partner_tel"] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];

    [AlerView show];
    
    
}

- (IBAction)GouWuCheButton:(UIButton *)sender {
    NSLog(@"加入购物车");
    
}
- (IBAction)BuyButton:(UIButton *)sender {
    NSLog(@"立即购买");
    
}

//***************************************
- (IBAction)StepperClick:(UIStepper *)sender {
    
    self.TextFile.text = [NSString stringWithFormat:@"%0.f",self.StepperControl.value];
    
}

#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex = %ld",buttonIndex);
    if (buttonIndex == 1) {
        NSLog(@"呼叫%@",self.dic[@"partner_tel"]);

        UIWebView *callWebView = [[UIWebView alloc] init];
        NSURL * telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.dic[@"partner_tel"]]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        
        [self.view addSubview:callWebView];
        
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
