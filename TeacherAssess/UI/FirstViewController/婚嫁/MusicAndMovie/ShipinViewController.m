//
//  ShipinViewController.m
//  Wedding
//
//  Created by hjh on 15-12-23.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "ShipinViewController.h"
#import "TQRichTextView.h"
#import "FirstNetWork.h"
#import <MediaPlayer/MediaPlayer.h>
//#import "BofangViewController.h"


@interface ShipinViewController ()


@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)TQRichTextView * XianShiLable;

@property(nonatomic,strong)NSDictionary * ShipingDetilaDic;

@property(nonatomic,strong)UIImageView * mainImageView;

@property(nonatomic)UIImageView * playLogoImage;


//*************************************
@property(nonatomic,strong)MPMoviePlayerViewController *playerControl;
@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)UIView *fontClickView;
//*************************************

@end

@implementation ShipinViewController
//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShiPingDetilaDataReturn:) name:@"ShiPingDetilaDataReturn" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)ShiPingDetilaDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
        NSLog(@"%@",dic);
    self.ShipingDetilaDic = dic[@"hxjx"];
    
    [self setkognjian];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.hxjx);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ShipingDetilaDic = [NSDictionary dictionary];
    
    
    [self getData];
    
    //添加头部导航栏
    [self headView];
    
}

-(void)getData{
    
    [FirstNetWork GetShiPingDetialDataUrlWithUrl:ShiPingDetileUrl act:@"hxjxinfo" hxjx:self.hxjx mver:@"3" page:@"1" pageper:@"10"];
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
    titleLable.text = @"精选视屏";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*********************************************/

-(void)setkognjian{
    
    self.XianShiLable = [[TQRichTextView alloc]initWithFrame:CGRectMake(15, 235, self.view.frame.size.width - 30, 50)];
    self.XianShiLable.backgroundColor = [UIColor whiteColor];
    self.XianShiLable.textColor = [UIColor blackColor];
    self.XianShiLable.font = [UIFont systemFontOfSize:14];
    self.XianShiLable.text = self.ShipingDetilaDic[@"description"];
    CGRect r = self.XianShiLable.frame;
    r.size.height = self.XianShiLable.drawheigth;
    self.XianShiLable.frame = r;
    [self.view addSubview:self.XianShiLable];
    
    
    
    
    self.mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 150)];
    [self.mainImageView setImage:[UIImage imageNamed:@"discoverz.png"]];
    
    [self.mainImageView setImageWithURL:[NSURL URLWithString:self.ShipingDetilaDic[@"default_image"]] placeholderImage:nil];
    self.mainImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.mainImageView];
    
    
    self.playLogoImage = [[UIImageView alloc]init];
    self.playLogoImage.center = CGPointMake(self.view.frame.size.width/2, self.mainImageView.frame.size.height/2);
    self.playLogoImage.bounds = CGRectMake(0, 0, 40, 40);
    self.playLogoImage.image = [UIImage imageNamed:@"play_icon.png"];
    [self.mainImageView addSubview:self.playLogoImage];
    
    
    
    UIButton * xiansbt = [[UIButton alloc]initWithFrame:CGRectMake(25, self.XianShiLable.frame.origin.y + self.XianShiLable.drawheigth + 20, 200, 20)];
    xiansbt.layer.cornerRadius = 10.0;
    xiansbt.clipsToBounds = YES;
    xiansbt.titleLabel.textAlignment = NSTextAlignmentLeft;
    xiansbt.titleLabel.font = [UIFont systemFontOfSize:13];
    xiansbt.backgroundColor = [UIColor lightGrayColor];
    xiansbt.userInteractionEnabled = NO;
    [xiansbt setImage:[UIImage imageNamed:@"img_be_exe_3@2x.png"] forState:UIControlStateNormal];
    [xiansbt setTitle:self.ShipingDetilaDic[@"team_name"] forState:UIControlStateNormal];
    
    [self.view addSubview:xiansbt];
    
    
    [self addTapGuesture];
    
}

-(void)addTapGuesture{

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    [self.mainImageView addGestureRecognizer:tap];

}

-(void)TapClick:(UITapGestureRecognizer *)tap {
    NSLog(@"手势点击事件");
    
//    bofangViewController * BofangVc = [[bofangViewController alloc]init];
//    BofangVc.videoUrl = self.ShipingDetilaDic[@"jxsp_video"];
//    
//    BofangVc.Y = YES;
//    
//    [self.navigationController pushViewController:BofangVc animated:YES];
    
    

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
