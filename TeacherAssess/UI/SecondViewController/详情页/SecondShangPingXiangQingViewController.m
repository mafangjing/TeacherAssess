//
//  SecondShangPingXiangQingViewController.m
//  Wedding
//
//  Created by hjh on 15-12-24.
//  Copyright (c) 2015年 hjh. All rights reserved.
//

#import "SecondShangPingXiangQingViewController.h"
#import "SecondNetWork.h"
#import "BuyOnlineViewController.h"
#import "UMSocial.h"


@interface SecondShangPingXiangQingViewController ()

@property(nonatomic,strong)UIImageView *navBarImageView;
@property(nonatomic,strong)UIButton *leftButton;

@property(nonatomic,strong)NSDictionary * DataDic;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *PriceLable;
@property (weak, nonatomic) IBOutlet UILabel *DetilaLable;
@property (weak, nonatomic) IBOutlet UILabel *hotLikeLable;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
@property (weak, nonatomic) IBOutlet UIButton *BackButton;
@property (weak, nonatomic) IBOutlet UIButton *BuyButton;
@property (weak, nonatomic) IBOutlet UIImageView *imagess;

@end

@implementation SecondShangPingXiangQingViewController

//数据返回通知
-(void)viewWillAppear:(BOOL)animated{
    //添加数据返回通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SecondDetilaDataReturn:) name:@"SecondDetilaDataReturn" object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)SecondDetilaDataReturn:(NSNotification *)noti{
    NSDictionary * dic = noti.object;
    NSLog(@"%@",dic);
    self.DataDic = dic[@"product"];
    
    [self ShowContentVc2];

}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self getData];
    
    //添加头部导航栏
    [self headView];
    [self ShowcontenVc1];
}

-(void)getData{

    [SecondNetWork GetSecondDetilaDataWithUrl:@"http://www.hunliji.com/products/" idi:[NSString stringWithFormat:@"%@.json/",self.SecondListMo.id1] user_id:@"-1"];

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
    titleLable.text = @"商品详情";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.navBarImageView addSubview:titleLable];
}
-(void)leftbutClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*********************************************/

-(void)ShowContentVc2{
    
    NSNumber *price = self.DataDic[@"price"];
    NSNumber *likecount = self.DataDic[@"like_count"];
    [self.mainImageView setImageWithURL:[NSURL URLWithString:self.DataDic[@"photo_path"]] placeholderImage:nil];
    self.DetilaLable.text = self.DataDic[@"introduce"];
    self.PriceLable.text = [NSString stringWithFormat:@"¥%@",price];
    self.hotLikeLable.text = [NSString stringWithFormat:@"%@",likecount];

}

-(void)ShowcontenVc1{
    self.ShareButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.BuyButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.BackButton.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    self.imagess.backgroundColor = [UIColor colorWithRed:255/256.0 green:51/256.0 blue:153/256.0 alpha:1];
    
    self.ShareButton.layer.cornerRadius = 10.0;
    self.ShareButton.clipsToBounds = YES;
    
    self.BuyButton.layer.cornerRadius = 10.0;
    self.BuyButton.clipsToBounds = YES;
    
    self.BackButton.layer.cornerRadius = 10.0;
    self.BackButton.clipsToBounds = YES;
    
    self.imagess.layer.cornerRadius = 10.0;
    self.imagess.clipsToBounds = YES;
    
    self.PriceLable.layer.cornerRadius = 8.0;
    self.PriceLable.clipsToBounds = YES;

}



/*********************************************/


- (IBAction)GoToBuyButtonClick:(UIButton *)sender {
    NSLog(@"去商店购买");
    
    BuyOnlineViewController * BuyOnlinVc = [[BuyOnlineViewController alloc]init];
    
    BuyOnlinVc.lastDic = self.DataDic;
    
    [self.navigationController pushViewController:BuyOnlinVc animated:YES];
    
}
- (IBAction)ShareButtonClick:(UIButton *)sender {
    
    NSLog(@"分享");
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c629a67e58e485d00514f"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:nil];
    
    
    
}
- (IBAction)BackRootVCButtonClick:(UIButton *)sender {
    NSLog(@"返回主页");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
